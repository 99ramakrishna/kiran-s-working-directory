#!/bin/bash
while read command
do
  echo  "*********************************************  $command *********************************************** "
  echo " "
  $command
  echo " "

done < ubuntucommands.txt
