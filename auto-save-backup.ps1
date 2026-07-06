$Source = "$env:USERPROFILE\SOURCESAVEFOLDERPATH"
$BackupRoot = "$env:USERPROFILE\PATHTOCOPYSAVES"

$IntervalSeconds = 30
$KeepLastBackups = 80

New-Item -ItemType Directory -Force -Path $BackupRoot | Out-Null

function Get-SaveSignature {
    if (-not (Test-Path $Source)) {
        return ""
    }

    Get-ChildItem $Source -Recurse -File |
        Sort-Object FullName |
        ForEach-Object {
            "$($_.FullName)|$($_.Length)|$($_.LastWriteTimeUtc.Ticks)"
        } | Out-String
}

function Make-Backup {
    $timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
    $dest = Join-Path $BackupRoot "backup_$timestamp"

    New-Item -ItemType Directory -Force -Path $dest | Out-Null

    robocopy $Source $dest /E /R:2 /W:1 /NFL /NDL /NJH /NJS /NP | Out-Null

    Write-Host "[$(Get-Date -Format 'HH:mm:ss')] Backup created: $dest"

    $backups = Get-ChildItem $BackupRoot -Directory |
        Sort-Object CreationTime -Descending

    $backups |
        Select-Object -Skip $KeepLastBackups |
        Remove-Item -Recurse -Force
}

Write-Host "Watching saves:"
Write-Host $Source
Write-Host "Backups:"
Write-Host $BackupRoot
Write-Host ""

$lastSignature = Get-SaveSignature

while ($true) {
    Start-Sleep -Seconds $IntervalSeconds

    $currentSignature = Get-SaveSignature

    if ($currentSignature -ne $lastSignature -and $currentSignature -ne "") {
        Write-Host "[$(Get-Date -Format 'HH:mm:ss')] Change detected. Waiting for files to settle..."
        Start-Sleep -Seconds 5

        $settledSignature = Get-SaveSignature

        if ($settledSignature -eq $currentSignature) {
            Make-Backup
            $lastSignature = $settledSignature
        }
        else {
            Write-Host "Files are still changing, skipping this cycle."
        }
    }
}
