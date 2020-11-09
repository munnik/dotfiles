#!/usr/bin/env bash

cd `dirname $0`
path=$HOME

echo 'Making all directories'
find . -type d -print0 | while read -d $'\0' file
do
  file=${file:2}
  if [[ $file =~ ^\.git.* || -z $file ]]; then
    continue
  else
    echo "mkdir -p $path/$file"
    mkdir -p "$path/$file"
  fi
done

echo 'Linking all files'
find . -type f -print0 | while read -d $'\0' file
do
  file=${file:2}
  if [[ $file =~ ^\.git.* || $file == `basename $0` ]]; then
    continue
  else
    echo "ln -sf $file $path/$file"
    ln -sf "$file" "$path/file"
  fi
done

