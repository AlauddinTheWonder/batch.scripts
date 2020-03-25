@echo off


SetLocal EnableDelayedExpansion


REM Add commands in Sequence

REM Available commands: Move LeftClick RightClick ScrollUp ScrollDown

Set "ComList=Move RightClick LeftClick ScrollUp ScrollDown"



REM Don't try to change anything below

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

Set /a minT=5
Set /a maxT=15

Set /a cnt=0

set /a maxCnt=0
for %%a in (%ComList%) do (
   set com[!maxCnt!]=%%a
   set /A maxCnt+=1
)


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
Set /a t=%RANDOM% * (%maxT% - %minT% + 1) / 32768 + %minT%
echo waiting for %t% seconds...

timeout /T %t% >nul

Set /a cnt=%cnt% + 1

If %cnt% GTR %maxCnt% Set /a cnt=1

Set /a curComm=%cnt% - 1

echo calling !com[%curComm%]!

Goto :Com_!com[%curComm%]!

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

:Com_RightClick
mouse.exe rightClick
echo mouse right clicked

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
