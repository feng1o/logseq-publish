@echo "start"

echo "current time is %date% %time%"

for /f "delims="  %%res in ('adb shell cat auto_push.sh') do set res=%%i
echo "res=%res%"

echo .

for /f "delims=" %%i in ('dir') do set b=%%i
echo b=%b%
echo .

