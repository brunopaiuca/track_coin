
#!/usr/bin/env sh

DEBUG=0

[ -z ${ENVIRONMENT} ] && { echo "Failed to load the env variable."; exit 1; }

ANSIBLE_PLAYBOOK_DIR="/tmp/ansible"
BINYUM="/usr/bin/yum"

sudo ${BINYUM} repolist
sudo ${BINYUM} makecache
sudo ${BINYUM} -y install epel-release 
sudo ${BINYUM} -y install ansible

if [ ${DEBUG} -eq 1 ] ; then
    ansible-playbook -vvvv ${ANSIBLE_PLAYBOOK_DIR}/main.yml --extra-vars "@${ANSIBLE_PLAYBOOK_DIR}/${ENVIRONMENT}.vars" --extra-vars "@${ANSIBLE_PLAYBOOK_DIR}/global.vars" 
else
    ansible-playbook       ${ANSIBLE_PLAYBOOK_DIR}/main.yml --extra-vars "@${ANSIBLE_PLAYBOOK_DIR}/${ENVIRONMENT}.vars" --extra-vars "@${ANSIBLE_PLAYBOOK_DIR}/global.vars" 
fi
