#==============================================================================#
# Auteur: Said Hamdane
# Date création: 29 oct. 2019
#
# Objectif: Script qui copie les permissions d'un fichier & qui les affiche au 
# fur et à mesure.
# Paramètres d'entré: Les chemins des fichiers.
# Paramètres de sortie: Les nouvelles permissions d'un fichier.
#==============================================================================#
Set-Variable -ErrorAction SilentlyContinue -Name "Affirmation1" -option `
Constant -value "Les autorisations actuelles pour le document" 

Set-Variable -ErrorAction SilentlyContinue -Name "Affirmation2" -option `
Constant -value "Les autorisations après les changements pour le document"

Start-Sleep -Seconds 2
Write-Output "$Affirmation1 modèle.txt :"
Get-Acl -Path 'C:\tp2\modèle.txt'| Format-List AccessToString 

Start-Sleep -Seconds 2
Write-Output "$Affirmation1 test.txt :"
Get-Acl -Path 'C:\tp2\test.txt' | Format-List AccessToString

Start-Sleep -Seconds 2
Write-Output "$Affirmation2 modèle.txt :"
Get-Acl -Path 'C:\tp2\modèle.txt'| Format-List AccessToString

Start-Sleep -Seconds 2
Get-Acl -Path 'C:\tp2\modèle.txt' | Set-Acl -Path 'C:\tp2\test.txt'
Write-Output "$Affirmation2 test.txt :"
Get-Acl -Path 'C:\tp2\test.txt' | Format-List AccessToString