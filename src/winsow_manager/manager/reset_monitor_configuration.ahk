#Include %A_ScriptDir%/screen/get.ahk

manager_reset_screen_configuration(ByRef manager) {
    screens := manager_screens(manager)

    n := array_count(screens)

    SysGet, screen_count, MonitorCount

    if (screen_count < n) {
        ; A screen has been disconnected. Which one?
        i := screen_find(screens)

        if (i > 0) {
            SysGet, mPrimary, MonitorPrimary

            GuiN := (m - 1) + 1

            Gui, %GuiN%: Destroy

            loop % Config_viewCount {
                if desktop_#%i%_#%A_Index%_wndIds {
                    desktop_#%mPrimary%_#%A_Index%_wndIds .= desktop_#%i%_#%A_Index%_wndIds

                    StringTrimRight, wndIds, desktop_#%i%_#%A_Index%_wndIds, 1

                    loop PARSE, wndIds, `;
                    {
                        window_#%A_LoopField%_screen := mPrimary
                    }

                    if (manager["active_screen"] = i)
                        manager["active_screen"] := mPrimary
                }
            }

            loop % m - i {
                j := i + A_Index
                screen_moveToIndex(j, j - 1)

                screen_getWorkArea(j - 1)

                status_bar_init(j - 1)
            }
        }
    }
    else if (screen_count > n) {
        ; A screen has been connected. Where has it been put?
        i := screen_find(screens)

        if (i > 0) {
            loop % screen_count - i {
                j := manager_screenCount - A_Index

                screen_moveToIndex(j, j + 1)

                screen_getWorkArea(j + 1)

                status_bar_init(j + 1)
            }

            screen_init(i, true)
        }
    }
    else {
        ; Has the resolution of a screen been changed?
        loop % screen_count {
            screen_work_area(A_Index)

            status_bar_init(A_Index)
        }
    }

    loop % screen_count {
        desktop_arrange(A_Index, screen_#%A_Index%_adesktop_#1)
    }

    status_bar_update(status_bar)

    Gui, +LastFound

    hWnd := WinExist()

    WinGetClass, window_class, ahk_id %hWnd%
    WinGetTitle, window_title, ahk_id %hWnd%

    ; Minimum operating systems: Windows 2000 (http://msdn.microsoft.com/en-us/library/ms644989(VS.85).aspx)
    DllCall("RegisterShellHookWindow", "UInt", hWnd)
}
