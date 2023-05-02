# setup-gh
This action sets up [GitHub Cli (gh)](https://github.com/cli/cli) into the CI environment. 

This is normally not required as GitHub's hosted runner image [already includes it](https://github.com/actions/runner-images/blob/main/images/linux/Ubuntu2204-Readme.md#cli-tools),
but will become handy if you [use a customer container](https://docs.github.com/en/actions/using-jobs/running-jobs-in-a-container).
However, as custom containers [are only allowed on linux runners](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idcontainer), 
this action will only attempt an install on linux (given if its not in path).

Beside ensuring GitHub Cli is installed, this action also sets up the environment for the CLI to operate. 
Mainly, setting `GH_TOKEN` and `GH_REPO` [environment variables](https://cli.github.com/manual/gh_help_environment) with appropriate values.

## Example usage
```yaml
name: Create Issue
on: push
jobs:
  test:
    name: Create Issue
    runs-on: ubuntu-latest
    # This image will be pulled from docker, 
    # therefore, it will (likely) not include gh
    container: ubuntu:latest
    steps:
      - name: Setup gh
        uses: wusatosi/setup-gh@v1

      - name: Open issue
        run: gh issue create --title "I found a bug" --body "Nothing works"
```

## Inputs
### Token:
This value sets `GH_TOKEN` environment variable, 
which defaults to `${{ github.token }}`.
This is the access control token passed to Cli.

```yaml
- name: Setup gh
  uses: wusatosi/setup-gh@v1
  with:
    token: ghp_xxxxxxxxxxxxx
```

### Repository:
This value sets `GH_REPO` environment variable,
which defaults to `${{ github.repository }}` (the repository of the triggered workflow).
This is the repository the Cli will operate over.

```yaml
- name: Setup gh
  uses: wusatosi/setup-gh@v1
  with:
    repository: wusatosi/Test
```
