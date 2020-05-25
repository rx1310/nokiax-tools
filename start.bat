:start1
mode con:cols=80 lines=32 > nul

@ECHO OFF
CLS
ECHO. Выбор действия: 
ECHO.    
ECHO.    1    - Установка драйверов для Nokia XL
ECHO.    2    - Установка CWM v6.0.4.8 
ECHO.    3    - Установка TWRP 2.7.0.2 
ECHO.    4    - Установка GOOGLE PLAY
ECHO.    5    - Удаление GOOGLE PLAY
ECHO.    6    - Установка ROOT (Superuser 3.1.3)
ECHO.    7    - Удаление ROOT
ECHO.    8    - Загрузка TWRP (без установки)
ECHO.    9    - Перейти в Recovery-меню
ECHO. 
ECHO.    0    - Выход
ECHO.

set INPUT=
set /P INPUT=  Пожалуйста, введите номер необходимого пункта и нажмите ввод: %=%
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
echo Устанавливаем драйвера ...

if defined ProgramFiles(x86) (
    echo Windows 64-bit detected   
    "%~dp0driver\dpinst_x64"
) else (
    echo Windows 32-bit detected  
    "%~dp0driver\dpinst_x86"
)

echo Установка завершена.
PAUSE
goto end

:cwm
CLS
ECHO.
ECHO Перед установкой необходимо: 
ECHO - Подключить телефон в режиме "Charging mode"
ECHO - Установить драйвера (пункт 1)
ECHO - Убедиться, что включен режим разработчика и отладка по USB
ECHO - Закрыты все приложения на телефоне
ECHO.
Pause
"%~dp0adb\adb" reboot bootloader
"%~dp0adb\fastboot" -i 0x0421 flash recovery "%~dp0recovery\cwm-6048-normandy.img"
"%~dp0adb\fastboot" -i 0x0421 reboot 
ECHO Установка завершена! Для перехода в рекавери-режим выключите телефон, 
ECHO затем удерживайте ~10сек клавиши увеличения громкости и питания.
ECHO.
PAUSE
goto end


:root
CLS
ECHO.
ECHO Перед установкой необходимо: 
ECHO - Подключить телефон в режиме "Charging mode"
ECHO - Установить драйвера (пункт 1)
ECHO - Убедиться, что включен режим разработчика и отладка по USB
ECHO - Закрыты все приложения на телефоне
ECHO.
Pause
"%~dp0adb\adb" shell setprop debug.adb.root 1
"%~dp0adb\adb" shell exit
"%~dp0adb\adb" root 
ECHO пожалуйста, подождите..
"%~dp0adb\adb" wait-for-device
ECHO пожалуйста, подождите..
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
ECHO Root-доступ предоставлен. Телефон будет перезагружен!
ECHO.
PAUSE
goto end

:unroot
CLS
ECHO.
ECHO Перед удалением необходимо: 
ECHO - Подключить телефон в режиме "Charging mode"
ECHO - Установить драйвера (пункт 1)
ECHO - Убедиться, что включен режим разработчика и отладка по USB
ECHO - Закрыты все приложения на телефоне
ECHO.
Pause
"%~dp0adb\adb" shell setprop debug.adb.root 1
"%~dp0adb\adb" shell exit
"%~dp0adb\adb" root 
ECHO пожалуйста, подождите..
"%~dp0adb\adb" wait-for-device
ECHO пожалуйста, подождите..
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
ECHO Root-доступ удален. Телефон будет перезагружен!
ECHO.
PAUSE
goto end

:twrp
CLS
ECHO.
ECHO Перед установкой необходимо: 
ECHO - Подключить телефон в режиме "Charging mode"
ECHO - Установить драйвера (пункт 1)
ECHO - Убедиться, что включен режим разработчика и отладка по USB
ECHO - Закрыты все приложения на телефоне
ECHO.
Pause
"%~dp0adb\adb" reboot bootloader
"%~dp0adb\fastboot" -i 0x0421 flash recovery "%~dp0recovery\TWRP-2.7.0.2-normandy.img"
"%~dp0adb\fastboot" -i 0x0421 reboot
ECHO Установка завершена! Для перехода в рекавери-режим выключите телефон, 
ECHO затем удерживайте ~10сек клавиши увеличения громкости и питания.
ECHO.
PAUSE
goto end


:to_rec
CLS
ECHO Переходим в recovery-меню... 
"%~dp0adb\adb" reboot recovery
ECHO Переход осуществлен!
goto end


:twrp_tmp
CLS
ECHO.
ECHO Перед установкой необходимо: 
ECHO - Подключить телефон в режиме "Charging mode"
ECHO - Установить драйвера (пункт 1)
ECHO - Убедиться, что включен режим разработчика и отладка по USB
ECHO - Закрыты все приложения на телефоне
ECHO.
Pause
ECHO.
ECHO.Сейчас телефон перейдет в Recovery-меню.
"%~dp0adb\adb" reboot bootloader
"%~dp0adb\fastboot" -i 0x0421 boot "%~dp0recovery\TWRP-2.7.0.2-normandy.img"
ECHO Загрузка завершена! Еще мгновение... 
ECHO.
PAUSE
goto end

:install
CLS
ECHO.
ECHO Перед установкой необходимо: 
ECHO - Подключить телефон в режиме "Charging mode"
ECHO - Установить драйвера (пункт 1)
ECHO - Убедиться, что включен режим разработчика и отладка по USB
ECHO - Закрыты все приложения на телефоне
ECHO.
Pause
"%~dp0adb\adb" shell setprop debug.adb.root 1
"%~dp0adb\adb" shell exit
"%~dp0adb\adb" root 
ECHO пожалуйста, подождите..
"%~dp0adb\adb" wait-for-device
ECHO пожалуйста, подождите..
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
ECHO GOOGLE PLAY Установлен!
ECHO.
PAUSE
goto end

:uninstall
CLS
ECHO.
ECHO Перед установкой необходимо: 
ECHO - Подключить телефон в режиме "Charging mode"
ECHO - Установить драйвера (пункт 1)
ECHO - Убедиться, что включен режим разработчика и отладка по USB
ECHO - Закрыты все приложения на телефоне
ECHO.
Pause
"%~dp0adb\adb" shell setprop debug.adb.root 1
"%~dp0adb\adb" shell exit
"%~dp0adb\adb" root 
ECHO пожалуйста, подождите..
"%~dp0adb\adb" wait-for-device
ECHO пожалуйста, подождите..
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
ECHO GOOGLE PLAY Удален!
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