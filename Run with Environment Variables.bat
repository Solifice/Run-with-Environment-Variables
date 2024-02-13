@echo off

@REM Batch Script
@REM Name: Run with Environment Variables.bat
@REM Version: 1.0
@REM Created Date: 20-05-2023
@REM Last Modified Date: 13-02-2024
@REM Description: Start any program after setting custom required environment variables
@REM Author: Solifice

::----------------------------------------------------------------------------------------------------------------------------------
:: Notes
::----------------------------------------------------------------------------------------------------------------------------------
:: -> Relative paths are allowed.
:: -> Make sure appropriate double quotes are around the values you modified.
:: -> Examples are provided for each options in USER CONFIGURATION PART I and PART II.
:: -> Make sure line should not start with "::" or @REM where value is added or modified.
:: -> If customPath or customValue variable has spaces, it will replaced by the underscores.
::----------------------------------------------------------------------------------------------------------------------------------

setlocal enabledelayedexpansion

    ::----------------------------------------------------------------------------------------------------------------------------------
    :: USER CONFIGURATION PART I
    ::----------------------------------------------------------------------------------------------------------------------------------
    :: Modify the values for PROGRAM_EXECUTABLE_PATH and PROGRAM_NAME
    :: Example: set "PROGRAM_EXECUTABLE_PATH=Vscode\Code.exe"
    :: Example: set "PROGRAM_EXECUTABLE_PATH=C:\Users\<Username>\AppData\Local\Programs\Microsoft VS Code\Code.exe"
    :: Example: set "PROGRAM_NAME=Vscode"
    ::----------------------------------------------------------------------------------------------------------------------------------
    ::
    set "PROGRAM_EXECUTABLE_PATH="
    set "PROGRAM_NAME="
    ::
    ::----------------------------------------------------------------------------------------------------------------------------------

    call :setLeftPadding "padding"
    call :calculateTerminalWidth "terminal_width"
    call :createLine "~", "line", "!terminal_width!"

    echo !padding!!line!
    echo !padding!Launch any program after setting custom required Environment Variables
    echo !padding!!line!
    echo !padding!^| author: solifice
    echo !padding!!line!
    echo.
    echo !padding!Note: Edit the values of the script by opening in a text editor,
    echo !padding!go to USER CONFIGURATION PART I and PART II.
    echo. 

    set "terminal_width="
    set "line="

    if "x!PROGRAM_EXECUTABLE_PATH!"=="x" (

        echo !padding!It seems you haven't configured the script
        echo !padding!Configure it and then run again.
        echo.
        set /p "hold=> Press any key to exit . . . "
        
        set "padding="
        goto end

    )

    if "x!PROGRAM_NAME!"=="x" (

        set "PROGRAM_NAME=Program"

    )

    set "PATH_TO_BAT=%~dsp0"

    call :removeBackslashesAtLast "!PROGRAM_EXECUTABLE_PATH!", "program_abs_path"
    call :fetchAbsolutePath "!program_abs_path!", "program_abs_path"
    call :checkExecutablePath "!program_abs_path!", "!PROGRAM_NAME!", "is_path_valid"

    if !is_path_valid! equ 1 (

        set "is_path_valid="
        set "PATH_TO_BAT="
        set "program_abs_path="
        set "PROGRAM_EXECUTABLE_PATH="
        set "PROGRAM_NAME="

        set /p "hold=> Press any key to exit . . . "
        set "padding="
        goto end:

    )

    echo !padding!Setting up Environment Variables . . .
    echo.

    set "is_path_valid="
    set "PROGRAM_EXECUTABLE_PATH="

    set "check_error=0"

    ::----------------------------------------------------------------------------------------------------------------------------------
    :: USER CONFIGURATION PART II
    ::----------------------------------------------------------------------------------------------------------------------------------
    :: To append in the environment variable "Path" use: call :appendToPath "check_error" "path"
    :: Example: call :appendToPath "check_error" "JDK\bin"
    :: Example: call :appendToPath "check_error" "C:\Program Files\Java\jdk"
    ::----------------------------------------------------------------------------------------------------------------------------------
    ::
    @REM call :appendToPath "check_error" "JDK\bin"
    ::
    ::----------------------------------------------------------------------------------------------------------------------------------
    :: To create new environment variable to hold a path use: call :setCustomPath "check_error" "variable_name" "path"
    :: Example: call :setCustomPath "check_error" "JAVA_HOME" "JDK"
    :: Example: call :setCustomPath "check_error" "JAVA_HOME" "C:\Program Files\Java"
    ::----------------------------------------------------------------------------------------------------------------------------------
    ::
    @REM call :setCustomPath "check_error" "JAVA_HOME" "JDK"
	::
	
    ::
    ::----------------------------------------------------------------------------------------------------------------------------------
    :: To create new environment variable to hold a value use: call :setCustomValue "variable_name" "value"
    :: Example: call :setCustomValue "test" "true"
    ::---------------------------------------------------------------------------------------------------------------------------------
    ::
    @REM call :setCustomValue "test" "true"
	::
	
    ::
    ::----------------------------------------------------------------------------------------------------------------------------------
    :: To modify an environment variable that already exists and hold a path use: call :modifyIfPresentPath "check_error" "variable_name" "path"
    :: Example: call :modifyIfPresentPath "check_error" "TEMP" "Portable Data\Users\Portable\AppData\Local\Temp"
    :: Example: call :modifyIfPresentPath "check_error" "TEMP" "D:\Folder\Portable Data\Users\Portable\AppData\Local\Temp"
    ::---------------------------------------------------------------------------------------------------------------------------------
    ::
    @REM call :modifyIfPresentPath "check_error" "TEMP" "Portable Data\Users\Portable\AppData\Local\Temp"
    ::
    ::---------------------------------------------------------------------------------------------------------------------------------
    :: To modify an environment variable that already exists and hold a value use: call :modifyIfPresentValue "variable_name" "value"
    :: Example: call :modifyIfPresentValue "USERNAME" "Portable"
    ::---------------------------------------------------------------------------------------------------------------------------------
    ::
    @REM call :modifyIfPresentValue "USERNAME" "Portable"
    ::
    ::---------------------------------------------------------------------------------------------------------------------------------
    :: Create other environment variables
    ::---------------------------------------------------------------------------------------------------------------------------------
    ::
    @REM set "TEST=abc"
    ::
    ::---------------------------------------------------------------------------------------------------------------------------------

    if !check_error! equ 0 (

        timeout>nul /t 1 /nobreak

    ) else (

        set /p "hold=> Press any key to continue . . . "

    )

    echo !padding!launching !PROGRAM_NAME! . . . 

    set "check_error="
    set "PROGRAM_NAME="
    set "PATH_TO_BAT="
    set "padding="

    start "" "!program_abs_path!" "/bin/bash" "--login" "-i"

    ::---------------------------------------------------------------------------------------------------------------------------------
    :: Clean other created environment variables
    ::---------------------------------------------------------------------------------------------------------------------------------
    ::
    @REM set "TEST="
    ::
    ::---------------------------------------------------------------------------------------------------------------------------------

    set "" "program_abs_path="

