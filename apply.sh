#!/usr/bin/env bash


scriptpath="$(cd "$(dirname "$0")" > /dev/null 2>&1; pwd -P)"

echo 'Making all directories'
find . -type d -print0 | while read -d $'\0' file
do
  file=${file:2}
  if [[ $file =~ ^\.git.* || -z $file ]]; then
    continue
  else
    echo "mkdir -p $HOME/$file"
    mkdir -p "$HOME/$file"
  fi
done

echo 'Linking all files'
find . -type f -print0 | while read -d $'\0' file
do
  file=${file:2}
  if [[ $file =~ ^\.git.* || $file == `basename $0` ]]; then
    continue
  else
    echo "ln -sf $scriptpath/$file $HOME/$file"
    ln -sf "$scriptpath/$file" "$HOME/$file"
  fi
done

