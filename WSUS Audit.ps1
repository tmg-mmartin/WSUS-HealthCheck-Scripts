# ================================
# WSUS Health Check & Control Script
# ================================

# WSUS service names
$wsusServices = @("WsusService", "W3SVC")  # W3SVC is IIS service hosting WSUS

# WSUS ports
$wsusPorts = @(8530, 8531)

Write-Output "=== WSUS Service Status ==="
$runningServices = @()
$stoppedServices = @()

foreach ($service in $wsusServices) {
    $svc = Get-Service -Name $service -ErrorAction SilentlyContinue
    if ($svc) {
        if ($svc.Status -eq 'Running') {
            Write-Output "$($svc.Name) is Running"
            $runningServices += $svc.Name
        } else {
            Write-Output "$($svc.Name) is Not Running"
            $stoppedServices += $svc.Name
        }
    } else {
        Write-Output "$service not found on this system."
    }
}

Write-Output "`n=== WSUS Port Status ==="
foreach ($port in $wsusPorts) {
    $test = Test-NetConnection -ComputerName localhost -Port $port
    if ($test.TcpTestSucceeded) {
        Write-Output "Port $port is OPEN"
    } else {
        Write-Output "Port $port is CLOSED"
    }
}

# Decide whether to ask about stopping/disabling WSUS
if ($runningServices.Count -eq 0) {
    Write-Output "`nAll WSUS services are already stopped."
} else {
    Write-Output "`nThe following WSUS services are currently running: $($runningServices -join ', ')"
    $disableWSUS = Read-Host "Do you want to stop and disable these WSUS services? (Y/N)"
    if ($disableWSUS -eq "Y") {
        foreach ($service in $runningServices) {
            Stop-Service -Name $service -Force
            Set-Service -Name $service -StartupType Disabled
            Write-Output "$service stopped and disabled."
        }
        Write-Output "WSUS services have been stopped and disabled."
    } else {
        Write-Output "No changes made to WSUS services."
    }
}
