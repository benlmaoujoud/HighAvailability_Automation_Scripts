# HighAvailability_Automation_Scripts
Cette répertoire GitHub contient une collection de scripts d'automatisation pour la configuration d'un environnement de haute disponibilité 

## ssh_key_destribution.sh : Configuration de l'accès SSH sans mot de passe
Ce script génère une nouvelle paire de clés SSH, copie la clé publique sur deux nœuds distants (pré-définis dans le script) pour permettre l'accès SSH sans mot de passe, et tente de se connecter à ces deux nœuds pour vérifier l'authentification.
## create_cluster.sh : Création d'un cluster Proxmox
Ce script crée un nouveau cluster Proxmox en demandant à l'utilisateur le nombre de nœuds, le nom du cluster, puis les noms et adresses IP de chaque nœud.

## share_storage.sh : Création de stockage ZFS

Ce script crée un stockage ZFS sur chaque nœud du cluster en demandant à l'utilisateur le nombre de nœuds, l'adresse IP, le nom du stockage, et le nom du périphérique de chaque nœud.

## Prérequis :

* Assurez-vous que le script est exécutable avec chmod a+x script3.sh.
* Exécutez le script avec ./script3.sh.
* Suivez les instructions à l'écran.
