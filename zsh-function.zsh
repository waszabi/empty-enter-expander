# Usage: Add and adapt the lines below to the .zprofile
#
# export EMPTY_ENTER_EXPANDER_MODULE_PATH="/Users/user/expander-module-path"
# source ~/Tools/empty-enter-expander/zsh-function.zsh 2>/dev/null || :
# zle -N empty-enter-expander 
# bindkey "^M" empty-enter-expander 

empty-enter-expander () {
  local target="$EMPTY_ENTER_EXPANDER_MODULE_PATH"

  # do not put the " print -z" command with leading space into history
  setopt HIST_IGNORE_SPACE

  if [[ ! -z $BUFFER ]]; then
    # execute the command that was entered
    zle accept-line
  else
    while true; do
      clear

      echo "Empty Enter Expander"
      echo

      ls -1 $target

      echo
      echo -n "? "

      read -k LETTER

      if [[ "$LETTER" =~ '[a-zA-Z0-9]' ]]; then
        # use depth parameters to search in the current directory only
        LETTER_DEST=$(find "$target" -mindepth 1 -maxdepth 1 -name "$LETTER*")

        if [[ -d "$LETTER_DEST" ]]; then # directory
          target="$LETTER_DEST"
        elif [[ -f "$LETTER_DEST" ]]; then # file
          clear
          output="$(bash "$LETTER_DEST")"

          # do nothing on empty output
          [[ -z $output ]] && zle reset-prompt && return

          enter=$'\r' # carriage return character
          #enter="`echo -e '\r'`" # literal representation
          zle -U " print -z '$output' && clear$enter"

          return
        else # empty find result
          clear

          echo "ERROR: Not a directory nor a file"
          zle reset-prompt

          return
        fi
      else # other than alphanumeric character was pressed
        clear

        if [[ $LETTER = *[!\ ]* ]]; then # not a space was pressed
          if [[ "$LETTER" == $'\t' ]]; then
            echo "ERROR: Tab key was pressed"
          else
            echo "ERROR: Unknown character was pressed"
          fi
        else # space was pressed
          echo "ERROR: Space bar was pressed"
        fi

        zle reset-prompt
        return
      fi
    done
  fi
}
