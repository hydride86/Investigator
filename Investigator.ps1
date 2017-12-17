########GLOBAL VARIABLES
$Credential


#ERASE ALL THIS AND PUT XAML BELOW between the @" "@
$inputXML = @"
<Window x:Class="MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApplication3"
        mc:Ignorable="d"
        Title="Simple Heuristic Investigation Tool (Working title)" Height="599" Width="900" ResizeMode="CanResize">
    <Grid>
        <ToolBar x:Name="toolBar" HorizontalAlignment="Left" Margin="208,121,0,0" VerticalAlignment="Top"/>
        <Menu x:Name="MainWindowMenu" Height="23" VerticalAlignment="Top" Margin="0,0,8,0">
            <MenuItem Header="_File">
                <MenuItem Header="_New Investigation"/>
                <MenuItem Header="_Load Investigation"/>
                <MenuItem x:Name= "Artifacts" Header="_Get/Update Artifacts"/>
            </MenuItem>
            <MenuItem Header="_Post Acquisition">
                <MenuItem Header="Compare to _NSRL"/>
                <MenuItem Header="Compare to Known _Bad Hashes"/>
            </MenuItem>
            <MenuItem Header="_About"/>
        </Menu>
        <TreeView x:Name="InvestigationListBox" HorizontalAlignment="Left" Margin="10,28,0,8" Width="272"/>
        <DataGrid x:Name="ResultsGrid" Margin="287,28,10,8"/>

    </Grid>
</Window>
"@       
 
