#!/bin/bash

#   This was producted to provide a quck scriptable way
#     of producting custom install images that are often
#     required for special hardware cases.
#
#     04/15/2019    Chris Scutt  chris.scutt@gmail.com

SYSTEM=$(cat /etc/os-release | grep PRETTY_NAME | tail -c +13 | tr -d \")

PREQU=(simple-cdd xorriso)
INSTALl=()

while [[ $# -gt 0]] ; do
   arg="$1";
   shift; 
   case "$arg" in
       --help|-h)
           Help
           shift
           ;;

       --rebuild|-r)
           RebuildOnly
           shift
           ;;

        --mirror|-m)
            MirrorOnly
            shift
            ;;
    esac
done


function CheckRoot () {
    # We need at least one argv, or exit postive we go
    if [ ""$#"" -ne 1 ]; then
        echo "No arguments passed to fucntion CheckRoot"
        exit 1
     fi
    # pass a argv to the fuction, what ever the argv
    # that you pass, that will return with your answer
    if ! [ $(id -u) = 0 ]; then
        eval $1="sudo"
    fi
}

function CheckPrerequsites () {
    for pkg in ${PREQU[@]} ; do
        local installed=`dpkg -l | awk -v col=2 '{print $col}' | grep ^${pkg}`
        if [ "${pkg}" == "${installed}" ] ; then
            INSTALL+=(${pkg})
        fi
    done
}

function ToInstall () {
    apt install ${INSTALL[@]}
}



#//////////////// MAIN \\\\\\\\\\\\\\\\\\\\

CheckRoot needed
echo $needed

CheckPrerequsites
echo ${INSTALL[@]}
