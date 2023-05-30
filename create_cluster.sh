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

read -p "Donnez le nombre des noeuds (sans compter ce noeud) : " NUM_NODES

while ! [[ "$NUM_NODES" =~ ^[0-9]+$ ]]; do
    echo "Essayez de choisir un nombre svp "
    read -p "Donnez le nombre des noeuds:  " NUM_NODES
done

read -p "Donnez le nom de Cluster : " CLUSTER_NAME
while [[ -z "$CLUSTER_NAME" ]]; do
    echo "Le nom doit etre une chaine de chars"
    read -p "Donnez le nom de Cluster : " CLUSTER_NAME
done

echo "Création du cluster ..... $CLUSTER_NAME..."
pvecm create $CLUSTER_NAME

declare -a NODE_NAMES

for ((i=1; i<=NUM_NODES; i++)); do

    read -p "Donnez le nom de noeud $i: " NODE_NAME
    while [[ -z "$NODE_NAME" ]]; do
        echo "Essayez de donnez une chaine de chars valid"
        read -p "Donnez le nom de noeud  $i: " NODE_NAME
    done

    read -p "Donnez l'@ IP de ce noeud  $i: " NODE_IP
    while ! [[ "$NODE_IP" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; do
        echo "L'addresse ip doit incorrecte (X.X.X.X)"
        read -p "Donnez l'@ IP de ce noeud$i: " NODE_IP
    done
    IP_ADDRESS=$(ip a | awk '/vmbr0/ && /inet /{print $2}' | cut -d'/' -f1)
    echo "L'addresse IP de votre cluster est : $IP_ADDRESS"


    echo "Tu dois taper le mot de pass des autres noeuds svp ........;"
    ssh root@$NODE_IP "pvecm add $IP_ADDRESS"

    NODE_NAMES+=("$NODE_NAME")
done