$inputXML = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N'  -replace '^<Win.*', '<Window'
function CreateAcquisitionWindow{
$acquisitionxml = @"
<Window x:Class="Acquisitions"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApplication3"
        mc:Ignorable="d"
        Title="Acquisition Options" Height="500" Width="450">
    <Grid>
        <Menu x:Name="menu" Height="23" VerticalAlignment="Top"/>
        <Border VerticalAlignment="Top" Height="327">
            <Grid Margin="0,0,0,-138">
                <StackPanel Orientation="Vertical" Margin="0,0,10,0">
                    <StackPanel Orientation="Horizontal">
                        <StackPanel HorizontalAlignment="Left">
                            <Label>Import Hosts:</Label>
                        </StackPanel>
                        <StackPanel HorizontalAlignment="Right" Width="248">
                            <ComboBox x:Name="HostEnumeration" SelectedIndex="0">
                                <ComboBoxItem>
                                    <TextBlock><Run Text="Get-AD"/></TextBlock>
                                </ComboBoxItem>
                                <ComboBoxItem>
                                    <TextBlock><Run Text="Text File"/></TextBlock>
                                </ComboBoxItem>
                            </ComboBox>
                        </StackPanel>
                    </StackPanel>
                    <StackPanel Orientation="Horizontal">
                        <Border HorizontalAlignment="Left">
                            <StackPanel Orientation="Horizontal">
                                <StackPanel HorizontalAlignment="Left">
                                    <Label>Get Host Data:</Label>
                                    <Label>Get Running Processes:</Label>
                                    <Label>Get Services:</Label>
                                    <Label>Get Prefetch:</Label>
                                    <Label>Get ShimCache:</Label>
                                    <Label>Get Scheduled Tasks:</Label>
                                    <Label>Common Persistence Registry:</Label>
                                    <Label>Mine Additional Registry Data:</Label>
                                    <Label>Get File Hashes:</Label>
                                    <Label>Get Additiontal File Hashes:</Label>
                                </StackPanel>
                                <StackPanel HorizontalAlignment="Right">
                                    <ComboBox x:Name="HostData" SelectedIndex="0" Margin="2">
                                        <ComboBoxItem>WMI</ComboBoxItem>
                                        <ComboBoxItem>WinRM</ComboBoxItem>
                                    </ComboBox>
                                    <ComboBox x:Name="RunningProcesses" SelectedIndex="0" Margin="2">
                                        <ComboBoxItem>WMI</ComboBoxItem>
                                        <ComboBoxItem>WinRM</ComboBoxItem>
                                        <ComboBoxItem>No</ComboBoxItem>
                                    </ComboBox>
                                    <ComboBox x:Name="Services" SelectedIndex="0" Margin="2">
                                        <ComboBoxItem>WMI</ComboBoxItem>
                                        <ComboBoxItem>WinRM</ComboBoxItem>
                                        <ComboBoxItem>No</ComboBoxItem>
                                    </ComboBox>
                                    <ComboBox x:Name="Prefetch" SelectedIndex="0" Margin="2">
                                        <ComboBoxItem>SMB</ComboBoxItem>
                                        <ComboBoxItem>WinRM</ComboBoxItem>
                                        <ComboBoxItem>No</ComboBoxItem>
                                    </ComboBox>
                                    <ComboBox x:Name="ShimCache" SelectedIndex="0" Margin="2">
                                        <ComboBoxItem>WMI</ComboBoxItem>
                                        <ComboBoxItem>WinRM</ComboBoxItem>
                                        <ComboBoxItem>No</ComboBoxItem>
                                    </ComboBox>
                                    <ComboBox x:Name="ScheduledTasks" SelectedIndex="0" Margin="2">
                                        <ComboBoxItem>SMB</ComboBoxItem>
                                        <ComboBoxItem>WinRM</ComboBoxItem>
                                        <ComboBoxItem>No</ComboBoxItem>
                                    </ComboBox>
                                    <ComboBox x:Name="CommonPersistencRegistry" SelectedIndex="0" Margin="2">
                                        <ComboBoxItem>WMI</ComboBoxItem>
                                        <ComboBoxItem>WinRM</ComboBoxItem>
                                        <ComboBoxItem>No</ComboBoxItem>
                                    </ComboBox>
                                    <ComboBox x:Name="OtherRegistry" SelectedIndex="0" Margin="3">
                                        <ComboBoxItem>WMI</ComboBoxItem>
                                        <ComboBoxItem>WinRM</ComboBoxItem>
                                        <ComboBoxItem>No</ComboBoxItem>
                                    </ComboBox>
                                    <ComboBox x:Name="GetHashes" SelectedIndex="0" Margin="3">
                                        <ComboBoxItem>WMI/SMB</ComboBoxItem>
                                        <ComboBoxItem>WinRM</ComboBoxItem>
                                        <ComboBoxItem>No</ComboBoxItem>
                                    </ComboBox>
                                    <ComboBox x:Name="AddiontalFileHashes" SelectedIndex="0" Margin="3">
                                        <ComboBoxItem>WMI/SMB</ComboBoxItem>
                                        <ComboBoxItem>WinRM</ComboBoxItem>
                                        <ComboBoxItem>No</ComboBoxItem>
                                    </ComboBox>
                                </StackPanel>
                            </StackPanel>
                        </Border>
                        <Border>
                            <Grid>
                                <StackPanel>
                                    <StackPanel Orientation="Horizontal">
                                        <StackPanel>
                                            <Label>Windows Events</Label>
                                        </StackPanel>
                                        <StackPanel>
                                            <ComboBox x:Name="EventMethod" SelectedIndex="0">
                                                <ComboBoxItem>WMI</ComboBoxItem>
                                                <ComboBoxItem>WinRM</ComboBoxItem>
                                            </ComboBox>
                                        </StackPanel>
                                    </StackPanel>
                                    <StackPanel Orientation="Horizontal">
                                        <StackPanel HorizontalAlignment="Left">
                                            <Label>MCafee AV</Label>
                                            <Label>Symatec AV</Label>
                                            <Label>Scheduled Tasks</Label>
                                            <Label>User Logging</Label>
                                            <Label>Windows Restart Events</Label>
                                        </StackPanel>
                                        <StackPanel HorizontalAlignment="Right">
                                            <CheckBox x:Name="MCafee" Margin="0,5"></CheckBox>
                                            <CheckBox x:Name="Symantec" Margin="0,5"></CheckBox>
                                            <CheckBox x:Name="SchedTasks" Margin="0,5"></CheckBox>
                                            <CheckBox x:Name="UserLogging" Margin="0,5"></CheckBox>
                                            <CheckBox x:Name="RestartEvents" Margin="0,5"></CheckBox>
                                        </StackPanel>
                                    </StackPanel>
                                </StackPanel>
                            </Grid>
                        </Border>
                    </StackPanel>
                    <Border BorderThickness="0,1,0,0" BorderBrush="#FF6C6C6C">
                        <StackPanel Orientation="Vertical">
                            <StackPanel Orientation="Horizontal">
                                <Label>Input Credential</Label>
                                <Button x:Name="GetCred">Get-Credential</Button>
                            </StackPanel>
                            <StackPanel Height="35">
                                <Button>AcquireData</Button>
                            </StackPanel>
                        </StackPanel>
                    </Border>
                </StackPanel>
            </Grid>
        </Border>
    </Grid>
</Window>

"@  -replace 'mc:Ignorable="d"','' -replace "x:N",'N'  -replace '^<Win.*', '<Window'
[xml]$acquisitionxaml = $acquisitionxml
#$acquisitionxaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name "WPF$($_.Name)" -Value $AcquisitionForm.FindName($_.Name)}
$reader=(New-Object System.Xml.XmlNodeReader $acquisitionxaml)
try{$AcquisitionForm=[Windows.Markup.XamlReader]::Load( $reader )}
catch{Write-Host "Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure .net is installed."}
$AcquisitionForm.FindName("GetCred").Add_Click({$Credential = Get-Credential})
return $AcquisitionForm
}

