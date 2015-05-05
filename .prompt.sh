. ~/.git-prompt.sh

PS1='\[\033[1;36m\][DOCER::\h]\[\033[00m\]${debian_chroot:+($debian_chroot)}\u:\w\[\033[1;31m\]$(__git_ps1)\[\033[00m\] \$ '
set -o vi
