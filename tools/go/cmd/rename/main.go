// Command rename is a bulk file renaming utility.
package main

import (
	"errors"
	"flag"
	"fmt"
	"os"
)

const name = "rename"

const usage = `Usage: go run ./cmd/rename [flags]

rename applies a renaming rule to a set of files.

Flags:
  -h, --help  Show this help message.
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
	fs.Usage = func() { fmt.Fprint(fs.Output(), usage) }

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

	fmt.Fprintf(os.Stderr, "%s: not implemented yet\n", name)
	return exitError
}
