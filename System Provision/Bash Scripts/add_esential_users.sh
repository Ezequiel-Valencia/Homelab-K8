#!/bin/bash

# Manual Interaction
# 1). Execute script
# 2). Copy over ssh keys
# 3). Execute ansible script
# 4). If the system already had previous users then remove them with "userdel -r username"

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

if [ $(id -u) -eq 0 ]; then
    printf "${CYAN}Making users and adding them to admin group\n${NORMAL}"
    for user in ansible zeke
    do
        printf "${MAGENTA}\nDealing with user $user\n${NORMAL}"
        if [ $(id "$user" | grep -c "$user") == 0 ]; then
            printf "${LIME_YELLOW}Making user $user\n${NORMAL}"
        elif [ $(id "$user" | grep -c "$user") == 1 ]; then
            printf "${GREEN}User $user already exists on this machine\n${NORMAL}"
        else
            printf "${RED}Number of users is strange, checkout user $user\n${NORMAL}"
        fi

        adminGroup="admin"
        if [ $(id "$user" | grep -c "$adminGroup") == 0 ]; then
            printf "${LIME_YELLOW}Adding user $user to $adminGroup group\n${NORMAL}"

        elif [ $(id "$user" | grep -c "$adminGroup") == 1 ]; then
            printf "${GREEN}User $user already in $adminGroup group on this machine\n${NORMAL}"

        else
            printf "${RED}User added to $adminGroup group is strange, checkout user $user\n${NORMAL}"
        fi
    done

else
    printf "Only root may add a user to the system"
    exit 2
fi


