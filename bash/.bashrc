#
# ~/.bashrc
#

[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	alacritty|xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

#alias cp="cp -i"                          # confirm before overwriting something
#alias df='df -h'                          # human-readable sizes
#alias free='free -m'                      # show sizes in MB
#alias np='nano -w PKGBUILD'
#alias more=less

xhost +local:root > /dev/null 2>&1

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

###########
# TODO: My absolute "essentials". Find a better place for this & improve!
###########
set -o vi

alias g='git'
# I used to have a 'gs' alias for `git status`. Turns out, that's an actual
# binary, and I've accidentally started it about 1000 times. This effectively
# just prevents me from being able to do that!
alias gs='echo DERP!'
alias ll='lsd -la'

alias kc='kubectl'
alias dc='docker-compose'
alias lzd='lazydocker'
alias lzg='lazygit'

# Open Neovim with PWD set to ~/dotfiles as fuzzy finding root.
#
# Technically there's a Unix `dot` bin, but I'm fine clobbering it until there's
# a reason to need it. `dot` is much easier to type vs something like `dotf`.
alias dot="nvim '+lcd $HOME/dotfiles'"

NOTES_DIR="$HOME/notes"
JOURNAL_DIR="$NOTES_DIR/journal"

# Use the directory of the file being opened as `pwd` rather than that of the
# spawning terminal.
VIM_CD='+lcd %:p:h'

# [G]et [T]hings [D]one
#
# A little mini-hub of nvim splits that manage my daily life. This function
# saves me the effort of doing all of this manually, each/every time.
gtd () {
  local TODAY="$(date --rfc-3339=date).md"
  local YESTERDAY="$(date --date='yesterday' --rfc-3339=date).md"

  PARAMS=(
    "$NOTES_DIR/todo.txt"           # First, open up my todo.txt file.
    "$VIM_CD"                       # Then, change `pwd` of that buffer to be $NOTES_DIR.
    "+sp $JOURNAL_DIR/$TODAY"       # Split horizontally and open up a journal entry for today.
    "$VIM_CD"                       # Set our `pwd` to be $JOURNAL_DIR.
    "+vsp $JOURNAL_DIR/$YESTERDAY"  # Vertically split the journal entry with yesterday's.
    "$VIM_CD"                       # Set our `pwd` to be $JOURNAL_DIR.
  )

  nvim "${PARAMS[@]}"
}

# Open Neovim with PWD set to $NOTES_DIR as fuzzy finding root.
alias notes="nvim '+lcd $NOTES_DIR'"
# Open an ephemeral scratchpad for quick thoughts.
alias qn="nvim '$VIM_CD' $NOTES_DIR/tmp.md" # [q]uick [n]ote
# Use todo.txt spec to capture todos.
alias todo="nvim '$VIM_CD' $NOTES_DIR/todo.txt"
# Open a new journal entry, e.g. journal/2022-07-23.md
alias jrnl="nvim '$VIM_CD' $JOURNAL_DIR/$(date --rfc-3339=date).md"

# Starship prompt
eval "$(starship init bash)"
