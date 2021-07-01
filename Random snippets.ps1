# round some numbers
$bigLongNumber = 1.1241241294
$numberOfDigitsIWant = 1
[Math]::Round( $bigLongNumber, $numberOfDigitsIWant )

# round numbers another way
$bigLongNumber = 1.1241241294
'{0:0.##}' -f $bigLongNumber

# Send email
Send-MailMessage -SmtpServer my-smtpserver.com -Subject "Test EMail" -Body "Hey!" -Attachments ".\report.html" -To "email@address.com" -From "John Smith j<ohn.smith@email.com>"