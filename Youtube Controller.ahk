;============================== Start Auto-Execution Section ==============================

; Keeps script permanently running
#Persistent

; Avoids checking empty variables to see if they are environment variables
; Recommended for performance and compatibility with future AutoHotkey releases
#NoEnv

; Ensures that there is only a single instance of this script running
#SingleInstance, Force

;Determines whether invisible windows are "seen" by the script
DetectHiddenWindows, On

; Makes a script unconditionally use its own folder as its working directory
; Ensures a consistent starting directory
SetWorkingDir %A_ScriptDir%

; sets title matching to search for "containing" instead of "exact"
SetTitleMatchMode, 2

;sets controlID to 0 every time the script is reloaded
controlID       := 0




;======================== Google Chrome Functions ========================


SelectChrome()
{
    ; Gets the control ID of google chrome
    ControlGet, controlID, Hwnd,,Chrome_RenderWidgetHostHWND1, Google Chrome

    ; Focuses on chrome without breaking focus on what you're doing
    ControlFocus,,ahk_id %controlID%
}


YoutubeFinder()
{
    ; Sends ctrl+1 to your browser to set it at tab 1
    ControlSend, Chrome_RenderWidgetHostHWND1, ^1, Google Chrome

    ; Starts loop to find a tab with "Youtube" in the name
    Loop
    {
        IfWinExist, - YouTube -
        {ControlSend, ,{Control Up}, Google Chrome
            break
        }
        ;Scrolls through the tabs.
        ControlSend, ,{Control Down}{Tab}, Google Chrome

        Sleep, 5
        ; if the script starts tabbing through page or misses the right tab, increase the number after "Sleep"
        ; Sleep, is measures in milliseconds. 1000 ms = 1 sec
    }
}



;======================== Main Hotkey Functions ========================

; This is the main function of the script that will accept a key to be pressed via its parameter
;Multi-key Presses seem to only work when stored in variable with different syntax as shown below
; AHK has limited support with nested functions so some repetitive actions have been written out by hand here.


RunScript(KeyPress)
{
    SelectChrome()

    IfWinExist, - YouTube -
    {
        ControlSend, Chrome_RenderWidgetHostHWND1, {%KeyPress%}, Google Chrome
        return
    }

    YoutubeFinder()

    ControlSend, Chrome_RenderWidgetHostHWND1, {%KeyPress%}, Google Chrome
}


RunScriptMulti(KeyPress)
{
    SelectChrome()

    IfWinExist, - YouTube -
    {
        ControlSend, Chrome_RenderWidgetHostHWND1, %KeyPress%, Google Chrome
        return
    }

    YoutubeFinder()

    ControlSend, Chrome_RenderWidgetHostHWND1, %KeyPress%, Google Chrome
}




;============================== Pause ==============================
#IfWinNotActive, ahk_exe chrome.exe

^space::
    RunScript("k")
    ; Sends the K button to chrome
    ; K is the dedicated pause/un-pause hotkey for YouTube (People think space is. Don't use space!
    ; Space will scroll you down the youtube page when the player doesn't have focus.
return



;============================ Rewind ===============================

!Left::
    RunScript("Left")
return



;============================ Fast Forward ===============================

!Right::
    RunScript("Right")
return



;============================ Fullscreen ===============================

!f::
    RunScript("f")
return



;============================ Volume Up ===============================

!=::
    RunScript("Up")
return



;============================ Volume Down ===============================

!-::
    RunScript("Down")
return



;============================ Next Video ===============================

^+!Right::
    RunScriptMulti("+N")
return



;============================ Previous Video ===============================

^+!Left::
    ;This specific key combination [Alt + Left] doesn't work without separating arrow keys into their own curly brackets
    SelectChrome()

    IfWinExist, - YouTube -
    {
        ControlSend, Chrome_RenderWidgetHostHWND1, !{Left}, Google Chrome
        return
    }

    YoutubeFinder()

    ControlSend, Chrome_RenderWidgetHostHWND1, !{Left}, Google Chrome
return


#IfWinNotActive
;============================== End Script ==============================