
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

IP_LOCAL_NODE=$(ip a | grep 'inet ' | grep 'vmbr0' -B1 | awk -F' ' '/inet /{print $2}' | cut -d'/' -f1 | grep -v 127.0.0.1)


read -p "Avez-vous deja cree un conteneur LXC ? (oui/non) : " LXC_EXISTS
if [ "$LXC_EXISTS" == "oui" ]; then
    read -p "Voulez-vous creer un nouveau conteneur LXC ? (oui/non) : " CREATE_NEW
    if [ "$CREATE_NEW" == "non" ]; then
        echo "Fin du script car vous avez choisi de ne pas créer un nouveau conteneur LXC."
        exit 0
    fi
fi
pveam update
echo "Liste des modèles LXC disponibles:"
pveam available --section turnkeylinux | awk '{print $2}'

read -p "Entrez le nom du modèle LXC que vous voulez telecharger : " TEMPLATE_NAME
while [[ -z "$TEMPLATE_NAME" ]]; do
    echo "Entree invalide. Veuillez entrer un nom de modèle valide."
    read -p "Entrez le nom du modèle LXC que vous voulez télécharger : " TEMPLATE_NAME
done

echo "Telechargement du modèle $TEMPLATE_NAME dans le stockage partagé 'Local'..."
pveam download local $TEMPLATE_NAME

read -p "Nombre de noeud: " NODE_COUNT
NODE_COUNT=$((NODE_COUNT+0))

for (( i=0; i<$NODE_COUNT; i++ ))
do
    read -p "Entrez le nom du Noeud :  $((i+1)): " NODE_NAME
    pvesr create-local-job 100-$i $NODE_NAME --schedule "*/5" --rate 3
done
