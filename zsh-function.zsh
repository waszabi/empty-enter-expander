# USAGE: Add to .zprofile
#
# source ~/bin/app/empty-enter-expander/zprofile-function.zsh 2>/dev/null || : 
# zle -N empty-enter-expander 
# bindkey "^M" empty-enter-expander 

empty-enter-expander () {
  local target="/Users/szabi/Tools/expander-module-mike"

  # do not put the " print -z" command with leading space into history
  setopt HIST_IGNORE_SPACE

  if [[ ! -z $BUFFER ]]; then
    # execute the command that was entered
    zle accept-line
  else
    while true; do
      clear

      ls -1 $target

      echo
      echo -n "? "

      read -k LETTER

      if [[ "$LETTER" =~ '[a-zA-Z0-9]' ]]; then
        # use depth parameters to search in the current directory only
        LETTER_DEST=$(find "$target" -mindepth 1 -maxdepth 1 -name "$LETTER*" -type d,l)

        if [ -z "$LETTER_DEST" ]; then
          LETTER_DEST=$(find "$target" -mindepth 1 -maxdepth 1 -name "$LETTER*" -type f)

          clear
          output="$(bash "$LETTER_DEST")"

          # do nothing on empty output
          [[ -z $output ]] && zle reset-prompt && return

          zle -U " print -z '$output'"

          return
        else
          target="$LETTER_DEST"
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
