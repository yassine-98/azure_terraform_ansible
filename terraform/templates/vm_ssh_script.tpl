mv ~/.ssh/config ~/.ssh/config.old
tee -a ~/.ssh/config > /dev/null << EOF
Host vm
    Hostname ${Hostname}
    User ${User}
    StrictHostKeyChecking no

EOF
rm ~/.ssh/config.old
