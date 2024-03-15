# If you come from bash you might have to change your $PATH.
export PATH="$HOME/.local/bin:/usr/games:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="gnzh"
# ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="powerlevel10k/powerlevel10k"

# POWERLEVEL9K_DISABLE_RPROMPT=true
# POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="▶ "
# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=1

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git history jfrog pip docker zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# and install locales (in docker container add also:
# echo "LC_ALL=en_US.UTF-8" | tee -a /etc/environment
# echo "en_US.UTF-8 UTF-8" | tee -a /etc/locale.gen
# echo "LANG=en_US.UTF-8" | tee -a /etc/locale.conf
# locale-gen en_US.UTF-8
# dpkg-reconfigure locales
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='code --wait'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias alrel=". ~/.zshrc && echo 'zsh aliases from ~/.zshrc reloaded.'"

export LS_OPTIONS='--color=auto'
eval "$(dircolors)"
unalias l
alias l="ls -lah $LS_OPTIONS"
alias ll="l"
alias lg="ls -lah $LS_OPTIONS | grep"

system-upgrade(){
	SYSTEM_INFO=$(uname -o)
	case $SYSTEM_INFO in
			"Darwin")
					brew update && brew upgrade
			;;

			"GNU/Linux")
					sudo apt-get update && sudo apt-get upgrade
			;;

			*)
					echo "Uknown operating system"
			;;
	esac
}

# python command
alias py='python3'

# conan aliases
conan_search_remote(){
        conan search "$@" -r goandlearn-main-conan
}

conan_search(){
        conan search "$@"
}

conan_clear_local_cache(){
        conan remove "$@" -f
}
alias consrr="conan_search_remote"
alias consr="conan_search"
alias conclear="conan_clear_local_cache"

