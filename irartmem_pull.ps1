$url_source = @("https://github.com/seangfrank0474/IR_Artifact_Report_MemAquisition/archive/refs/heads/main.zip")
$pull_to_dir = ${env:ProgramFiles(x86)} + "\irts" 
if (!(Test-Path -Path $pull_to_dir)){
    New-Item -ItemType directory -Path $pull_to_dir
    $screen_output = "[+] {0} IR Triage and Acquisition script path has been setup. Path: {1}" -f $(get-date -UFormat "%Y-%m-%dT%H:%M:%S"), $pull_to_dir
    Write-Output $screen_output
            }
 
Foreach ($url_line in $url_source) {
    $file_split = $url_line -split "/"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    foreach ($file in $file_split) {
        switch -Regex ($file){
            ".+\.(ps1|exe|dll|zip)" { 
                $file_dest = $pull_to_dir + "\" + $file
                Invoke-WebRequest -Uri $url_line -OutFile $file_dest
            }
        }
    }
}
Expand-Archive -LiteralPath $file_dest -DestinationPath $pull_to_dir
$screen_output = "[+] {0} IR Artifact Report and Memory Aquisition has been downloaded. Script Path: {1}" -f $(get-date -UFormat "%Y-%m-%dT%H:%M:%S"), $pull_to_dir
Write-Output $screen_output