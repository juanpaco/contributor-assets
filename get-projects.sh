#!/usr/bin/env bash

set -e

if [ -z ${DRY_RUN+x} ]; then
  DRY_RUN=true
fi

if [ -z ${PROJECTS_HOME+x} ]; then
  echo "PROJECTS_HOME is not set"
  exit
fi

if [ -z ${GIT_AUTHORITY_PATH+x} ]; then
  echo "GIT_AUTHORITY_PATH is not set"
  exit
fi

function clone-repo {
  name=$1

  remote_repository_url="$remote_authority_path/$name.git"

  echo "Cloning: $remote_repository_url"

  clone_cmd="git clone $remote_repository_url"
  run-cmd "$clone_cmd"
}

function pull-repo {
  name=$1

  echo "Pulling: $name (master branch only)"

  dir=$name
  pushd $dir > /dev/null

  current_branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  if [ master != $current_branch ]; then
    checkout_cmd="git checkout master"
    run-cmd "$checkout_cmd"
  fi

  pull_cmd="git pull --rebase $remote_name master"
  run-cmd "$pull_cmd"

  if [ master != "$current_branch" ]; then
    co_crnt_cmd="git checkout $current_branch"
    run-cmd "$co_crnt_cmd"
  fi

  popd > /dev/null
}

source ./projects/projects.sh
source ./run-cmd.sh

working_copies=(
  "${projects[@]}"
)

remote_name=$1
if [ -z "$remote_name" ]; then
  echo "(The remote was not specified as the argument to this script. Using \"origin\" by default.)"
  remote_name="origin"
fi

remote_authority_path=$GIT_AUTHORITY_PATH

echo
echo "Getting code from $remote_authority_path"
echo "= = ="
echo

pushd $PROJECTS_HOME > /dev/null

for name in "${working_copies[@]}"; do
  echo $name
  echo "- - -"

  dir=$name

  if [ ! -d "$dir/.git" ]; then
    clone-repo $name
  else
    pull-repo $name
  fi

  echo
done

popd > /dev/null

echo "= = ="
echo "(done getting code)"

