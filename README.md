This tool can help you type less in the terminal.

**Empty Enter Expander** inserts a command into the prompt with a few keystrokes.

Let's say you have a lengthy Git command.
Prepare a script that will output it.

```shell
# contents of the example script
echo 'git log --pretty=format:"%h %an : %s %d" --graph'
```

Expander uses a directory where the scripts are stored.
It is called a module directory.
For instance, it can be located in `~/Tools/expander-module-one`.

Place the prepared script in the module directory within the subdirectory `g Git` and name the file `l Log`.
Note the use of lowercase letters at the beginning.
These will serve as key shortcuts.

Clone this project and configure the module directory along with the other settings.

```zsh
# contents of the "~/.zprofile" file
setopt HIST_IGNORE_SPACE
export EMPTY_ENTER_EXPANDER_MODULE_PATH="/Users/user/Tools/expander-module-one"
source ~/Tools/empty-enter-expander/zsh-function.zsh 2>/dev/null || :
zle -N empty-enter-expander
bindkey "^M" empty-enter-expander
```

Open a new shell to apply the configuration.
Hit Enter on an empty command to activate the expander.
It will open a listing of stored commands, so you do not have to remember them.
Then press the `g` and `l` keys to insert the example command into the prompt.
You can now store your own commands in a structure that you prefer.