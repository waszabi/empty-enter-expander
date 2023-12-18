# USAGE: Add to .zprofile
#
# source ~/bin/app/empty-enter-expander/zprofile-function.zsh 2>/dev/null || : 
# zle -N empty-enter-expander 
# bindkey "^M" empty-enter-expander 

empty-enter-expander () {
  local target="/Users/szabi/bin/app/kjukju-module-mike/Expander"

  if [[ -z $BUFFER ]]; then
    while true
      do

      clear

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
          zle -U "print -z '$output'"

          return
        else
          target="$LETTER_DEST"
        fi
      else
        echo "Notice: Unknown character"
      fi

    done

  else
    zle accept-line
  fi
}
