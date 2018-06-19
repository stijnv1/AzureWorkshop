Configuration DeployIIS
{
    Node localhost
    {
        LocalConfigurationManager
        {
            ActionAfterReboot = 'ContinueConfiguration'            
            ConfigurationMode = 'ApplyOnly'            
            RebootNodeIfNeeded = $true
        }

        WindowsFeature installIIS
        {
            Ensure = "Present"
            Name = "Web-Server"
        }
    }
}