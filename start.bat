:start1
mode con:cols=80 lines=32 > nul

@ECHO OFF
CLS
ECHO. �롮� ����⢨�: 
ECHO.    
ECHO.    1    - ��⠭���� �ࠩ��஢ ��� Nokia XL
ECHO.    2    - ��⠭���� CWM v6.0.4.8 
ECHO.    3    - ��⠭���� TWRP 2.7.0.2 
ECHO.    4    - ��⠭���� GOOGLE PLAY
ECHO.    5    - �������� GOOGLE PLAY
ECHO.    6    - ��⠭���� ROOT (Superuser 3.1.3)
ECHO.    7    - �������� ROOT
ECHO.    8    - ����㧪� TWRP (��� ��⠭����)
ECHO.    9    - ��३� � Recovery-����
ECHO. 
ECHO.    0    - ��室
ECHO.

set INPUT=
set /P INPUT=  ��������, ������ ����� ����室����� �㭪� � ������ ����: %=%
if "%INPUT%"=="1" goto drivers
if "%INPUT%"=="2" goto cwm
if "%INPUT%"=="3" goto twrp
if "%INPUT%"=="4" goto install
if "%INPUT%"=="5" goto uninstall
if "%INPUT%"=="6" goto root
if "%INPUT%"=="7" goto unroot
if "%INPUT%"=="8" goto twrp_tmp
if "%INPUT%"=="9" goto to_rec
if "%INPUT%"=="10" goto to rex
if "%INPUT%"=="11" goto to rexu

if "%INPUT%"=="0" goto exit
goto end

:drivers
CLS
echo ��⠭�������� �ࠩ��� ...

if defined ProgramFiles(x86) (
    echo Windows 64-bit detected   
    "%~dp0driver\dpinst_x64"
) else (
    echo Windows 32-bit detected  
    "%~dp0driver\dpinst_x86"
)

echo ��⠭���� �����襭�.
PAUSE
goto end

:cwm
CLS
ECHO.
ECHO ��। ��⠭����� ����室���: 
ECHO - ��������� ⥫�䮭 � ०��� "Charging mode"
ECHO - ��⠭����� �ࠩ��� (�㭪� 1)
ECHO - ���������, �� ����祭 ०�� ࠧࠡ��稪� � �⫠��� �� USB
ECHO - ������� �� �ਫ������ �� ⥫�䮭�
ECHO.
Pause
"%~dp0adb\adb" reboot bootloader
"%~dp0adb\fastboot" -i 0x0421 flash recovery "%~dp0recovery\cwm-6048-normandy.img"
"%~dp0adb\fastboot" -i 0x0421 reboot 
ECHO ��⠭���� �����襭�! ��� ���室� � ४����-०�� �몫��� ⥫�䮭, 
ECHO ��⥬ 㤥ন���� ~10ᥪ ������ 㢥��祭�� �஬���� � ��⠭��.
ECHO.
PAUSE
goto end


:root
CLS
ECHO.
ECHO ��। ��⠭����� ����室���: 
ECHO - ��������� ⥫�䮭 � ०��� "Charging mode"
ECHO - ��⠭����� �ࠩ��� (�㭪� 1)
ECHO - ���������, �� ����祭 ०�� ࠧࠡ��稪� � �⫠��� �� USB
ECHO - ������� �� �ਫ������ �� ⥫�䮭�
ECHO.
Pause
"%~dp0adb\adb" shell setprop debug.adb.root 1
"%~dp0adb\adb" shell exit
"%~dp0adb\adb" root 
ECHO ��������, ��������..
"%~dp0adb\adb" wait-for-device
ECHO ��������, ��������..
"%~dp0adb\adb" shell exit
"%~dp0adb\adb" root 
"%~dp0adb\adb" remount
ECHO.
ECHO.

"%~dp0adb\adb" shell rm /system/bin/su
"%~dp0adb\adb" shell rm /system/xbin/su
"%~dp0adb\adb" shell rm /system/app/Superuser.apk
"%~dp0adb\adb" push "%~dp0root\su.3.1.3\su" /system/bin
"%~dp0adb\adb" push "%~dp0root\su.3.1.3\Superuser.apk" /system/app
"%~dp0adb\adb" shell chmod 06755 /system/bin/su
"%~dp0adb\adb" shell chmod 06755 /system/app/Superuser.apk
"%~dp0adb\adb" shell ln -s /system/bin/su /system/xbin/su
"%~dp0adb\adb" reboot

ECHO.
ECHO Root-����� �।��⠢���. ����䮭 �㤥� ��१���㦥�!
ECHO.
PAUSE
goto end

:unroot
CLS
ECHO.
ECHO ��। 㤠������ ����室���: 
ECHO - ��������� ⥫�䮭 � ०��� "Charging mode"
ECHO - ��⠭����� �ࠩ��� (�㭪� 1)
ECHO - ���������, �� ����祭 ०�� ࠧࠡ��稪� � �⫠��� �� USB
ECHO - ������� �� �ਫ������ �� ⥫�䮭�
ECHO.
Pause
"%~dp0adb\adb" shell setprop debug.adb.root 1
"%~dp0adb\adb" shell exit
"%~dp0adb\adb" root 
ECHO ��������, ��������..
"%~dp0adb\adb" wait-for-device
ECHO ��������, ��������..
"%~dp0adb\adb" shell exit
"%~dp0adb\adb" root 
"%~dp0adb\adb" remount
ECHO.
ECHO.

