# Type less in the terminal with this tool

**Empty Enter Expander** inserts a command into the prompt with a few keystrokes.

It is currently written for the `zsh`. The `bash` version is not published yet.

## Prepare your commands

Expander uses a directory where the commands are stored.
It is called a module directory.

The module directory might be located in `~/Tools/expander-example-module`.

Let's say you have a lengthy Git command.
Prepare a script that will output it.
Place the prepared script in the module directory within the subdirectory `g Git` and name the file `l Log`.

```shell
# Contents of the example script
# Save as "~/Tools/expander-example-module/g Git/l Log"
echo 'git log --pretty=format:"%h %an : %s %d" --graph'
```

Note the use of lowercase letters at the beginning.
These will serve as key shortcuts.

You can now store your own commands in a structure that you prefer.

## Configure the tool

Clone this project and configure the module directory along with the other settings.

```zsh
# Contents of the tool's configuration
# Place it in the "~/.zprofile" file
setopt HIST_IGNORE_SPACE
export EMPTY_ENTER_EXPANDER_MODULE_PATH="/Users/user/Tools/expander-module-one"
source ~/Tools/empty-enter-expander/zsh-function.zsh 2>/dev/null || :
zle -N empty-enter-expander
bindkey "^M" empty-enter-expander
```

Open a new shell to apply the configuration.

## Usage

Hit Enter on an empty command to activate the expander.
It will open a listing of stored commands, so you do not have to remember them.
Then press the `g` and `l` keys to insert the example command into the prompt.