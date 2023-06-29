$credential = Get-Credential


Invoke-Command -ComputerName "cit361-lab.cit.byui.edu" -Credential $credential -ScriptBlock {
    Get-ADComputer -Filter * | Select-Object -ExpandProperty Name
}