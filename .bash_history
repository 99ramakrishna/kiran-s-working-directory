hostnamectl set-hostname "master"
apt-get update 
hostnamectl set-hostname "master"
passwd root
su useradd -m -d /home/master -s /bin/bash master
passwd master
apt-get install vim  -y
vim --version
vim /etc/sudoers
vim /etc/ssh/sshd_config 
apt-get install ssh
su - master
exit
cd /var/
ls
cd 
exit
cat /etc/sudoers
exit
cat /etc/ssh/ssh_config 
exit
