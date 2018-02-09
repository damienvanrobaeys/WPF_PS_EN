
[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[System.Reflection.Assembly]::LoadFrom('assembly\MahApps.Metro.dll') | out-null


function LoadXml ($global:filename)
{
    $XamlLoader=(New-Object System.Xml.XmlDocument)
    $XamlLoader.Load($filename)
    return $XamlLoader
}

# Load MainWindow
$XamlMainWindow=LoadXml("Testing_GUI.xaml")
$Reader=(New-Object System.Xml.XmlNodeReader $XamlMainWindow)
$Form=[Windows.Markup.XamlReader]::Load($Reader)

$Global:Current_Folder =(get-location).path 


########################################################################################################################################################################################################	
#*******************************************************************************************************************************************************************************************************
# 																		BUTTONS AND LABELS INITIALIZATION 
#*******************************************************************************************************************************************************************************************************
########################################################################################################################################################################################################

# ListBox
$DataGrid_XML = $Form.findname("DataGrid_XML")
$Choose_DS = $Form.findname("Choose_DS") 

$Browse = $Form.findname("Browse") 


$Reboot_Radio = $Form.findname("Reboot_Radio") 
$Hide_radio = $Form.findname("Hide_radio") 

$Appli_Enable = $Form.findname("Appli_Enable") 
$Appli_Reboot = $Form.findname("Appli_Reboot") 
$Appli_Hide = $Form.findname("Appli_Hide") 

$TextBox_Browse = $Form.findname("TextBox_Browse") 

$object = New-Object -comObject Shell.Application  


# Action sur un button
$Browse.Add_Click({						
})	

# Cocher décocher un CheckBox
# $Appli_Reboot.IsChecked = $True
# $Appli_Hide.IsChecked = $True
# $Appli_Enable.IsChecked = $False

# Cocher décocher un RadioButton
# $Reboot_Radio.IsChecked = $False
# $Hide_radio.IsChecked = $True


#Récupérer le texte saisi dans un TextBox
# $Value = $TextBox_Browse.Text.ToString()




Function Populate_W10_Deployment_ListBox
	{		
		$Share_XML = "DeploymentShare_Infos.xml"										
		$Global:my_share_xml = [xml] (Get-Content $Share_XML)	
		foreach ($data in $my_share_xml.selectNodes("DeploymentShares/DeploymentShare"))				
			{
				$Choose_DS.Items.Add($data.label)	| out-null	
			}					
	}				
Populate_W10_Deployment_ListBox	


Function Populate_Datagrid_XML # Function to list your applications in the datagrid
	{			
		$Global:List_XML_Content = ""
		$Input_XML = ""		
		
		$Global:List_XML_Content = "DeploymentShare_Infos.xml"						
		$Input_XML = [xml] (Get-Content $List_XML_Content)		
		foreach ($data in $Input_XML.selectNodes("DeploymentShares/DeploymentShare"))		
			{
				$XML_values = New-Object PSObject
				$XML_values = $XML_values | Add-Member NoteProperty Label $data.Label –passthru				
				$XML_values = $XML_values | Add-Member NoteProperty Path $data.Path –passthru
				$XML_values = $XML_values | Add-Member NoteProperty Version $data.Version –passthru
				$DataGrid_XML.Items.Add($XML_values) > $null
			}		
	}		
Populate_Datagrid_XML

	
	

$Form.ShowDialog() | Out-Null

