#!/usr/bin/env bash

init_check() {
  # Check whether its a first time use or not
  if [[ -z ${DOT_REPO} && -z ${{DOT_DEST}} ]]; then
    # show first time steup menu
    # initial_steup
  else
    # repo_check
    # manage
  fi
}

initial_setup() {
  echo -e "\n\nFirst time use, Ste Up dotman"
  echo -e "...................................................\n"
  read -p "Enter dotfiles repository URL: " -r DOT_REPO
  read -p "Where should I clone $(basebane "${DOT_REPO}") (${HOME}/..): " -r DOT_DEST
  DOT_DEST=${DOT_DEST:-$HOME}
  if [[ -d "$HOME/$DOT_DEST" ]]; then
    # clone the repo in the destination directory
    if git -C "${HOME}/${DOT_DEST}" clone "${DOT_REPO}"; then
      add_env "$DOT_REPO" "$DOT_DEST"
      echo -e "\ndotman successfully configured"
      goodbye
    else
      # invalid arguments to exit, Repository Not Found
      echo -e "\n$DOT_REPO Unavailable. Exiting"
      exit 1
    fi
  else
    echo -e "\n$DOT_DEST Not a Valid directory"
    exit 1
  fi
}

add_env() {
  # export environment varialbes
  echo -e "\nExporting env variables DOT_DEST & DOT_REPO ..."

  current_shell=$(basename "$SHELL")
  if [[ $current_shell == "zsh" ]]; then
    echo "export DOT_REPO=$1" >> "$HOME"/.zshrc
    echo "export DOT_DEST=$2" >> "$HOME"/.zshrc
  elif [[ $current_shell == "bash" ]]; then
    echo "export DOT_REPO=$1" >> "$HOME"/.bashrc
    echo "export DOT_DEST=$2" >> "$HOME"/.bashrc
  else
    echo "Couldn't export DOT_REPO and DOT_DEST."
    echo "Consider exporting them manually."
    exit 1
  fi
  echo -e "Configuration for SHELL: $current_shell has been updated."
}

manage() {
  while :
  do
    echo -e "\n[1] Show diff"
    echo -e "[2] Push changed dotfiles to remote"
    echo -e "[3] Pull latest changes from remote"
    echo -e "[4] List all dotfiles"
    echo -e "[q/Q] Quit Session"
    # Default choice is [1]
    read -p "What do you want me to do? [1]: " -n 1 -r USER_INPUT
    # See Parameter Expansion
    USER_INPUT=${USER_INPUT:-1}
    case $USER_INPUT in
      [1]* ) show_diff_check;;
      [2]* ) dot_push;;
      [3]* ) dot_pull;;
      [4]* ) find_dotfiles;;
      [q/Q]* ) exit;;
      * )   printf "\n%s\n" "Invalid Input, Try Again";;
    esac
  done
}

find_dotfiles() {
  printf "\n"
  readarray -t dotfiles < <( find "${HOME}" -maxdepth 1 -name ".*" -type f )
  printf "%s\n" "${dotfiles[@]}"
}

diff_check() {
  if [[ -z $1 ]]; then
    declare -ag file_arr
  fi

  # dotfiles in repository
  readarray -t dotfiles_repo < <( find "${HOME}/${DOT_DEST}/$(basename "${DOT_REPO}")" -maxdepth 1 -name ".*" -type f )

  # check length here
  for (( i=0; i<"${#dotfiles_repo[@]}"; i++))
  do
    dotfile_name=$(basename "${dotfiles_repo[$i]}")
    # compare the HOME version of dotfile to that of repo
    diff=$(diff -u --suppress-common-lines --color=always "${dotfiles_repo[$i]}" "${HOME}/${dotfile_name}")
    if [[ $diff != "" ]]; then
      if [[ $1 == "show" ]]; then
        printf "\n\n%s" "Running diff between ${HOME}/${dotfile_name} and "
        printf "%s\n" "${dotfiles_repo[$i]}"
        printf "%s\n\n" "$diff"
      fi
      file_arr+=("${dotfile_name}")
    fi
  done
  if [[ ${#file_arr} == 0 ]]; then
    echo -e "\n\nNo Changes in dotfiles."
    return
  fi
}

show_diff_check() {
  diff_check "show"
}


