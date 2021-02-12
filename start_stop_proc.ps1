#==============================================================================#
# Auteur: Said Hamdane
# Date création: 29 oct. 2019
#
# Objectif: Script qui ouvre une application & qui le referme après 5 secondes
# Paramètres d'entré: Le chemin & le nom de l'application et le temps de sommeil. 
# Paramètres de sortie: L'application graphique.
#==============================================================================#
Start-Process -FilePath C:\Windows\System32\calc.exe
Start-Sleep -Seconds 5 
Stop-Process -Name Calculator 