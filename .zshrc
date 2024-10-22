# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

export TERM="xterm-256color"
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
if [[ -n $SSH_CONNECTION ]]; then
    ZSH_THEME="bira"
else
    ZSH_THEME="powerlevel10k/powerlevel10k"
fi
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_NODE_VERSION_BACKGROUND='28'
POWERLEVEL9K_NODE_VERSION_FOREGROUND='15'
POWERLEVEL9K_BACKGROUND_JOBS_ICON='\uf0ae'
POWERLEVEL9K_VCS_STAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_UNTRACKED_ICON='\u25CF'
POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\u2193'
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\u2191'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'
POWERLEVEL9K_STATUS_OK_BACKGROUND="black"
POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="black"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status background_jobs root_indicator dir vcs battery virtualenv dpower)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time kubecontext rbenv time)
POWERLEVEL9K_CHANGESET_HASH_LENGTH=6
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX=" ❯ "

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[comment]=fg=blue,bold
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive complet'ion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=3

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting docker docker-compose alias-tips)

source $ZSH/oh-my-zsh.sh


export PATH="$PATH:."
export PATH=$PATH:$HOME/bin
export PATH=$PATH:/home/brunobbs/.local/share/gem/ruby/3.0.0/bin
export PATH=$PATH:$HOME/Documents/IC/FLAME/xparser
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/go/bin

export FLAME_XPARSER_DIR=$HOME/Documents/IC/FLAME/xparser

alias pacman='pacman --color always'
alias ggc='git gcommit'

alias vim='nvim'
alias c='code -r .'
alias login='/home/brunobbs/Documents/Cobliteam/dev-setup/aws-login.sh && yawsso'
alias rcode='code --folder-uri "vscode-remote://k8s-container%2Bcontext%3Dcobli-development%2Bpodname%3Dbruno-scholl-vscode-remote-ide-0%2Bnamespace%3Dbruno-scholl%2Bname%3Dbruno-scholl-vscode-remote-ide/home/node"'
alias kx='kubectx'
alias kns='kubens'
alias k='kubectl config current-context; kubectl'
alias note='notefun '
alias notes='code -n -g ~/Documents/notes/'
alias extbrt='sudo ddcutil setvcp 10'
alias docklog='aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 911383825788.dkr.ecr.us-east-1.amazonaws.com'
alias vpnon='bash -c "openvpn3 session-start --config cobli-vpn; sleep 10800; openvpn3 session-manage --disconnect  --config cobli-vpn;" &'
alias vpnoff='openvpn3 session-manage --disconnect  --config cobli-vpn'
alias noturbo='echo 1 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo'
alias turbo='echo 0 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo'
alias fanreset='for i in {1..7}; do i8kfan -1 0 > /dev/null 2>&1; sleep 0.5; done'
alias k9s='/usr/bin/k9s --context $(kubectl config current-context) --all-namespaces -r1'
alias tf='terraform'
alias tfin='terraform init'
alias tfpl='terraform plan'
alias tfap='terraform apply' 
alias lowpower='sudo x86_energy_perf_policy --epb 15; sudo x86_energy_perf_policy --hwp-epp 255; sudo x86_energy_perf_policy --hwp-min 4 --hwp-max 39;'
alias normalpower='sudo x86_energy_perf_policy --epb 6; sudo x86_energy_perf_policy --hwp-epp 128; sudo x86_energy_perf_policy --hwp-min 4 --hwp-max 39;'
alias superpower='set -x; sudo x86_energy_perf_policy --epb 0; sudo x86_energy_perf_policy --hwp-epp 0; sudo x86_energy_perf_policy --hwp-min 39 --hwp-max 39; sudo intel-undervolt apply; set +x'
alias task='go-task'

export AWS_PROFILE=cobli-tech
export SBT_OPTS="-Xms512M -Xmx3096M -Xss2M -XX:MaxMetaspaceSize=3096M"

function rm()
{
    kioclient move $@ trash:/
}

function notefun()
{
    notefile=~/Documents/notes/$(date +"%Y_(%m)%B_%d_%a" -d "$1" ).md
    echo "Opening $notefile" 
    if [ ! -f $notefile ]; then
        echo "# vim: tabstop=2 shiftwidth=2 expandtab" >> "$notefile";
    fi
    code -n -g "$notefile":5000
}


alias uncompress='extract'
alias decompress='extract'
function extract()      # Handy Extract Program
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}



# Function for coloring kubectl output
function kube() {
    if test -t 1; then
        # see if it supports colors
        ncolors=$(tput colors)
        if test -n "$ncolors" && test $ncolors -ge 8; then
            bold="$(tput bold)"
            underline="$(tput smul)"
            standout="$(tput smso)"
            normal="$(tput sgr0)"
            black="$(tput setaf 0)"
            red="$(tput setaf 1)"
            green="$(tput setaf 2)"
            yellow="$(tput setaf 3)"
            blue="$(tput setaf 4)"
            magenta="$(tput setaf 5)"
            cyan="$(tput setaf 6)"
            white="$(tput setaf 7)"
        fi
        function pod_num() {
            pods=$(echo $1 | awk '{ print $2 }')
            if ! [[ $pods =~ "([0-9]+\/[0-9]+)" ]]; then
                return;
            fi

            podsl=$(echo $pods | sed -E "s/\/.*//g") || 0
            podsr=$(echo $pods | sed -E "s/.*\///g") || 0
            let "dif= $podsr - $podsr"
            
            export pods_good=$cur
            if [ "$dif" -gt "0" ]; then export pods_good=$yellow; fi
            
        }
        function hl() {
            while read line
            do
                pod_num $line
                echo $line \
                | sed -E "s/([0-9]+\/[0-9]+)/${pods_good} \1 ${cur}/g" \
                | sed "s/Running/${green}Running${cur}/g" \
                | sed "s/Pending/${yellow}Pending${cur}/g" \
                | sed "s/Completed/${blue}Completed${cur}/g" \
                | sed "s/Error/${red}Error${cur}/g" \
                | sed "s/CrashLoopBackOff/${red}CrashLoopBackOff${cur}/g" \
                | sed "s/Evicted/${blue}Evicted${cur}/g" \
                | sed "s/Warning/${yellow}Warning${cur}/g" \
                | sed "s/Normal/${green}Normal${cur}/g" \
                | sed "s/Bound/${green}Bound${cur}/g" 
            done
        }
        function colorize() {
            while read line
            do
              export cur=$white
              echo -e "${white}$line${normal}" | hl
              read line
              export cur=$cyan
              echo -e "${cyan}$line${normal}" | hl
            done
        }
        
    fi

    kubectl "$@" | colorize
}

function aws_env() {
export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id --profile cobli-sso);
export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key --profile cobli-sso);
export AWS_DEFAULT_REGION=$(aws configure get region --profile cobli-sso);
echo "cobli-sso credentials environment variables exported";
}

autoload -Uz compinit && compinit
# User configuration

zstyle ':completion:*' rehash true

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# This turns on or off prompt refreshing (real time updates)
#TMOUT=1
#TRAPALRM() {
#   zle reset-prompt
#}

source /usr/share/nvm/init-nvm.sh

unsetopt share_history

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
