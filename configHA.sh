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


read -p "Entrez le nom du groupe HA : " HA_GROUP
while [[ -z "$HA_GROUP" ]]; do
    echo "Le nom du groupe HA ne peut pas être vide."
    read -p "Entrez le nom du groupe HA : " HA_GROUP
done

# Get the Container ID from the user
read -p "Entrez l'ID du conteneur LXC : " CONTAINER_ID
while [[ -z "$CONTAINER_ID" ]]; do
    echo "L'ID du conteneur ne peut pas être vide."
    read -p "Entrez l'ID du conteneur LXC : " CONTAINER_ID
done


echo "Création du groupe HA $HA_GROUP..."
pvesh create /cluster/ha/groups --group "$HA_GROUP"

# Add the LXC container to the HA group
echo "Ajout de la ressource vm:$CONTAINER_ID au groupe $HA_GROUP..."
pvesh create /cluster/ha/resources --group "$HA_GROUP" --type lxc --sid "$CONTAINER_ID" --max-relocate 1 --priority 1


echo "Vérification HA..."
pvesh get /cluster/ha/groups/"$HA_GROUP"

# Verify resource state in HA
echo "Vérification de l'état de la ressource dans HA..."
pvesh get /cluster/ha/resources/"$CONTAINER_ID"