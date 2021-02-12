################################################################################
#Auteur: Saïd Hamdane                                                          #
#Date: 8 mai 2020                                                              #
#                                                                              #
#Objectif: Création & configuration d'utilisateurs.                            #
################################################################################
 
#######
#Aide #
#######

# Aide concernant la fonction du script.

<#
.Synopsis
   Permet de créer un utilisateur en spécifiant jusqu'à 3 niveaux imbriqués de 
   l'OU dans laquelle le créer.
.DESCRIPTION
   Script permettant la création & configuration d'utilisateurs. L'utilisateur
   se muni d'un mot de passe lambda qui lui permettra d'être accepté dans les 
   critères d'activation. Son mot de passe sera changé à sa prochaine connexion 
   & il fera parti des OU choisi & acceptés.
.EXAMPLE
   .\add-user.ps1 Georges "LG Tech"
   Description
   -----------
   Ajoute l'utilisateur Georges dans l'OU LG Tech.
.EXAMPLE
   .\add-user.ps1 Mike "LG Tech" Production Achats
   Description
   -----------
   Ajoute l'utilisateur Mike dans l'OU Achats qui est dans l'OU Productions qui
   est elle-même dans l'OU LG Tech.
#>

#########
#Module #
#########

# Module nécessaire pour utiliser certaines commandes de AD.

Import-Module ActiveDirectory

############
#Paramètre #
############

# Paramètre d'entré du nom de l'utilisateur.

$utilisateur=$args[0]

# Paramètre d'entré des OU --> liste du premier au dernier. 

$ou=$args[1..($args.Length-1)]

#########
#Erreur #
#########

# Vérification des critères de paramètres entrés.

if ($args[0] -eq $null) {

    Write-Host "Erreur, aucun paramètre détécté, veuillez entrez des paramètres" `
    -ForegroundColor Red -BackgroundColor Black

    exit

}

# Vérification des critères de  l'existence de l'utilisateur.

try {

    Get-aduser $utilisateur

}

catch {

    Write-Host "En cours de création de l'utilisateur $utilisateur" `
    -ForegroundColor DarkGreen -BackgroundColor White

}

if (!$error) {

    Write-Host "Erreur, l'utilisateur $utilisateur existe déjà, veuillez 
entrez un utilisateur qui n'existe pas" `
    -ForegroundColor Red -BackgroundColor Black

    exit

}


#########
#Action #
#########

# Boucle qui structure les OU entrés. 

$chemin="DC=poste02,DC=local"

foreach ($temp in $ou) {

    $chemin="OU=" + $temp + "," + $chemin

    if (![adsi]::Exists("LDAP://" + $chemin)) {
        Write-Host "Erreur, l'OU $chemin n'existe pas, veuillez entrez un OU qui
existe" `
    -ForegroundColor Red -BackgroundColor Black

    exit
    
    }

    
}

# Commande permettant la création & configuration d'utilisateurs. L'utilisateur
# se muni d'un mot de passe lambda qui lui permettra d'être accepté dans les 
# critères d'activation. Son mot de passe sera changé à sa prochaine connexion 
# & il fera parti des OU choisi & acceptés.

New-ADUser -Name $utilisateur `
 -AccountPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd" -Force) `
 -ChangePasswordAtLogon:$true `
 -Path $chemin `
 -PassThru | Enable-ADAccount