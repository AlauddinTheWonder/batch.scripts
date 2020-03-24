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


REM Variables defination

Set /a minX=10
Set /a maxX=1000

Set /a minY=10
Set /a maxY=700

Set /a cnt=0

REM Add commands in Sequence
Set com[1]=Move
Set com[2]=LeftClick
Set com[3]=ScrollUp
Set com[4]=ScrollDown

REM Set number of commands
Set /a maxCnt=4



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

:Action
timeout /T 5 >nul

Set /a cnt=%cnt% + 1

If %cnt% GTR %maxCnt% Set /a cnt=1

Goto :Com_!com[%cnt%]!

Goto :End


:Com_Move
Set /a x=%RANDOM% * (%maxX% - %minX% + 1) / 32768 + %minX%
Set /a y=%RANDOM% * (%maxY% - %minY% + 1) / 32768 + %minY%

mouse.exe moveTo %x%x%y%
echo cursor moved to %x%x%y%

GOTO :Action

:Com_LeftClick
mouse.exe click
echo mouse left clicked

GOTO :Action


:Com_ScrollUp
Set /a sy=%RANDOM% * 200 / 32768 + 10

mouse.exe scrollUp %sy%
echo scrolled up by %sy%

GOTO :Action


:Com_ScrollDown
Set /a sy=%RANDOM% * 200 / 32768 + 10

mouse.exe scrollDown %sy%
echo scrolled down by %sy%

GOTO :Action



:End

echo Over to you!

timeout /T 5 >nul

exit
