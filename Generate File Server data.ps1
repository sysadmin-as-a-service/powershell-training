# generate a bunch of random files on my system
param(
    $wordsListFile = ".\words.txt",
    $noFiles = 1000,
    $noDirectories = 20,
    $sourceDir = "C:\FileServer"
)


Invoke-WebRequest -Uri "https://github.com/dwyl/english-words/raw/master/words_alpha.txt" -OutFile $wordsListFile
$words = Get-Content $wordsListFile

if(!(Test-Path $sourceDir)){
    New-Item $sourceDir -Type Directory
}

for($j = 0; $j -lt $noDirectories; $j++){
    $randomDirectoryNumber = Get-Random -Maximum $words.Length -Minimum 0
    $directoryName = "$($words[$randomDirectoryNumber])"
    New-Item -Path "$($sourceDir)\$($directoryName)" -ItemType Directory

    for($i = 0;$i -lt ($noFiles/$noDirectories); $i++){
        $randomFileNumber = Get-Random -Maximum $words.Length -Minimum 0
        $randomFileSize = Get-Random -Minimum 1024 -Maximum 10240000
        $fileName = "$($words[$randomFileNumber]).txt"

        fsutil.exe file createnew "$($sourceDir)\$($directoryName)\$($fileName)" $randomFileSize
        # New-Item -Path "$($sourceDir)\$($directoryName)\$($fileName)" -ItemType 
    
    }

}
