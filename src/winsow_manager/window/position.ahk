; unknown: WinGetPosEx (https://autohotkey.com/boards/viewtopic.php?t=3392; 2016-01-18: retrieved "Error 404 - File not found")
window_rect(id) {
    static Dummy5693, RECTPlus, S_OK := 0x0, DWMWA_EXTENDED_FRAME_BOUNDS := 9

    value := {}

    ;-- Workaround for AutoHotkey Basic
    ptr_type := (A_PtrSize = 8) ? "Ptr" : "UInt"

    ;-- Get the window's dimensions
    ;   Note: Only the first 16 bytes of the RECTPlus structure are used by the
    ;   DwmGetWindowAttribute and GetWindowRect functions.
    VarSetCapacity(RECTPlus, 24,0)

    dwmrc := DllCall("dwmapi\DwmGetWindowAttribute"
        ; hwnd
        , ptr_type, id
        ; dwAttribute
        , "UInt", DWMWA_EXTENDED_FRAME_BOUNDS
        ; pvAttribute
        , ptr_type, &RECTPlus
        ; cbAttribute 
        , "UInt", 16)

    if (dwmrc <> S_OK) {
        ;-- Dll or function not found (older than Vista)
        if (ErrorLevel in -3, -4) {
            ;-- Do nothing else (for now)
        }
        else
            outputdebug,
                (LTrim Join`s
                Function: %A_ThisFunc% -
                Unknown error calling "dwmapi\DwmGetWindowAttribute".
                RC = %dwmrc%,
                ErrorLevel = %ErrorLevel%,
                A_LastError = %A_LastError%.
                "GetWindowRect" used instead.
                )

        ;-- Collect the position and size from "GetWindowRect"
        DllCall("GetWindowRect", ptr_type id, ptr_type &RECTPlus)
    }

    ;-- Populate the output variables
    value["x"] := Left := NumGet(RECTPlus, 0, "Int")
    value["y"] := Top  := NumGet(RECTPlus, 4, "Int")
    Right  := NumGet(RECTPlus, 8, "Int")
    Bottom := NumGet(RECTPlus, 12, "Int")
    value["width"] := Right - Left
    value["height"] := Bottom - Top
    value["offSet_x"] := 0
    value["offSet_y"] := 0

    ;-- if DWM is not used (older than Vista or DWM not enabled), we're done
    if (dwmrc <> S_OK)
        return &RECTPlus

    ;-- Collect dimensions via GetWindowRect
    VarSetCapacity(RECT, 16, 0)

    DllCall("GetWindowRect", ptr_type id, ptr_type &RECT)

    GWR_Width := NumGet(RECT, 8, "Int") - NumGet(RECT, 0, "Int")    ;-- Right minus Left
    GWR_Height := NumGet(RECT, 12, "Int") - NumGet(RECT, 4, "Int")  ;-- Bottom minus Top

    ;-- Calculate offsets and update output variables
    NumPut(value["offSet_x"] := (value["width"]  - GWR_Width)  // 2, RECTPlus 16, "Int")
    NumPut(value["offSet_y"] := (value["height"] - GWR_Height) // 2, RECTPlus 20, "Int")

    return value
}
