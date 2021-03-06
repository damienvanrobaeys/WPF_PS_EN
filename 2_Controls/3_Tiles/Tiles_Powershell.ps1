[System.Reflection.Assembly]::LoadWithPartialName('presentationframework') | out-null
[System.Reflection.Assembly]::LoadFrom('assembly\MahApps.Metro.dll')       | out-null

function LoadXml ($global:filename)
{
    $XamlLoader=(New-Object System.Xml.XmlDocument)
    $XamlLoader.Load($filename)
    return $XamlLoader
}

# Load MainWindow
$XamlMainWindow=LoadXml("Tiles_Powershell.xaml")
$Reader=(New-Object System.Xml.XmlNodeReader $XamlMainWindow)
$Form=[Windows.Markup.XamlReader]::Load($Reader)


################# CONTROL INITIALIZATION #################

$ChangeSettings  = $Form.Findname("ChangeSettings")
$FlyOutContent = $Form.Findname("FlyOutContent")
$Open_Desktop = $Form.Findname("Open_Desktop")
$Open_Powershell = $Form.Findname("Open_Powershell")
$Open_Youtube = $Form.Findname("Open_Youtube")
$Open_TaskManager = $Form.Findname("Open_TaskManager")
$Open_Controlpanel = $Form.Findname("Open_Controlpanel")
$Open_Device = $Form.Findname("Open_Device")
$Open_Services = $Form.Findname("Open_Services")
$Open_IE = $Form.Findname("Open_IE")


$Close = $Form.Findname("Close")
$Open_Installed_Soft = $Form.Findname("Open_Installed_Soft")

$Choose_parameter = $Form.Findname("Choose_parameter")
$Services = $Form.Findname("Services")
$Hotfix = $Form.Findname("Hotfix")
$Process = $Form.Findname("Process")
$Run = $Form.Findname("Run")


################# ACTION ON TILE CLICK #################

$ChangeSettings.Add_Click({
    $FlyOutContent.IsOpen = $true    
})

$Open_Desktop.Add_Click({
	(New-Object -ComObject shell.application).toggleDesktop()
})

$Open_Powershell.Add_Click({
	start-process Powershell
})

$Open_Youtube.Add_Click({
	[System.Diagnostics.Process]::Start("https://www.youtube.com/?hl=fr&gl=FR")
})

$Open_TaskManager.Add_Click({
	start-process taskmgr
})

$Open_Controlpanel.Add_Click({
	start-process control panel
})

$Open_IE.Add_Click({
	[System.Diagnostics.Process]::Start("iexplore.exe","$Author_Website")
})

$Open_Device.Add_Click({
	start-process hdwwiz.cpl
})

$Open_Services.Add_Click({
	Get-WmiObject win32_service | select name, Caption, state, startmode | out-gridview
})

$Open_Installed_Soft.Add_Click({
	start-process appwiz
})

$Close.Add_Click({
    $form.Close()
	
})


################# ACTION ON COMBOXBOXITEM #################

$Run.Add_Click({

	If ($Services.IsSelected -eq $True)
		{
			Get-WmiObject win32_service | select name, Caption, state, startmode | out-gridview
		}

	ElseIf ($Hotfix.IsSelected -eq $True)
		{
			Get-WmiObject win32_quickfixengineering | select hotfixid, description | out-gridview
		}


	ElseIf ($Process.IsSelected -eq $True)
		{
			Get-WmiObject win32_Process | select name, commandline | out-gridview
		}
})		








$Form.ShowDialog() | Out-Null