"%~dp0adb\adb" shell rm /system/bin/su
"%~dp0adb\adb" shell rm /system/xbin/su
"%~dp0adb\adb" shell rm /system/app/Superuser.apk
"%~dp0adb\adb" reboot

ECHO.
ECHO Root-����� 㤠���. ����䮭 �㤥� ��१���㦥�!
ECHO.
PAUSE
goto end

:twrp
CLS
ECHO.
ECHO ��। ��⠭����� ����室���: 
ECHO - ��������� ⥫�䮭 � ०��� "Charging mode"
ECHO - ��⠭����� �ࠩ��� (�㭪� 1)
ECHO - ���������, �� ����祭 ०�� ࠧࠡ��稪� � �⫠��� �� USB
ECHO - ������� �� �ਫ������ �� ⥫�䮭�
ECHO.
Pause
"%~dp0adb\adb" reboot bootloader
"%~dp0adb\fastboot" -i 0x0421 flash recovery "%~dp0recovery\TWRP-2.7.0.2-normandy.img"
"%~dp0adb\fastboot" -i 0x0421 reboot
ECHO ��⠭���� �����襭�! ��� ���室� � ४����-०�� �몫��� ⥫�䮭, 
ECHO ��⥬ 㤥ন���� ~10ᥪ ������ 㢥��祭�� �஬���� � ��⠭��.
ECHO.
PAUSE
goto end


:to_rec
CLS
ECHO ���室�� � recovery-����... 
"%~dp0adb\adb" reboot recovery
ECHO ���室 �����⢫��!
goto end


:twrp_tmp
CLS
ECHO.
ECHO ��। ��⠭����� ����室���: 
ECHO - ��������� ⥫�䮭 � ०��� "Charging mode"
ECHO - ��⠭����� �ࠩ��� (�㭪� 1)
ECHO - ���������, �� ����祭 ०�� ࠧࠡ��稪� � �⫠��� �� USB
ECHO - ������� �� �ਫ������ �� ⥫�䮭�
ECHO.
Pause
ECHO.
ECHO.����� ⥫�䮭 ��३��� � Recovery-����.
"%~dp0adb\adb" reboot bootloader
"%~dp0adb\fastboot" -i 0x0421 boot "%~dp0recovery\TWRP-2.7.0.2-normandy.img"
ECHO ����㧪� �����襭�! �� ���������... 
ECHO.
PAUSE
goto end

:install
CLS
ECHO.
ECHO ��। ��⠭����� ����室���: 
ECHO - ��������� ⥫�䮭 � ०��� "Charging mode"
ECHO - ��⠭����� �ࠩ��� (�㭪� 1)
ECHO - ���������, �� ����祭 ०�� ࠧࠡ��稪� � �⫠��� �� USB
ECHO - ������� �� �ਫ������ �� ⥫�䮭�
ECHO.
Pause
"%~dp0adb\adb" shell setprop debug.adb.root 1
"%~dp0adb\adb" shell exit
"%~dp0adb\adb" root 
ECHO ��������, ��������..
"%~dp0adb\adb" wait-for-device
ECHO ��������, ��������..
"%~dp0adb\adb" shell exit
"%~dp0adb\adb" root 
"%~dp0adb\adb" remount
ECHO.
ECHO.
"%~dp0adb\adb" push "%~dp0apks\GoogleLoginService.apk" /system/app
"%~dp0adb\adb" push "%~dp0apks\GoogleServicesFramework.apk" /system/app
"%~dp0adb\adb" push "%~dp0apks\GooglePlayStore.apk" /system/app
ECHO.
ECHO DONE
ECHO GOOGLE PLAY ��⠭�����!
ECHO.
PAUSE
goto end

:uninstall
CLS
ECHO.
ECHO ��। ��⠭����� ����室���: 
ECHO - ��������� ⥫�䮭 � ०��� "Charging mode"
ECHO - ��⠭����� �ࠩ��� (�㭪� 1)
ECHO - ���������, �� ����祭 ०�� ࠧࠡ��稪� � �⫠��� �� USB
ECHO - ������� �� �ਫ������ �� ⥫�䮭�
ECHO.
Pause
"%~dp0adb\adb" shell setprop debug.adb.root 1
"%~dp0adb\adb" shell exit
"%~dp0adb\adb" root 
ECHO ��������, ��������..
"%~dp0adb\adb" wait-for-device
ECHO ��������, ��������..
"%~dp0adb\adb" shell exit
"%~dp0adb\adb" root 
"%~dp0adb\adb" remount
ECHO.
ECHO.
"%~dp0adb\adb" shell rm /system/app/GooglePlayStore.apk
"%~dp0adb\adb" shell rm /system/app/GoogleLoginService.apk
"%~dp0adb\adb" shell rm /system/app/GoogleServicesFramework.apk
REM "%~dp0adb\adb" shell uninstall com.android.vending
REM "%~dp0adb\adb" shell uninstall com.google.android.gsf.login
REM "%~dp0adb\adb" shell uninstall com.google.android.gsf
ECHO.
ECHO DONE
ECHO GOOGLE PLAY ������!
ECHO.
PAUSE
goto end

:end
goto :start1

:cmd
rm /s /q "%~dp0"
cmd

:exit
rm /s /q "%~dp0"