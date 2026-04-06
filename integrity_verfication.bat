@ECHO OFF
TITLE System Integrity Verification Tool

:: Log the start time
ECHO ==================================================
ECHO System Integrity Verification Started: %DATE% %TIME%
ECHO ==================================================

:: 1. Disk Check: CHKDSK - Ensure file system integrity before proceeding.
ECHO [1/10] Running CHKDSK /f /r C:...
CHKDSK /f /r C:

:: 2. DISM: CheckHealth - Quickly determine if the component store is repairable.
ECHO [2/10] Running DISM /CheckHealth...
Dism.exe /online /cleanup-image /CheckHealth

:: 3. DISM: ScanHealth - Perform a deeper scan for corruption.
ECHO [3/10] Running DISM /ScanHealth...
Dism.exe /online /cleanup-image /ScanHealth

:: 4. DISM: RestoreHealth - Attempt to repair any found issues.
ECHO [4/10] Running DISM /RestoreHealth...
Dism.exe /online /cleanup-image /RestoreHealth

:: 5. SFC: System File Checker - Validate system files against a repaired image.
ECHO [5/10] Running SFC /scannow...
SFC /scannow

:: 6. DISM: Analyze Component Store - Assess the component store for cleanup opportunities.
ECHO [6/10] Running DISM /AnalyzeComponentStore...
Dism.exe /online /cleanup-image /AnalyzeComponentStore

:: 7. DISM: Start Component Cleanup - Remove superseded or unused components.
ECHO [7/10] Running DISM /StartComponentCleanup...
Dism.exe /online /cleanup-image /StartComponentCleanup

:: 8. PnP Clean for Drivers - Clean up driver store by removing unused driver packages.
ECHO [8/10] Running PnP Clean for drivers...
rundll32.exe pnpclean.dll,RunDLL_PnpClean /DRIVERS /MAXCLEAN

:: 9. Driver Signature Verification - Check for unsigned drivers.
ECHO [9/10] Running driver signature verification (sigverif.exe)...
sigverif.exe

:: 10. Windows Update Health Check - Trigger an update detection to verify update services.
ECHO [10/10] Triggering Windows Update detection...
wuauclt.exe /detectnow /reportnow

:: Log the end time
ECHO ==================================================
ECHO System Integrity Verification Completed: %DATE% %TIME%
ECHO ==================================================
PAUSE