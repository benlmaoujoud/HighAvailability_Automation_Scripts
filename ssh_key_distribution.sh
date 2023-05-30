#!/bin/bash

ssh-keygen -t rsa


read -p "Entrez le nombre de noeuds : " NUM_NODES

while ! [[ "$NUM_NODES" =~ ^[0-9]+$ ]]; do
    echo "Veuillez entrer un nombre valide."
    read -p "Entrez le nombre de noeuds : " NUM_NODES
done


for ((i=1; i<=NUM_NODES; i++)); do
    read -p "Entrez l'adresse IP du noeud $i : " NODE_IP
    while ! [[ "$NODE_IP" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; do
        echo "L'adresse IP semble incorrecte (format attendu : X.X.X.X)"
        read -p "Entrez l'adresse IP du noeud $i : " NODE_IP
    done

    ssh-copy-id root@$NODE_IP 
    ssh -o BatchMode=yes -o ConnectTimeout=5 root@$NODE_IP exit
    if [[ $? -eq 0 ]]; then
        echo "La connexion SSH avec le noeud $i a réussi."
    else
        echo "La connexion SSH avec le noeud $i a échoué."
    fi
done
