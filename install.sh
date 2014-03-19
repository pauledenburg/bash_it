#!/usr/bin/env bash
BASH_IT="$HOME/.bash_it"

test -w $HOME/.bash_profile &&
  cp $HOME/.bash_profile $HOME/.bash_profile.bak &&
  echo "Your original .bash_profile has been backed up to .bash_profile.bak"

cp $HOME/.bash_it/template/bash_profile.template.bash $HOME/.bash_profile

echo "Copied the template .bash_profile into ~/.bash_profile, edit this file to customize bash-it"

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
   platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
fi

function load_all() {
  file_type=$1
  [ ! -d "$BASH_IT/$file_type/enabled" ] && mkdir "$BASH_IT/${file_type}/enabled"
  for src in $BASH_IT/${file_type}/available/*; do
      # strip path from the src
      filename="$(basename ${src})"

      # skip files that start with an underscore
      [ ${filename:0:1} = "_" ] && continue

      dest="${BASH_IT}/${file_type}/enabled/${filename}"
      if [ ! -e "${dest}" ]; then
          ln -s "${src}" "${dest}"
      else
          echo "File ${dest} exists, skipping"
      fi
  done
}

function load_some() {
    file_type=$1
    for path in `ls $BASH_IT/${file_type}/available/[^_]*`
    do
      if [ ! -d "$BASH_IT/$file_type/enabled" ]
      then
        mkdir "$BASH_IT/$file_type/enabled"
      fi

      # remove the path from the filename
      file_name=$(basename "$path")

      while true
      do
        read -p "Would you like to enable the ${file_name%%.*} $file_type? [Y/N] " RESP
        case $RESP in
        [yY])
          ln -s "$path" "$BASH_IT/$file_type/enabled"
          break
          ;;
        [nN])
          break
          ;;
        *)
          echo "Please choose y or n."
          ;;
        esac
      done
    done
}

for type in "apps" "aliases" "plugins" "completion"
do
  # as a default, load everything without asking
  load_all $type
  
  # while true
  # do
  #   read -p "Would you like to enable all, some, or no $type? Some of these may make bash slower to start up (especially completion). (all/some/none) " RESP
  #   case $RESP
  #   in
  #   some)
  #     load_some $type
  #     break
  #     ;;
  #   all)
  #     load_all $type
  #     break
  #     ;;
  #   none)
  #     break
  #     ;;
  #   *)
  #     echo "Unknown choice. Please enter some, all, or none"
  #     continue
  #     ;;
  #   esac
  # done
done
