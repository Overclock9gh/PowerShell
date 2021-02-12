$utilisateurs = Get-ADUser -Filter * -SearchBase "OU=mobile,DC=poste02,DC=local"
$utilisateurs | ForEach-Object {

    # Assigner le répertoire personnels de chaque utilisateur 

    $repertoirePersonnel = "\\W2016_SHAMDANE\Documents\" + $_.SamAccountName + "\Documents";
    Set-ADUser -Identity $_.SamAccountName -HomeDirectory $repertoirePersonnel -HomeDrive U;
}