git_branch_name(){
	NAME=${1}
	NAME=${NAME/Ą/A}
	NAME=${NAME/Ć/C}
	NAME=${NAME/Ę/E}
	NAME=${NAME/Ł/L}
	NAME=${NAME/Ń/N}
	NAME=${NAME/Ó/O}
	NAME=${NAME/Ś/S}
	NAME=${NAME//+([ŻŹ])/Z}

	NAME=${NAME/ą/a}
	NAME=${NAME/ć/c}
	NAME=${NAME/ę/e}
	NAME=${NAME/ł/l}
	NAME=${NAME/ń/n}
	NAME=${NAME/ó/o}
	NAME=${NAME/ś/s}
	NAME=${NAME//+([żź])/z}

	echo ${NAME}
}

# git aliases
git_jira_commit(){
	GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

	JIRA_TYPE=${GIT_BRANCH%/*}

	BRANCH_NAME=${GIT_BRANCH##*/}

	BRANCH_NAME=`git_branch_name $BRANCH_NAME`

	REV_BRANCH_NAME=`echo $BRANCH_NAME | rev` 

	if [[ ! $REV_BRANCH_NAME ]]; then
		echo "Error!"
	else
		REV_BRANCH_NAME=${REV_BRANCH_NAME##*-}
		JIRA_PROJECT_TAG=`echo $REV_BRANCH_NAME | rev`

		REV_JIRA_PROJECT_TAG_NO=`echo $BRANCH_NAME | rev`
		REV_JIRA_PROJECT_TAG_NO=${REV_JIRA_PROJECT_TAG_NO%-*}
		REV_JIRA_PROJECT_TAG_NO=${REV_JIRA_PROJECT_TAG_NO##*-}
		JIRA_PROJECT_TAG_NO=`echo $REV_JIRA_PROJECT_TAG_NO | rev`


		case $JIRA_TYPE in
			"feature" | "bugfix" | "hotfix" | "release")
				JIRA_BRANCH="$JIRA_PROJECT_TAG-$JIRA_PROJECT_TAG_NO"
				git commit -m "${JIRA_BRANCH} $@" -e
			;;
			
			*)
				git commit -m "$@" -e
			;;
		esac
	fi            
}

git_jira_commit_test(){
	GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
	
	JIRA_TYPE=${GIT_BRANCH%/*}

	BRANCH_NAME=${GIT_BRANCH##*/}

	BRANCH_NAME=`git_branch_name $BRANCH_NAME`

	REV_BRANCH_NAME=`echo $BRANCH_NAME | rev` 

	if [[ ! $REV_BRANCH_NAME ]]; then
		echo "Error!"
	else
		REV_BRANCH_NAME=${REV_BRANCH_NAME##*-}
		JIRA_PROJECT_TAG=`echo $REV_BRANCH_NAME | rev`

		REV_JIRA_PROJECT_TAG_NO=`echo $BRANCH_NAME | rev`
		REV_JIRA_PROJECT_TAG_NO=${REV_JIRA_PROJECT_TAG_NO%-*}
		REV_JIRA_PROJECT_TAG_NO=${REV_JIRA_PROJECT_TAG_NO##*-}
		JIRA_PROJECT_TAG_NO=`echo $REV_JIRA_PROJECT_TAG_NO | rev`


		case $JIRA_TYPE in
			"feature" | "bugfix" | "hotfix" | "release")
				JIRA_BRANCH="$JIRA_PROJECT_TAG-$JIRA_PROJECT_TAG_NO"
				echo "git commit -m \"${JIRA_BRANCH} $@\" -e"
			;;
			
			*)
				echo "git commit -m \"$@\" -e"
			;;
		esac
	fi
}

git_tag_delete_local_and_remote(){
	git push --delete origin "$@" && git tag -d "$@"
}

git_tag_add_local_and_remote(){
	git tag "$@" && git push origin "$@"
}

git_tag_unittest_add_local_and_remote(){
	ERROR=
	UT_TAGS=`gtv | grep "UnitTests"`
	UT_TAG=`echo $UT_TAGS | cut -d "-" -f2`
	UT_TAG=`echo "${UT_TAG##*$'\n'}"`
	UT_TAG=$(($UT_TAG+1))
	if [ $UT_TAG -lt 10 ]; then
		UT_TAG="000"$UT_TAG
	elif [ $UT_TAG -lt 100 ]; then
		UT_TAG="00"$UT_TAG
	elif [ $UT_TAG -lt 1000 ]; then
		UT_TAG="0"$UT_TAG
	elif [ $UT_TAG -lt 9999 ]; then
		UT_TAG=$UT_TAG
	else
		echo "Error!: $UT_TAG"
		ERROR=1
	fi

	if [[ -z $ERROR ]] && git tag "UnitTests-$UT_TAG" && git push origin "UnitTests-$UT_TAG"
}

git_tag_package_add_local_and_remote(){
	git tag "Package-$@" && git push origin "Package-$@"
}

git_tag_conan_package_add_local_and_remote(){
	git tag "CreatePackage-$@" && git push origin "CreatePackage-$@"
}

git_tag_conan_package_add_local_and_remote(){
	PKG_VER=$(conan inspect --raw name .)
	git_tag_conan_package_add_local_and_remote $PKG_VER
}

git_push_local_branch_to_remote(){
	git push --set-upstream origin "$@"
}

git_tag_python_package_add_local_and_remote(){
	if [[ -f "setup.py" ]]; then
		PKG_VER=$(python3 setup.py --version)
		echo $PKG_VER
	else
		echo "Not in a python package directory!!"
	fi
}

#unset alias from git plugin
unalias gcmsg
alias gcmsg="git_jira_commit"
alias gcmsgt="git_jira_commit_test"
alias gtrm="git_tag_delete_local_and_remote"
alias gtaut="git_tag_unittest_add_local_and_remote"
alias gtapkg="git_tag_package_add_local_and_remote"
alias gtacpkg="git_tag_conan_package_add_local_and_remote"
alias gtapypkg="git_tag_python_package_add_local_and_remote"
alias gpb="git_push_local_branch_to_remote"

alias gcgchs="git config --global credential.helper store"

# Set starting dir
# cd ~/

# Add ssh keys for ssh 
#ssh-add ~/.ssh/malina 1> /dev/null 2>&1
#ssh-add ~/.ssh/shifter 1> /dev/null 2>&1
#ssh-add ~/.ssh/viofor_vpb2504 1> /dev/null 2>&1
#ssh-add ~/.ssh/viofor_vpb2503 1> /dev/null 2>&1

# bash history settings
export PROMPT_COMMAND='history -a'
export HISTSIZE=999999999999
export HISTFILESIZE=$HISTSIZE

# Colors
# usage: echo -e "${COLOR_RED}This is red.${COLORRESET} ${BOLD_COLOR_GREEN}And this is bold green${COLOR_RESET}"
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
BOLD_COLOR_RED='\033[1;31m' 
BOLD_COLOR_GREEN='\033[1;32m'
COLOR_RESET='\033[0m'

#Docker vs code extension reset
vs_code_ext_reset() {
	VS_CODE_CPPTOOLS_PATH="/root/.vscode-server/extensions/ms-vscode.cpptools-1.14.5-linux-x64/bin/"
	chmod u+x $VS_CODE_CPPTOOLS_PATH"cpptools"
	chmod u+x $VS_CODE_CPPTOOLS_PATH"cpptools-srv"
	chmod u+x $VS_CODE_CPPTOOLS_PATH"cpptools-wordexp"
}
[[ -d "$VS_CODE_CPPTOOLS_PATH" ]] && vs_code_ext_reset

# required cowsay and fortune apps :-)
cowsay_msg(){
	which cowsay 1>/dev/null 2>&1 && which fortune 1>/dev/null 2>&1 && fortune | cowsay -f dragon 2>/dev/null
}

cowsay_msg

