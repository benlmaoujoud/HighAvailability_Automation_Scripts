#!/bin/bash

RED="\e[31m"
printf "${RED}"
STOP="\e[0m"
echo "
  ____    ____     ___   __  __  ___      _      ____  
 |  _ \  |  _ \   / _ \  \ \/ / |_ _|    / \    / ___| 
 | |_) | | |_) | | | | |  \  /   | |    / _ \   \___ \ 
 |  __/  |  _ <  | |_| |  /  \   | |   / ___ \   ___) |
 |_|     |_| \_\  \___/  /_/\_\ |___| /_/   \_\ |____/ 
                                                       
"
printf "${STOP}"

read -p "Entrez le nombre de noeuds: " NUM_NODES

while ! [[ "$NUM_NODES" =~ ^[0-9]+$ ]]; do
    echo "Veuillez entrer un nombre valide."
    read -p "Entrez le nombre de noeuds: " NUM_NODES
done

for ((i=1; i<=NUM_NODES; i++)); do
    echo "Noeud $i:"
    read -p "    Entrez l'adresse IP: " IP_ADDRESS
    read -p "    Entrez le nom de stockage: " STORAGE_NAME
    read -p "    Entrez le nom du périphérique: " DEVICE_NAME

    echo "    Création du stockage ZFS sur $DEVICE_NAME..."
    ssh $IP_ADDRESS "zpool create -f $STORAGE_NAME $DEVICE_NAME; zfs set sharenfs=on $STORAGE_NAME; pvesm add zfspool $STORAGE_NAME --pool $STORAGE_NAME --content images,rootdir"
    
    if [ $? -eq 0 ]; then
        echo "    Stockage ZFS créé avec succès."
    else
        echo "Error : probléme dans la créartion ZFS_STOCKAGE"
    fi
zpool create -f $STORAGE_NAME $DEVICE_NAME; zfs set sharenfs=on $STORAGE_NAME; pvesm add zfspool $STORAGE_NAME --pool $STORAGE_NAME --content images,rootdir

if [ $? -eq 0 ]; then
        echo "    Stockage ZFS créé avec succès dans ce noeud "
    else
        echo "Error : probléme dans la créartion ZFS_STOCKAGE"
    fi
 

done