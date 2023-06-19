# HighAvailability_Automation_Scripts

Cette répertoire GitHub contient une collection de scripts d'automatisation pour la configuration d'un environnement de haute disponibilité sous proxmox


![Alt text](aut.jpg?raw=true "Proxmox")

## Installation



```bash
apt-get update

apt-get install git

git clone https://github.com/benlmaoujoud/HighAvailability_Automation_Scripts

cd HighAvailability_Automation_Scripts

chmod +x nom_script.sh
```

## Usage

```bash
# pour configurer l'accès entre les noeuds sans mot de passe
apt-get update
apt install openssh-server
bash ssh_key_distribution.sh


# pour crée un cluster sous proxmox 
bash create_cluster.sh

# crée une stockage partagé zfs
bash share_storage.sh

# install vm or container sous proxmox et puis réplique le vms vers les autres noeuds
bash replicme.sh

# pour configurer la haute disponibilité 
bash configHA.sh

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.
