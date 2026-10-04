// Command commits backfills a Git repository with empty commits.
package main

import (
	"bytes"
	"errors"
	"flag"
	"fmt"
	"math/rand/v2"
	"os"
	"os/exec"
	"time"
)

const name = "commits"

const usageHeader = `Usage: go run ./cmd/commits [flags]

commits spreads empty commits over a date range starting from the
specified date and ending today, running "git commit --allow-empty"
in the current directory.

Flags:
`

// Exit codes, following the convention used by the Go tools themselves.
const (
	exitError = 1
	exitUsage = 2
)

func main() {
	os.Exit(run(os.Args[1:]))
}

func run(args []string) int {
	fs := flag.NewFlagSet(name, flag.ContinueOnError)
	fs.Usage = func() {
		fmt.Fprint(fs.Output(), usageHeader)
		fs.PrintDefaults()
	}

	startDate := fs.String("start", "", "Start date (YYYY-MM-DD)")
	perDay := fs.Int("max", 5, "Maximum number of commits per day")
	skipWeekend := fs.Bool("skip-weekend", true, "Leave Saturdays and Sundays empty")
	dryRun := fs.Bool("dry-run", false, "Report the plan without touching the repository")

	if err := fs.Parse(args); err != nil {
		if errors.Is(err, flag.ErrHelp) {
			return 0
		}
		return exitUsage
	}

	if fs.NArg() > 0 {
		fmt.Fprintf(os.Stderr, "%s: unexpected argument %q\n", name, fs.Arg(0))
		fs.Usage()
		return exitUsage
	}

	if err := validate(*startDate, *perDay); err != nil {
		fmt.Fprintf(os.Stderr, "%s: %v\n", name, err)
		fs.Usage()
		return exitUsage
	}

	start, err := time.Parse("2006-01-02", *startDate)
	if err != nil {
		fmt.Fprintf(os.Stderr, "%s: invalid start date %q\n", name, *startDate)
		return exitUsage
	}

	end := time.Now()

	// Remove the time component so the loop works with whole calendar days.
	end = time.Date(
		end.Year(),
		end.Month(),
		end.Day(),
		0, 0, 0, 0,
		end.Location(),
	)

	if start.After(end) {
		fmt.Fprintf(os.Stderr, "%s: start date cannot be in the future\n", name)
		return exitUsage
	}

	for d := start; !d.After(end); d = d.AddDate(0, 0, 1) {
		if *skipWeekend && (d.Weekday() == time.Saturday || d.Weekday() == time.Sunday) {
			continue
		}

		n := rand.IntN(*perDay + 1)
		if n == 0 {
			continue
		}

		fmt.Printf("%s: %d commit(s)\n", d.Format(time.DateOnly), n)

		if *dryRun {
			continue
		}

		for range n {
			if err := commit(d); err != nil {
				fmt.Fprintf(os.Stderr, "%s: %v\n", name, err)
				return exitError
			}
		}
	}

	return 0
}

func validate(startDate string, perDay int) error {
	if startDate == "" {
		return errors.New("-start is required")
	}

	if perDay < 1 {
		return errors.New("-max must be at least 1")
	}

	if _, err := time.Parse("2006-01-02", startDate); err != nil {
		return errors.New("-start must be in YYYY-MM-DD format")
	}

	return nil
}

func commit(d time.Time) error {
	date := d.Format(time.RFC3339)

	cmd := exec.Command(
		"git",
		"commit",
		"--allow-empty",
		"--date",
		date,
		"-m",
		fmt.Sprintf("Commit from %s", d.Format(time.DateOnly)),
	)

	// --date only backdates the author date;
	// Git takes the committer date from the environment.
	cmd.Env = append(os.Environ(), "GIT_COMMITTER_DATE="+date)

	out, err := cmd.CombinedOutput()
	if err != nil {
		return fmt.Errorf("git commit: %w: %s", err, bytes.TrimSpace(out))
	}

	return nil
}
