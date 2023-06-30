
# Discovery look at the computer names and find network IP addresses
    Get-ADComputer -Filter * | Select-Object -ExpandProperty Name

    1..254 | ForEach-Object {
        $ipAddress = "192.168.1.$_"
        $pingResult = Test-Connection -ComputerName $ipAddress -Count 1 -Quiet
    
        if ($pingResult) {
            "$ipAddress is active"
        }
    } 
    