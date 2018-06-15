# variables
$staName = "svhbh54workshopsta"
$rgName = "RG-WorkshopPreps"
$tableName = "svhh54table"

# create storage table
$ctx = (Get-AzureRmStorageAccount -ResourceGroupName $rgName -Name $staName).Context
$storageTable = New-AzureStorageTable -Name $tableName -Context $ctx

# insert entities using 2 partitions
$partitionKey1 = "partition1"
$partitionKey2 = "partition2"

# add four rows 
Add-StorageTableRow `
    -table $storageTable `
    -partitionKey $partitionKey1 `
    -rowKey ("CA") -property @{"username"="Chris";"userid"=1}

Add-StorageTableRow `
    -table $storageTable `
    -partitionKey $partitionKey2 `
    -rowKey ("NM") -property @{"username"="Jessie";"userid"=2}

Add-StorageTableRow `
    -table $storageTable `
    -partitionKey $partitionKey1 `
    -rowKey ("WA") -property @{"username"="Christine";"userid"=3}

Add-StorageTableRow `
    -table $storageTable `
    -partitionKey $partitionKey2 `
    -rowKey ("TX") -property @{"username"="Steven";"userid"=4}

# get all rows from table
Get-AzureStorageTableRowAll -table $storageTable | ft