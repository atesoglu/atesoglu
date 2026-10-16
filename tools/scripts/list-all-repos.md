# List Azure DevOps repository clone commands

This script lists SSH `git clone` commands for all Azure DevOps Git repositories that your signed-in account can access in a specified organization. **It only prints commands; it does not clone repositories or change local files.**

## Prerequisites

1. **Azure CLI** (`az`) installed.
2. The Azure DevOps CLI extension installed.
3. **Git** installed if you intend to run the generated clone commands.
4. **Python 3** installed; the script uses it to URL-encode project and repository names that contain spaces or other reserved characters.
5. Permission to view the relevant Azure DevOps projects and repositories.
6. For cloning with SSH, an SSH public key configured in Azure DevOps and an SSH agent/client set up on your machine.

Install the Azure DevOps CLI extension:

```bash
az extension add --name azure-devops
```

Sign in:

```bash
az login
```

If your organization requires a particular Azure DevOps account or your default organization differs, the script still explicitly targets the organization supplied on the command line.

## Run the script

Make the script executable:

```bash
chmod +x list-all-repos.sh
```

Pass the organization identifier from its URL. For example, if the organization URL is `https://dev.azure.com/contoso`, use `contoso`:

```bash
./list-all-repos.sh contoso
```

The output will look like:

```bash
git clone git@ssh.dev.azure.com:v3/contoso/Platform/api-service
git clone git@ssh.dev.azure.com:v3/contoso/Shared%20Libraries/logging
```

The organization argument is used for both the Azure DevOps API URL and the SSH clone URL. Use the organization identifier, not the full URL.

## Save the commands to a file

To save the generated commands instead of displaying them:

```bash
./list-all-repos.sh contoso > clone-commands.txt
```

The script sends warnings and errors to standard error, so the output file should contain only the generated commands.

Review the file before running any commands. To execute the commands later, run them from the directory where you want the repositories created:

```bash
bash clone-commands.txt
```

Each command creates a directory for its repository in the current working directory. If repositories with duplicate names exist in different projects, consider running commands in separate project directories or editing the generated commands to avoid local directory-name collisions.

## Authentication and SSH

- `az login` authenticates the Azure CLI for project/repository discovery.
- SSH cloning uses a separate SSH authentication path. Configure your SSH key in Azure DevOps and verify it before running the generated commands.
- The script does not use or store a Personal Access Token.
- Only projects and repositories visible to your signed-in identity can be listed.

## Troubleshooting

- **`az: command not found`**: Install Azure CLI and ensure it is on your `PATH`.
- **Azure DevOps extension/command missing**: Run `az extension add --name azure-devops`.
- **Project listing fails**: Run `az login`, then verify you can access the organization and its projects.
- **Repository listing fails for a project**: Check your permissions for that project; the script reports a warning and continues.
- **SSH clone fails**: Check your SSH key setup and test SSH authentication with Azure DevOps.
