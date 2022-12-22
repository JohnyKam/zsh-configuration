# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gnzh"
# ZSH_THEME="powerlevel9k/powerlevel9k"

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
plugins=(git history jfrog pip)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# and install locales (in docker container add also:
# echo "LC_ALL=en_US.UTF-8" | tee -a /etc/environment
# echo "en_US.UTF-8 UTF-8" | tee -a /etc/locale.gen
# echo "LANG=en_US.UTF-8" | tee -a /etc/locale.conf
# locale-gen en_US.UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='mvim'
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

alias ll="ls -lah"
alias lg="ls -lah | grep"

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

# git aliases
git_jira_commit(){
        GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
	JIRA_TYPE=${GIT_BRANCH%/*}

	BRANCH_NAME=${GIT_BRANCH##*/}

	REV_BRANCH_NAME=`echo $BRANCH_NAME | rev`
	REV_BRANCH_NAME=${REV_BRANCH_NAME##*-}
	JIRA_PROJECT_TAG=`echo $REV_BRANCH_NAME | rev`

	REV_JIRA_PROJECT_TAG_NO=`echo $BRANCH_NAME | rev`
	REV_JIRA_PROJECT_TAG_NO=${REV_JIRA_PROJECT_TAG_NO%-*}
	REV_JIRA_PROJECT_TAG_NO=${REV_JIRA_PROJECT_TAG_NO##*-}
	JIRA_PROJECT_TAG_NO=`echo $REV_JIRA_PROJECT_TAG_NO | rev`

	case $JIRA_TYPE in
    	#cases
	    "feature" | "bugfix" | "hotfix" | "release")
		JIRA_BRANCH="$JIRA_PROJECT_TAG-$JIRA_PROJECT_TAG_NO"
	        # git commit with JIRA_BRANCH
	        git commit -m "${JIRA_BRANCH} $@"
    	    ;;

	#default
	    *)
        	JIRA_TYPE=
	        BRANCH_NAME=
	        git commit -m "$@"
	    ;;
	esac              
}

git_jira_commit_test(){
	GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
	
	JIRA_TYPE=${GIT_BRANCH%/*}

	BRANCH_NAME=${GIT_BRANCH##*/}

	REV_BRANCH_NAME=`echo $BRANCH_NAME | rev`
	REV_BRANCH_NAME=${REV_BRANCH_NAME##*-}
	JIRA_PROJECT_TAG=`echo $REV_BRANCH_NAME | rev`

	REV_JIRA_PROJECT_TAG_NO=`echo $BRANCH_NAME | rev`
	REV_JIRA_PROJECT_TAG_NO=${REV_JIRA_PROJECT_TAG_NO%-*}
	REV_JIRA_PROJECT_TAG_NO=${REV_JIRA_PROJECT_TAG_NO##*-}
	JIRA_PROJECT_TAG_NO=`echo $REV_JIRA_PROJECT_TAG_NO | rev`

	case $JIRA_TYPE in
		"feature" | "bugfix" | "hotfix" | "release")
			JIRA_BRANCH="$JIRA_PROJECT_TAG-$JIRA_PROJECT_TAG_NO"
			echo "git commit -m \"${JIRA_BRANCH} $@\""
		;;
		
		*)
			echo "git commit -m \"$@\""
		;;
	esac
}

#unset alias from git plugin
unalias gcmsg
alias gcmsg="git_jira_commit"
alias gcmsgt="git_jira_commit_test"

# Set starting dir
# cd ~/

# Add ssh keys for ssh 
#ssh-add ~/.ssh/malina 1> /dev/null 2>&1
#ssh-add ~/.ssh/shifter 1> /dev/null 2>&1
#ssh-add ~/.ssh/viofor_vpb2504 1> /dev/null 2>&1
#ssh-add ~/.ssh/viofor_vpb2503 1> /dev/null 2>&1


