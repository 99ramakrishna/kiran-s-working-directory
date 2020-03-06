#!/bin/bash
echo -e  "Enter users Password: \c " 
read pass

while read  command
do
  users_ip=($command)
  user=${users_ip[0]}
  ip=${users_ip[1]}
#  key=${users_ip[2]}
  cuser=${users_ip[2]}
  os=($(ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n   $user@$ip  "lsb_release -d"))
  if [  "${os[1]}" == "Ubuntu" ]
  then
    echo "This is Ubuntu"
    scp  -i  ansible-control.pem  -o StrictHostKeyChecking=No ubuntusetup.sh ubuntucommands.txt  $user@$ip:/home/ubuntu
    ssh  -i  ansible-control.pem -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo cp -r ubuntusetup.sh ubuntucommands.txt /root"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo -i ls -l"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo -i ./ubuntusetup.sh"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo  useradd -m -d /home/$cuser -s /bin/bash $cuser"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "echo '$cuser:$pass' | sudo chpasswd"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo cp -r /etc/sudoers  sudoers_new.txt"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo chmod  777  sudoers_new.txt"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "echo '$cuser ALL=(ALL:ALL) NOPASSWD: ALL' >> sudoers_new.txt"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo cat sudoers_new.txt"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo cp -r sudoers_new.txt  /etc/sudoers"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo chmod 400 /etc/sudoers"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config"
 elif [ "${os[1]}" == "CentOS"  ]
  then
    echo "this is cent os "
    scp  -i  ansible-control.pem  -o StrictHostKeyChecking=No centossetup.sh centoscommands.txt  $user@$ip:/home/centos
    ssh  -i  ansible-control.pem -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo cp -r centossetup.sh centoscommands.txt /root"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo -i ls -l"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo -i ./centossetup.sh"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo  useradd -m -d /home/$cuser -s /bin/bash $cuser"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo  echo '$pass' | sudo passwd --stdin $cuser"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo cp -r /etc/sudoers  sudoers_new.txt"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo chmod  777  sudoers_new.txt"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "echo '$cuser ALL=(ALL:ALL) NOPASSWD: ALL' >> sudoers_new.txt"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo cat sudoers_new.txt"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo cp -r sudoers_new.txt  /etc/sudoers"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo chmod 400 /etc/sudoers"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config"


  elif [ "${os[1]}" == "Red"  ]
  then
    echo "this is Red Hat"

    scp  -i  ansible-control.pem  -o StrictHostKeyChecking=No centossetup.sh centoscommands.txt  $user@$ip:/home/ec2-user
    ssh  -i  ansible-control.pem -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo cp -r centossetup.sh centoscommands.txt /root"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo  ls -l"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo -i ./centossetup.sh"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo  useradd -m -d /home/$cuser -s /bin/bash $cuser"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo  echo '$pass' | sudo passwd --stdin $cuser"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo cp -r /etc/sudoers  sudoers_new.txt"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo chmod  777  sudoers_new.txt"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "echo '$cuser ALL=(ALL:ALL) NOPASSWD: ALL' >> sudoers_new.txt"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo cat sudoers_new.txt"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo cp -r sudoers_new.txt  /etc/sudoers"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo chmod 400 /etc/sudoers"
    ssh  -i  ansible-control.pem  -o StrictHostKeyChecking=No  -n  $user@$ip  "sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config"

  else
   echo "some thing went wrong"
  fi


done < user_ips.txt
