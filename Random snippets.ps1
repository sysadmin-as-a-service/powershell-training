# round some numbers
$bigLongNumber = 1.1241241294
$numberOfDigitsIWant = 1
[Math]::Round( $bigLongNumber, $numberOfDigitsIWant )

# round numbers another way
$bigLongNumber = 1.1241241294
'{0:0.##}' -f $bigLongNumber

