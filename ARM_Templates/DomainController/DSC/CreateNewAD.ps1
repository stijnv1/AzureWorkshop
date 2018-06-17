configuration CreateNewAD 
{ 
   param 
    ( 
        [Parameter(Mandatory)]
        [String]$DomainName,

        [Parameter(Mandatory)]
        [System.Management.Automation.PSCredential]$Admincreds
    ) 
    
    Import-DscResource -ModuleName xActiveDirectory, xPendingReboot
    
    [System.Management.Automation.PSCredential ]$DomainCreds = New-Object System.Management.Automation.PSCredential ("${DomainName}\$($Admincreds.UserName)", $Admincreds.Password)
   
    Node localhost
    {
        LocalConfigurationManager            
        {            
            ActionAfterReboot = 'ContinueConfiguration'            
            ConfigurationMode = 'ApplyOnly'            
            RebootNodeIfNeeded = $true            
        }

        WindowsFeature ADDSInstall 
        { 
            Ensure = "Present" 
            Name = "AD-Domain-Services"
        }

        xADDomain CreateTestDomain
        {
            DomainName = $DomainName
            DomainAdministratorCredential = $DomainCreds
            SafemodeAdministratorPassword = $DomainCreds
        }

        xWaitForADDomain WaitForTestDomain
        {
            DomainName = $DomainName
        }

        xADOrganizationalUnit ServersOU
        {
            Name = "Servers"
            Path = "DC=$($DomainName.Split('.')[0]),DC=$($DomainName.Split('.')[1])"
            DependsOn = "[xWaitForADDomain]WaitForTestDomain"
        }

        xPendingReboot Reboot1
        { 
            Name = "RebootServer"
            DependsOn = "[xADOrganizationalUnit]ServersOU"
        }

   }
} 
