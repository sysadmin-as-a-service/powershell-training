param(
    $sourceDir = "C:\FileServer",
    $sizeLimit = 5Mb
)

# create object
$files = @()

# get all files and their hash
$start = Get-Date
$files += Get-ChildItem $sourceDir -Recurse -File | select Length,Name,LastWriteTime,FullName,@{Name="FileHash";Expression={ (Get-FileHash $_.FullName).Hash }}
$end = Get-Date
Write-Host "Got $($files.count) files! Took $((New-TimeSpan -Start $start -End $end).TotalMinutes) minutes to complete."

# just get stuff over 5mb
$bigFiles = $files | Where-Object { $_.Length -gt $sizeLimit  } | Sort Length -Descending |  Select FullName,LastWriteTime,@{Name="Size(MB)";Expression={ [Math]::Round( $_.Length/1Mb, 1 ) }}

# create an HTML report

$css = @"
td {
    border: 2px solid black;
    font-family: arial
}

tr {
    border: 4px solid black;
}

th {
    border: 1px solid black;
}
"@

$css | out-File .\style.css

$bigFiles | ConvertTo-Html -Head "Generated on $(Get-Date -format g)" -Title "File Server Report" -CssUri ".\style.css" | Out-File ".\BigFilesReport.html"
Invoke-Item ".\BigFilesReport.html"

$duplicateFiles = @()
$files | Group-Object FileHash | Where-Object { $_.Count -gt 1} | Select Group | ForEach-Object { $duplicateFiles += $_.Group }

$duplicateFiles | ConvertTo-Html -Head "Generated on $(Get-Date -format g)" -Title "File Server Report - Duplicate Files" -CssUri ".\style.css" | Out-File ".\DuplicateFilesReport.html"
Invoke-Item ".\DuplicateFilesReport.html"

# specify minimum file size to report on
# list all files over a certain size
# sorted by largest size, then by duplicates
# display file name and file path and last modified date

# file1     10mb    2 days ago
# file2     9mb     2 days ago
# file51    8mb     10 days ago

# duplicates
# file2 mydownloads\file2.mpv   (hash)
# file2 groupmovies\file2.mpv   (hash)
