#!/bin/bash

#   This was producted to provide a quck scriptable way
#     of producting custom install images that are often
#     required for special hardware cases.
#
#     04/15/2019    Chris Scutt  chris.scutt@gmail.com

SYSTEM=$(cat /etc/os-release | grep PRETTY_NAME | tail -c +13 | tr -d \")
RELASE=$( cat /etc/os-release | grep VERSION+ | tail -c +13 | tar -d \)\")
PROFILE="headless.conf"
DIST="stretch"

Yellow="\e[33m"
Blue="\e[34m"
Red="\e[31m"
Bold="\e[1m"
Reset="\e[0m"

PREQU=(simple-cdd xorriso)
INSTALL=()

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

function RebuildOnly () {
    build-simple-cdd --config profiles/${PROFILE} --no-do-mirror --dist ${DIST}
}

function PrintHelp {
    printf "\n"
    printf "Usage for %s:\n" $0
    printf "\n"
    printf "\t${Yellow}${Bold} --redbuild | -r\n${Reset}"
    printf "\t\t This simply rebuilds the image usingt the existing mirror\n"
    printf "\t\t assuming a fresh build has already happened. \n"
    printf "\n"
    printf "\t${Yellow}${Bold} --mirror | -m\n${Reset}"
    printf "\t\t This will only build the mirror used to create the imaage\n"
    printf "\t\t but no image will be producted \n"
    printf "\n"
    printf "\t${Yellow}${Bold} --mirror | -m\n${Reset}"
    printf "\t\t provide the release version to build ( wheezy , jessie) \n"
    printf "\t\t the defalt is stretch, this should match the installed\n"
    printf "\t\t system the image is being built on.\n" 
    printf "\n"
}


while [[ $# -gt 0]] ; do
   arg="$1";
   shift; 
   case "$arg" in
       --help|-h)
           PrintHelp
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

        --dist| -d)
            DIST="$opt"
            shift
            ;;

        *)
            printf "\t${Red}${Bold} Unknown option passed ${opt} \n${Reset}"
            PrintHelp
            exit 1
            ;;
    esac
done



#//////////////// MAIN \\\\\\\\\\\\\\\\\\\\

CheckRoot needed
echo $needed

CheckPrerequsites
echo ${INSTALL[@]}
