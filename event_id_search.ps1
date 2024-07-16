#Author: Jackson Pavelka
#Git: buckeye_nut27
#Last updated 7/16/24


# Prompt the user to enter an event ID
$eventID = Read-Host "Enter the Event ID"

# Calculate the date and time 48 hours ago
$startTime = (Get-Date).AddHours(-48)

# Define the log name
$logName = "System"

# Get events from the System log
$events = Get-WinEvent -LogName $logName | Where-Object {
    $_.Id -eq $eventID -and $_.TimeCreated -ge $startTime
}

# Create an array to store the selected properties
$eventData = @()

# Loop through each event and select the desired properties
foreach ($event in $events) {
    $eventData += [PSCustomObject]@{
        "Logged Date and Time" = $event.TimeCreated
        "Task Category"        = $event.TaskDisplayName
        "Source"               = $event.ProviderName
        "Description"          = $event.Message
    }
}

# Export the event data to a CSV file
$eventData | Export-Csv -Path "C:\temp\output.csv" -NoTypeInformation

Write-Output "Events exported to CSV file successfully."