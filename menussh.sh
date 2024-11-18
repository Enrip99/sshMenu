#!/usr/bin/bash

mapfile -t hosts < <(grep "Host " ~/.ssh/config | cut -d ' ' -f2)
mapfile -t hnames < <(grep "Hostname " ~/.ssh/config | awk '{$1=$1};1' | cut -d ' ' -f2)

for (( i=0; i<${#hosts[@]}; i+=1 ))
do
    echo "${i}. ${hosts[$i]} - ${hnames[$i]}"
done
read input

re='^[0-9]+$'

if [[ $input =~ $re && $input -lt ${#hosts[@]} ]] ; then
    ssh "${hosts[$input]}"
elif [[ ${hosts[*]} =~ ${input} ]] ; then
    ssh $input
else
    echo "Element no trobat a la llista"
fi