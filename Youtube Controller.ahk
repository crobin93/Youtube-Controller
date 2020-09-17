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


;======================== Google Chrome Function ========================

; This is the main function of the script that will accept a key to be pressed via its parameter
RunScript(KeyPress)
{
    ; Gets the control ID of google chrome
    ControlGet, controlID, Hwnd,,Chrome_RenderWidgetHostHWND1, Google Chrome

    ; Focuses on chrome without breaking focus on what you're doing
    ControlFocus,,ahk_id %controlID%

    ; Checks to make sure YouTube isn't the first tab before starting the loop
    ; Saves time when youtube is the tab it's on
    IfWinExist, YouTube
    {
        ControlSend, Chrome_RenderWidgetHostHWND1, {%KeyPress%}, Google Chrome
        return
    }

    ; Sends ctrl+1 to your browser to set it at tab 1
    ControlSend, Chrome_RenderWidgetHostHWND1, ^1, Google Chrome

    ; Starts loop to find a tab with "Youtube" in the name
    Loop
    {
        IfWinExist, YouTube
        {ControlSend, ,{Control Up}, Google Chrome
            break
        }
        ;Scrolls through the tabs.
        ControlSend, ,{Control Down}{Tab}, Google Chrome

        ; if the script acts weird and starts tabbing through page, add "Sleep, 50" to line above this
        ; Sleep, is measures in milliseconds. 1000 ms = 1 sec
    }

    ; Sleep, 50
    ; Uncomment Sleep line above if keystrokes are not registered

    ControlSend, Chrome_RenderWidgetHostHWND1, {%KeyPress%}, Google Chrome
}

return
;============================== Pause ==============================
#IfWinNotActive, ahk_exe chrome.exe

ctrl & space::
    RunScript("k")
    ; Sends the K button to chrome
    ; K is the dedicated pause/un-pause hotkey for YouTube (People think space is. Don't use space!
    ; Space will scroll you down the youtube page when the player doesn't have focus.
return



;============================ Rewind ===============================

alt & Left::
    RunScript("Left")
return



;============================ Fast Forward ===============================

alt & Right::
    RunScript("Right")
return



;============================ Fullscreen ===============================

alt & f::
    RunScript("f")
return



;============================ Volume Up ===============================

alt & =::
    RunScript("Up")
return



;============================ Volume Down ===============================

alt & -::
    RunScript("Down")
return



#IfWinNotActive
;============================== End Script ==============================