Invoke-Command -ComputerName 2016CORE-02 {
Set-NetFirewallRule -DisplayGroup "Gestion à distance des journaux des événements" -Enabled True -PassThru |
select DisplayName, Enabled
} -Credential (Get-Credential)