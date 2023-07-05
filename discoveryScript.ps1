 
Class computer{
    $Name
    $PSVersion
    $Edition
    $CLRVersion
}


# Discovery look at the computer names and find network IP addresses
  $computerNames= Get-ADComputer -Filter * | Select-Object -ExpandProperty Name

   # 1..254 | ForEach-Object {
   #     $ipAddress = "192.168.1.$_"
   #     $pingResult = Test-Connection -ComputerName $ipAddress -Count 1 -Quiet
   #     if ($pingResult) {
   #         "$ipAddress is active"
   #     }
   # } 
    
   # this loop will find all information and populateit into computer classes
    foreach ($computerName in $computerNames) {
    # assign each computer name to a object
        $computer = New-Object Computer
        $computer.Name = $computerName
        
        # after assigning a name Maybey set up a CimSession??? Does not work with ERIC
        # new-CimSession -Computername $computerName
        
        # connect to the other computer with PSSession

        Enter-PSSession

        # get the PSversion and assigns it to the comptuer class
        $computer.PSVersion = $PSVersionTable.PSVersion


        #ONLY WORKS FOR DESKTOP get the powershell edition 
        $computer.Edition = Invoke-Command -ComputerName $computerName -ScriptBlock {
            $PSVersionTable.PSEdition
        }

        #get teh common language runtime WORKS ON MOST COMPUTERS NOT ERIC!!!!!!!
        $computer.CLRVersion = Invoke-Command -ComputerName $computerName -ScriptBlock {
            $PSVersionTable.CLRVersion
        }

        $computer
    } 
