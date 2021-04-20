$url_source = @('https://github.com/seangfrank0474/IR_Artifact_Report_MemAquisition/blob/main/ir_artifact_rprt_mem_acq.ps1', 'https://github.com/seangfrank0474/IR_Artifact_Report_MemAquisition/blob/main/winpmem.exe', 'https://github.com/seangfrank0474/IR_Artifact_Report_MemAquisition/blob/main/7za.exe', 'https://github.com/seangfrank0474/IR_Artifact_Report_MemAquisition/blob/main/7za.dll', 'https://github.com/seangfrank0474/IR_Artifact_Report_MemAquisition/blob/main/7zxa.dll')
Foreach ($url_line in $url_source) {
    $file_split = $url_line -split "/"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    foreach ($file in $file_split) {
        switch -Regex ($file){
            ".+\.(ps1|exe|dll)" { 
                $file_dest = $env:SystemRoot + "\Temp\" + $file
                Invoke-WebRequest -Uri $url_line -OutFile $file_dest
            }
        }
    }
}