#$acquisitionxml =$acquisitionxml -replace 'mc:Ignorable="d"','' -replace "x:N",'N'  -replace '^<Win.*', '<Window'
[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[xml]$XAML = $inputXML
[xml]$acquisitionxaml = $acquisitionxml
#Read XAML
 
    $reader=(New-Object System.Xml.XmlNodeReader $xaml)
  try{$MyForm=[Windows.Markup.XamlReader]::Load( $reader )}
catch{Write-Host "Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure .net is installed."}
<#
    $reader=(New-Object System.Xml.XmlNodeReader $acquisitionxaml)
  try{$AcquisitionForm=[Windows.Markup.XamlReader]::Load( $reader )}
catch{Write-Host "Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure .net is installed."}
#>
 
#===========================================================================
# Load XAML Objects In PowerShell
#===========================================================================
 
$xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name "WPF$($_.Name)" -Value $MyForm.FindName($_.Name)}
#$acquisitionxaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name "WPF$($_.Name)" -Value $AcquisitionForm.FindName($_.Name)}
 
Function Get-FormVariables{
if ($global:ReadmeDisplay -ne $true){Write-host "If you need to reference this display again, run Get-FormVariables" -ForegroundColor Yellow;$global:ReadmeDisplay=$true}
write-host "Found the following interactable elements from our form" -ForegroundColor Cyan
get-variable WPF*
}
 
Get-FormVariables
 
#===========================================================================
# Actually make the objects work
#===========================================================================
 
#Sample entry of how to add data to a field
 
#$vmpicklistView.items.Add([pscustomobject]@{'VMName'=($_).Name;Status=$_.Status;Other="Yes"})
 
#===========================================================================
# Shows the form
#===========================================================================
<#
write-host "To show the form, run the following" -ForegroundColor Cyan '$Form.ShowDialog() | out-null'
#>
$MyForm.FindName("Artifacts").Add_Click({ (CreateAcquisitionWindow).ShowDialog() | out-null})
$MyForm.ShowDialog()