Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$formWidth = 250
$formHeight = 300
$buttonHeight = 30
$buttonWidth = 75

# Form
$form = New-Object System.Windows.Forms.Form -Property @{
    Text = "Select Date and Time. "
    Size = New-Object System.Drawing.Size($formWidth,$formHeight)
    StartPosition = [System.Windows.Forms.FormStartPosition]:: CenterScreen
    KeyPreview = $True
}

# the "OK" button 
$OKButton = New-Object System.Windows.Forms.Button -Property @{
    Location = New-Object System.Drawing.Size(($formWidth*0.1),(200))
    Size = New-Object System.Drawing.Size($buttonWidth,$buttonHeight)
    Text = 'OK'
    DialogResult = [System.Windows.Forms.DialogResult]::OK
    }

$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

# the "Cancel" button
$CancelButton = New-Object System.Windows.Forms.Button -Property @{
    Location = New-Object System.Drawing.Size((($formWidth*0.55)),(200))
    Size = New-Object System.Drawing.Size($buttonWidth,$buttonHeight)
    Text = 'Cancel'
    DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    }

$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

# Label
$objLabel = New-Object System.Windows.Forms.Label
$objLabel.Location = New-Object System.Drawing.Size(300,150)
$objLabel.Size = New-Object System.Drawing.Size(150,50)

#Handler - saving user input
$Handler_objCalendar_DateSelected = {        
    $objLabel.Text = "Selected Date: $($objCalendar.SelectionStart.ToShortDateString())"
    $Global:SelectedDate = $($objCalendar.SelectionStart.ToShortDateString())
    }

# Calendar
$objCalendar = New-Object Windows.Forms.MonthCalendar -Property @{
    ShowTodayCircle   = $True
    MaxSelectionCount = 1
    Size = New-Object System.Drawing.Size(200,200)
    Location = New-Object System.Drawing.Size(20,20)
     
}

$objCalendar.add_DateSelected($Handler_objCalendar_DateSelected)

$form.Controls.Add($objCalendar)
$form.Controls.Add($objLabel)

$result = $form.ShowDialog()

if ($result -eq [Windows.Forms.DialogResult]::OK) {
    return $SelectedDate
    }