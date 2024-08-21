cite about-alias
about-alias 'general aliases'

alias bi='bash-it'
alias bisa='bash-it show aliases'
alias bisall='bash-it show aliases; bash-it show completions; bash-it show plugins'
alias bisc='bash-it show completions'
alias bisp='bash-it show plugins'
alias biep='bash-it enable plugin'
alias biea='bash-it enable alias'
alias biec='bash-it enable completion'

alias bp='source ~/.bash_profile'
alias ebi='cd ~/.bash_it; pstorm .'

# List directory contents
alias sl=ls
alias la='ls -AFG'       # show hidden
alias ll='ls -lG'
alias lla='ls -laG'
alias l='ls -aG'
alias l1='ls -1'
alias lrt='ls -lrtG '
alias lart='ls -lartG '

alias lrtlog='ls -lart /var/log'
alias a2lrtlog='ls -lart /var/log/apache2'
alias a2lrt='ls -lart /etc/apache2/sites-enabled'

alias _="sudo"

alias j="jump "

if [ $(uname) = "Linux" ]
then
  alias ls="ls --color=auto"
fi
which gshuf &> /dev/null
if [ $? -eq 1 ]
then
  alias shuf=gshuf
fi

alias c='clear'
alias k='clear'
alias cls='clear'

alias edit="$EDITOR"
alias pager="$PAGER"

alias q='exit'

alias irc="$IRC_CLIENT"

alias rb='ruby'

alias ..='cd ..'         # Go up one directory
alias ...='cd ../..'     # Go up two directories
alias ....='cd ../../..' # Go up three directories
alias -- -='cd -'        # Go back

alias e='./dev'
alias a='./dev artisan'

# Shell History
alias h='history | grep '

# Tree
if [ ! -x "$(which tree 2>/dev/null)" ]
then
  alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
fi

# Directory
alias	md='mkdir -p'
alias	rd='rmdir'

# Chrome
alias chrome='/usr/bin/open -a "/Applications/Google Chrome.app"'

# open directory in PHPStorm: pstorm .
alias pstorm='open -a PhpStorm'

alias p='php -dxdebug.mode=off vendor/bin/pest --parallel'
alias pf='php -dxdebug.mode=off vendor/bin/pest --filter'
