# WSUS-HealthCheck-Scripts

PowerShell scripts to check the status of WSUS services and ports, audit for vulnerabilities, and optionally stop/disable WSUS to mitigate risks.

---

## Features

- Check if WSUS and IIS services are running
- Test if WSUS default ports (8530/8531) are open
- Optional safe stop and disable of WSUS services
- Clear output for administrators to quickly assess risk
- Example outputs provided for reference

---

## Prerequisites

- Windows Server with PowerShell 5.1+ or PowerShell 7+
- Administrative privileges to query services and stop/start them
- Network access to WSUS server ports (8530/8531)

---

## Scripts

### `Check-WSUS-Status.ps1`

Checks the status of WSUS services and whether ports 8530 and 8531 are open.

**Usage:**

```powershell
.\Check-WSUS-Status.ps1
