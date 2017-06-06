@ECHO OFF
:STARTSS
cls

ECHO Please Pick a Command.
ECHO .
ECHO 1. Cut Start
ECHO 2. Cut End
ECHO 3. Split
ECHO 4. Quit
ECHO .

CHOICE /C 1234 /M "Please Pick a Command:"

IF ERRORLEVEL 4 GOTO End
IF ERRORLEVEL 3 GOTO CutSplit
IF ERRORLEVEL 2 GOTO CutEnd
IF ERRORLEVEL 1 GOTO CutStart

:CutStart
set choices=1
GOTO PreWork

:CutStartWork
ffmpeg.exe -i %SourceSS%\%SourceVid%.mp4 -t %CutTime% -c copy del/del.mp4 -ss %CutTime% -codec copy %SourceVid%.mp4
GOTO PostWork

:CutEnd
set choices=2
GOTO PreWork

:CutEndWork
ffmpeg.exe -i %SourceSS%\%SourceVid%.mp4 -t %CutTime% -c copy %SourceVid%.mp4 -ss %CutTime% -codec copy del/del.mp4
GOTO PostWork

:CutSplit
set choices=3
GOTO PreWork

:CutSplitWork
ffmpeg.exe -i %SourceSS%\%SourceVid%.mp4 -t %CutTime% -c copy %SourceVid%Part1.mp4 -ss %CutTime% -codec copy %SourceVid%Part2.mp4
pause
GOTO PostWork


:PreWork
cls
set /P SourceVid="Enter The Video Name (Without Extension):"
cls
set /P CutTime="Enter The Time To Cut (HH:MM:SS.MS):"
set h=%TIME:~0,2%
set m=%TIME:~3,2%
set s=%TIME:~6,2%
set SourceSS="Backup\%h% %m% %s% %SourceVid%"
mkdir %SourceSS%
move %SourceVid%.mp4 %SourceSS%
mkdir del
cls
if %choices%==1 GOTO CutStartWork
if %choices%==2 GOTO CutEndWork
if %choices%==3 GOTO CutSplitWork
GOTO End

:PostWork
rmdir /s /q del
GOTO STARTSS

:End
pause