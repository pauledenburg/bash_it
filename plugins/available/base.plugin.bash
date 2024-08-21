cite about-plugin
about-plugin 'miscellaneous tools'

sphp ()
{
    about 'change php version'
    group 'base'

    # Creator: Phil Cook
    # Modified: Andy Miller
    osx_major_version=$(sw_vers -productVersion | cut -d. -f1)
    osx_minor_version=$(sw_vers -productVersion | cut -d. -f2)
    osx_patch_version=$(sw_vers -productVersion | cut -d. -f3)
    osx_patch_version=${osx_patch_version:-0}
    osx_version=$((${osx_major_version} * 10000 + ${osx_minor_version} * 100 + ${osx_patch_version}))
    homebrew_path=$(brew --prefix)
    brew_prefix=$(brew --prefix | sed 's#/#\\\/#g')
    
    brew_array=("8.1" "8.2" "8.3")
    php_array=("php@8.1" "php@8.2" "php@8.3")
    php_installed_array=()
    php_version="php@$1"
    php_opt_path="$brew_prefix\/opt\/"
    
    # Has the user submitted a version required
    if [[ -z "$1" ]]; then
        echo "usage: sphp version [-s|-s=*] [-c=*]"
        echo
        echo "    version    one of:" ${brew_array[@]}
        echo
        return
    fi
    
    # What versions of php are installed via brew
    for i in ${php_array[*]}; do
        version=$(echo "$i" | sed 's/^php@//')
        if [[ -d "$homebrew_path/etc/php/$version" ]]; then
            php_installed_array+=("$i")
        fi
    done
    
    # Check that the requested version is supported
    if [[ " ${php_array[*]} " == *"$php_version"* ]]; then
        # Check that the requested version is installed
        if [[ " ${php_installed_array[*]} " == *"$php_version"* ]]; then
    
            # Switch Shell
            echo "Switching to $php_version"
            echo "Switching your shell"
            for i in ${php_installed_array[@]}; do
                brew unlink $i
            done
            brew link --force "$php_version"

            echo "Uninstalling xdebug"
            pecl uninstall -r xdebug > /dev/null
            echo "Installing xdebug"
            pecl install xdebug > /dev/null

            # remove the extra xdebug inclusion which is added automatically by pecl
            echo "Removing duplicate xdebug inclusion in /opt/homebrew/etc/php/${1}/php.ini"

            sed -i '' -e '/zend_extension="xdebug.so"/d' /opt/homebrew/etc/php/${1}/php.ini
    
    
    	echo ""
            php -v
            echo ""
    
            echo "All done!"
        else
            echo "Sorry, but $php_version is not installed via brew. Install by running: brew install $php_version"
        fi
    else
        echo "Unknown version of PHP. PHP Switcher can only handle arguments of:" ${brew_array[@]}
    fi
}

ips ()
{
    about 'display all ip addresses for this host'
    group 'base'
    ifconfig | grep "inet " | awk '{ print $2 }'
}

down4me ()
{
    about 'checks whether a website is down for you, or everybody'
    param '1: website url'
    example '$ down4me http://www.google.com'
    group 'base'
    curl -s "http://www.downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g'
}

myip ()
{
    about 'displays your ip address, as seen by the Internet'
    group 'base'
    res=$(curl -s ifconfig.me | grep -Eo '[0-9\.]+')
    echo -e "Your public IP is: ${echo_bold_green} $res ${echo_normal}"
}

ping8 ()
{
    about 'ping 8.8.8.8 to make sure you are connected to the internet'
    group 'base'
    ping 8.8.8.8
}

pickfrom ()
{
    about 'picks random line from file'
    param '1: filename'
    example '$ pickfrom /usr/share/dict/words'
    group 'base'
    local file=$1
    [ -z "$file" ] && reference $FUNCNAME && return
    length=$(cat $file | wc -l)
    n=$(expr $RANDOM \* $length \/ 32768 + 1)
    head -n $n $file | tail -1
}

pass ()
{
    about 'generates random password from dictionary words'
    param 'optional integer length'
    param 'if unset, defaults to 4'
    example '$ pass'
    example '$ pass 6'
    group 'base'
    local i pass length=${1:-4}
    pass=$(echo $(for i in $(eval echo "{1..$length}"); do pickfrom /usr/share/dict/words; done))
    echo "With spaces (easier to memorize): $pass"
    echo "Without (use this as the pass): $(echo $pass | tr -d ' ')"
}

pmdown ()
{
    about 'preview markdown file in a browser'
    param '1: markdown file'
    example '$ pmdown README.md'
    group 'base'
    if command -v markdown &>/dev/null
    then
      markdown $1 | browser
    else
      echo "You don't have a markdown command installed!"
    fi
}

