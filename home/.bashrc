# ~/.bashrc: executed by bash(1) for non-login shells.


# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022


if [ -e ~/oh-my-posh/themes/agnoster.omp.json ] ; then
	eval "$(oh-my-posh init bash --config ~/oh-my-posh/themes/agnoster.omp.json)"
fi


if [ -e ~/.venv/bin/activate ] ; then
	source ~/.venv/bin/activate
fi


PATH=$PATH:~/.bin

# You may uncomment the following lines if you want `ls' to be colorized:
 export LS_OPTIONS='--color=always'
 eval "`dircolors`"

 # Some nice ls aliases

if [ `which lsd` ] ; then
  alias ls='lsd $LS_OPTIONS'
  alias ll='lsd $LS_OPTIONS -l'
  alias l='lsd $LS_OPTIONS -lA'
  alias lt='lsd $LS_OPTIONS --tree --depth '
fi

alias doky='docker run --rm -it -v ~/.ssh:/home/pokyuser/.ssh -v $(pwd):/workdir crops/poky:debian-10 --workdir=/workdir'

alias unfuck_cmdline='resize &>/dev/null'

# alias ssw='i=0 ; while [ 1 ] ; do ((i++)) ; echo "$((i/100/60)):$((i/100%60)):$((i%100))" ; sleep 0.01 ; done'



 # ack - auto ignore the big tmp folders in your yocto project
 alias acknb='ack --ignore-dir build --ignore-dir shared-build --ignore-dir yocto-share'

 # show xkcd comics -> close with ctrl+c -> close comic window to continue to next comic
 alias xkcd='true; while [ $? -eq 0 ]; do curl $(curl https://xkcd.com/$(shuf -i1-$(curl https://xkcd.com/info.0.json | jq -r '.num') -n1)/info.0.json | jq -r '.img') | display; done'

 # usefull xclip alias
alias copy='xclip'
alias paste='xclip -o'

 # Trusted ssh (for internal use only!)
 alias scpt="scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
 alias ssht="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
 alias sshcpk="ssh-copy-id -i ~/.ssh/id_rsa.pub"
export PROJP='/data/projects'


# Nice tool to simplify USB-tty usage
usc(){

  rate=$2
  [ "$2" == "" ] && rate=115200

  if [ -e /dev/ttyUSB$1 ] ; then
    if [ ! 'id -nG "$USER" | grep -qw "dialout"' ];  then
      sudo usermod -a -G dialout mueller
      echo "Added user '$USER' to dialout grp."
    else
      echo "Using /dev/ttyUSB$1@${rate}Hz"
      cu -l /dev/ttyUSB$1 -s $rate
    fi
  elif [ "$1" == "" ] ; then
    echo "Aviable tty's: " && ls /dev/ttyUSB*
  else
    echo "/dev/ttyUSB$1 is not aviable. Try: " && ls /dev/ttyUSB*
  fi
}

uz(){
  for file in "$@"
  do
    echo $file
    if [ ! $(echo $file | grep -E "\.zip$") ] ; then
      echo "Maybe not a zip file. Make sure there is a .zip ending."
      continue;
    fi
    dirname=$(echo $file | sed -e "s/\.zip$//g")
    mkdir $dirname
    pushd $dirname
    unzip ../$file
    popd
  done
}

uztmp(){

  file=$1
  if [ ! $(echo $file | grep -E "\.zip$") ] ; then
    echo "Maybe not a zip file. Make sure there is a .zip ending."
    continue;
  fi
  dirname=$(echo /tmp/$file | sed -e "s/\.zip$//g")
  mkdir $dirname
  file_dir=`pwd`
  cd $dirname
  unzip $file_dir/$file
  
}



# Some more alias to avoid making mistakes (Do not use -> anoying!):
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

# usage: sln <from> <to> <file>
# prints the lines <from> until <to> from <file>
sln() {
sed -n -e "$1,$(($1 + $2)) p" -e "$(($1 + $2)) q"
}

mkpath() {
  local d
  if [ $(echo $1 | cut -b 1) == "/" ] ; then
    d=/
  fi
  for i in $(echo $1 | sed 's/\// /g'); do
    d=$d$i/
    echo $d
    mkdir -p $d
  done
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/netmodule.intranet/mueller/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/netmodule.intranet/mueller/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/netmodule.intranet/mueller/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/netmodule.intranet/mueller/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

