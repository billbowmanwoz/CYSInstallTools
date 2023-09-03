Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object Windows.Forms.Form -Property @{
    StartPosition = [Windows.Forms.FormStartPosition]::CenterScreen
    Size          = New-Object Drawing.Size 1024, 768
    Text          = 'CyberSecurity Installer'
    Topmost       = $true
}

$instTextBox = New-Object System.Windows.Forms.TextBox
$instTextBox.Multiline = $True;
$instTextBox.ReadOnly = $true
$instTextBox.Location = New-Object System.Drawing.Size(262,20)
$instTextBox.Size = New-Object System.Drawing.Size(500,40)
#$instTextBox.ScrollBars = 'Vertical'
$instTextBox.Text = 'Welcome to the CyberSecurity Program! This installer is used to install most of the required programs that are going to be used in the program.'
$instTextBox.TextAlign = [System.Windows.Forms.HorizontalAlignment]::Center
$form.Controls.Add($instTextBox)

# Show the form
$form.ShowDialog()