mkcd ()
{
    about 'make a directory and cd into it'
    param 'path to create'
    example '$ mkcd foo'
    example '$ mkcd /tmp/img/photos/large'
    group 'base'
    mkdir -p "$*"
    cd "$*"
}

lsgrep ()
{
    about 'search through directory contents with grep'
    group 'base'
    ls | grep "$*"
}


pman ()
{
    about 'view man documentation in Preview'
    param '1: man page to view'
    example '$ pman bash'
    group 'base'
    man -t "${1}" | open -f -a $PREVIEW
}


pcurl ()
{
    about 'download file and Preview it'
    param '1: download URL'
    example '$ pcurl http://www.irs.gov/pub/irs-pdf/fw4.pdf'
    group 'base'
    curl "${1}" | open -f -a $PREVIEW
}

quiet ()
{
    about 'what *does* this do?'
    group 'base'
	$* &> /dev/null &
}

usage ()
{
    about 'disk usage per directory, in Mac OS X and Linux'
    param '1: directory name'
    group 'base'
    if [ $(uname) = "Darwin" ]; then
        if [ -n $1 ]; then
            du -hd $1
        else
            du -hd 1
        fi

    elif [ $(uname) = "Linux" ]; then
        if [ -n $1 ]; then
            du -h --max-depth=1 $1
        else
            du -h --max-depth=1
        fi
    fi
}

if [ ! -e $BASH_IT/plugins/enabled/todo.plugin.bash ]; 
then
    # if user has installed todo plugin, skip this...
    function t ()
    {
        about 'one thing todo'
        param 'if not set, display todo item'
        param '1: todo text'
        if [[ "$*" == "" ]] ; then
            cat ~/.t
        else
            echo "$*" > ~/.t
        fi
    }
fi

command_exists ()
{
    about 'checks for existence of a command'
    param '1: command to check'
    example '$ command_exists ls && echo exists'
    group 'base'
    type "$1" &> /dev/null ;
}

mkiso ()
{

    about 'creates iso from current dir in the parent dir (unless defined)'
    param '1: ISO name'
    param '2: dest/path'
    param '3: src/path'
    example 'mkiso'
    example 'mkiso ISO-Name dest/path src/path'
    group 'base'

    if type "mkisofs" > /dev/null; then
        [ -z ${1+x} ] && local isoname=${PWD##*/} || local isoname=$1
        [ -z ${2+x} ] && local destpath=../ || local destpath=$2
        [ -z ${3+x} ] && local srcpath=${PWD} || local srcpath=$3

        if [ ! -f "${destpath}${isoname}.iso" ]; then
            echo "writing ${isoname}.iso to ${destpath} from ${srcpath}"
            mkisofs -V ${isoname} -iso-level 3 -r -o "${destpath}${isoname}.iso" "${srcpath}"
        else
            echo "${destpath}${isoname}.iso already exists"
        fi
    else
        echo "mkisofs cmd does not exist, please install cdrtools"
    fi
}

# useful for administrators and configs
buf ()
{
    about 'back up file with timestamp'
    param 'filename'
    group 'base'
    local filename=$1
    local filetime=$(date +%Y%m%d_%H%M%S)
    cp ${filename} ${filename}_${filetime}
}

rmcrap ()
{
 find . -maxdepth 2 -name "ANTI-EIN" -o -name "*.url" -o -name "*.nzb" -o -name "*.nfo" -o -name "*.sfv" -o -name "*.srr" -o -name "*sample*" -o -name "*.rev" -o -name "*.URL" -o -name "*.DS_Store" -o -name "*Video Player*" -o -regextype sed -regex '.*/[A-Z0-9]\{7\}\.jpg' -o -empty | egrep -v '_UNPACK_' 
 read -p "want to remove files with extensions url, nzb, nfo, 'Video Player', random iamges and empty directories? [Yn] " decision

 case "$decision" in
  [nN])
   echo 'exiting on users request';
   return;
   ;;
  *)
    find . -maxdepth 2 -name "ANTI-EIN" -o -name "*.url" -o -name "*.nzb" -o -name "*.nfo" -o -name "*.sfv" -o -name "*.srr" -o -name "*sample*" -o -name "*.rev" -o -name "*.URL" -o -name "*.DS_Store" -o -name "*Video Player*" -o -regextype sed -regex '.*/[A-Z0-9]\{7\}\.jpg' -o -empty | egrep -v '_UNPACK_' | \
    while read file; do
     echo "$file";
     rm -r "$file";
    done;
    find . -type d -empty -exec rm -r "{}" \;
 esac
}
