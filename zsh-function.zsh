# USAGE: Add to .zprofile
#
# source ~/bin/app/empty-enter-expander/zprofile-function.zsh 2>/dev/null || : 
# zle -N empty-enter-expander 
# bindkey "^M" empty-enter-expander 

empty-enter-expander () {
  local target="/Users/szabi/bin/app/kjukju-module-mike/Expander"
  local mode="Write to terminal"
  setopt HIST_IGNORE_SPACE # do not put `print -z` command to history

  if [[ -z $BUFFER ]]; then
    while true
      do

      clear

      echo "Mode: $mode"
      echo

      ls -1 $target

      echo
      echo -n "? "

      read -k LETTER

      if [[ "$LETTER" =~ '[a-zA-Z0-9]' ]]
      then
	# mindepth to exclude parent directory
        LETTER_DEST=$(find "$target" -mindepth 1 -maxdepth 1 -name "$LETTER*" -type d,l)

        if [ -z "$LETTER_DEST" ]; then
          LETTER_DEST=$(find "$target" -maxdepth 1 -name "$LETTER*" -type f)

          clear
          output="$(bash "$LETTER_DEST")"

          if [[ ${mode} = "Write to terminal" ]]; then
            zle -U " print -z '$output'"
          else
            echo "$output" | pbcopy
            echo "Copied to clipboard"
            zle accept-line
          fi

          return
        else
          target="$LETTER_DEST"
        fi
      else
        if [[ $LETTER = *[!\ ]* ]]; then
          # variable contains characters other than space
          echo "Notice: Unknown character"
        else
          # variable consists of spaces only
          if [[ ${mode} = "Write to terminal" ]]; then
            mode="Copy to clipboard"
          else
            mode="Write to terminal"
          fi
        fi
      fi

    done

  else
    zle accept-line
  fi
}
