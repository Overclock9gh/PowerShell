################################################################################
#Auteur: Saïd Hamdane                                                          #
#Date: 1 mai 2020                                                              #
#                                                                              #
#Objectif: Lister les utilisateurs & leurs groupes dans le domaines.           #
################################################################################

$listeUtilisateurs = Get-ADUser -Filter * | Select Name -ExpandProperty Name

	Write-Host ("
Utilisateur			Groupe
-----------			------")		

foreach($utilisateur in $listeUtilisateurs) {
	$groupeUtilisateurs=(Get-ADPrincipalGroupMembership -Identity $utilisateur | Select Name -ExpandProperty Name)

	Write-Host ("$utilisateur				$groupeUtilisateurs")
} 