#!/bin/sh

if [ $# -ne 1 ]; then
	printf "\n"
	echo "	Usage: $0 <nodename or IP>,  install Chef client and register the node to Chef server!"
	printf "\n\n"
	exit 1	
fi

# 1. copy rpm 
printf ">>>>> Copying chef client rpm...\n"
scp ./chef-12.19.36-1.el6.x86_64.rpm $1:/tmp

# 2. install rpm
printf ">>>>> Installing chef client... \n"
ssh $1 rpm -i /tmp/chef-12.19.36-1.el6.x86_64.rpm

# 3. copy /etc/chef
printf ">>>>> Copying /etc/chef... \n"
rsync -a ./chef $1:/etc/

# 4. register
printf ">>>>> Registrying Node to server... \n"
ssh $1 chef-client -S https://chef-pvg.pvg.pdf.com/organizations/pvg -K /etc/chef/validation.pem