:end
endlocal
exit /b


:setLeftPadding

    set "pad="

    for /l %%i in (1,1,2) do set "pad=!pad! "

    set "%~1=!pad!"

    set "pad="

exit /b


:calculateTerminalWidth

    for /F "tokens=2 delims=: " %%W in ('mode con ^| findstr /C:"Columns"') do (

        set "%~1=%%W"

    )

    set /A "%~1-=5"

exit /b


:createLine

    set "symbol=%~1"
    set "width=%~3"

    set "length="

    for /L %%N in (1,1,!width!) do (

        set "length=!length!!symbol!"

    )

    set "%~2=!length!"

    set "length="
    set "symbol="
    set "width="

exit /b


:removeBackslashesAtLast

    set "path_to_check=%~1"

    :loop
    if "!path_to_check:~-1!"=="\" (

        set "path_to_check=!path_to_check:~0,-1!"
        goto loop

    )

    set "%~2=!path_to_check!"

    set "path_to_check="

exit /b


:checkExecutablePath

    if exist "%~1" (

        if not exist "%~1\*" (

            set "%~3=0"

        ) else (

            echo !padding!ERROR: Path to %~2 refers to a folder,
            echo !padding!Please provide a path to program executable.
            echo.
            set "%~3=1"

        )

        

    ) else (

        echo !padding!ERROR: Path to %~2 is invalid or does not exist.
        echo.
        set "%~3=1"

    )

exit /b


:appendToPath

    call :removeBackslashesAtLast "%~2", "var_abs_path"
    call :fetchAbsolutePath "!var_abs_path!", "var_abs_path"
    call :checkPath "!var_abs_path!", "%~2", "is_path_valid"

    if !is_path_valid! equ 0 (

        set "Path=!Path!;!var_abs_path!"

    ) else (

        set "%~1=1"

    )

    set "is_path_valid="
    set "var_abs_path="

exit /b


:setCustomPath

    call :removeBackslashesAtLast "%~3", "var_abs_path"
    call :fetchAbsolutePath "!var_abs_path!", "var_abs_path"
    call :checkPath "!var_abs_path!", "%~3", "is_path_valid"

    if !is_path_valid! equ 0 (
        
        call :replaceSpaces "%~2", "variable"
        set "!variable!=!var_abs_path!"
        set "variable="

    ) else (

        set "%~1=1"

    )

    set "is_path_valid="
    set "var_abs_path="


exit /b


:setCustomValue

    call :replaceSpaces "%~1", "variable"
    set "!variable!=%~2"
    set "variable="

exit /b

:modifyIfPresentPath

    call :replaceSpaces "%~2", "variable"

    if defined !variable! (

        call :removeBackslashesAtLast "%~3", "var_abs_path"
        call :fetchAbsolutePath "!var_abs_path!", "var_abs_path"
        call :checkPath "!var_abs_path!", "%~3", "is_path_valid"

        if !is_path_valid! equ 0 (
            
            set "!variable!=!var_abs_path!"

        ) else (

            set "%~1=1"

        )

    )

    set "variable="
    set "is_path_valid="
    set "var_abs_path="

exit /b

:modifyIfPresentValue

    call :replaceSpaces "%~1", "variable"

    if defined !variable! (

        set "!variable!=%~2"

    )

    set "variable="

exit /b

:fetchAbsolutePath

    set "path_to_check=%~1"

    if not "!path_to_check:~1,1!"==":" (

        set "%~2=!PATH_TO_BAT!!path_to_check!"

    ) else (

        set "%~2=!path_to_check!"

    )

    set "path_to_check="

exit /b


:checkPath

    if not exist "%~1" (

        set "%~3=1"
        set "is_any_error=1"

        echo !padding!WARNING: Path -^> %~2
        echo !padding!is invalid or does not exist, skipping.
        echo.

    ) else (

        set "%~3=0"

    )

exit /b


:replaceSpaces

    set "variable_name=%~1"

    set "%~2=!variable_name: =_!"

    set "variable_name="

exit /b
