@echo off


SetLocal EnableDelayedExpansion

:SIGNATURE
echo ################################################
echo ########## Created by Alauddin Ansari ##########
echo ############# Windows Mouse Control ############
echo ################ Mar, 2020 #####################
echo ################################################
echo.
echo.

echo Taking control...
echo.


Set /a minX=10
Set /a maxX=1000

Set /a minY=10
Set /a maxY=700



:CheckScript
If Exist mouse.bat Goto :CheckExe

echo mouse.bat file not exists.
Goto :End


:CheckExe
If Not Exist mouse.exe (
	echo generating mouse.exe
	call mouse.bat position >nul
	
	If Exist mouse.exe (
		echo generated successfully
		GOTO :Start
	)
	
	echo error in generating mouse.exe
	echo check mouse.bat

	GOTO :End
)

:Start
echo.
timeout /T 5 >nul

:Action

:Move
Set /a x=%RANDOM% * (%maxX% - %minX% + 1) / 32768 + %minX%
Set /a y=%RANDOM% * (%maxY% - %minY% + 1) / 32768 + %minY%

mouse.exe moveTo %x%x%y%
echo cursor moved to %x%x%y%

timeout /T 5 >nul



GOTO :Action


:End

echo Over to you!

timeout /T 5 >nul

exit
