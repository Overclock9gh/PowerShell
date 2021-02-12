#=======================================================================
#Auteurs: Charles-Olivier Lafaille et Saïd Hamdane
#Date: 19-11-2019
#
#Objectif: Le script devra lire le nom des utilisateurs à partir d'un
#fichier texte nommé user.txt que vous aurez préalablement créé. Le 
#fichier user.txt doit simplement contenir le nom des 5 utilisateurs
#soit, user1 à user5. Si les user1 à user5 sont inactifs, le script
#doit les activer.
#
#Paramètre
#temps = 10
#
#Constantes
#PASS = "Password99"
#OU = "TP3"
#DC1 = "poste03"
#DC2 = "local"
#PATH = ".\user.txt"
#MESS = "Veuillez Patienter."
#ERR = "L'utilisateur suivant existe déjà: "
#=======================================================================
$PASS = "Password99"
$OU = "TP3"
$DC1 = "poste03"
$DC2 = "local"
$PATH = ".\user.txt"
$temps = 10
$MESS = "Veuillez Patienter."
$ERR = "L'utilisateur suivant existe déjà: "

Import-Module ActiveDirectory
cd C:\Users\Administrateur\Documents\Script
echo $MESS
Start-sleep -s $temps
foreach($line in Get-Content $PATH) {
	if(Get-ADUser -Filter { SamAccountName -eq $line }) {
		echo $ERR $line
	} else {
    		New-ADUser -Name $line -Path "OU=$OU, DC=$DC1, DC=$DC2" `
		-AccountPassword `
		(ConvertTo-SecureString $PASS -AsPlainText -Force) `
		 -Enabled $true
	}
}