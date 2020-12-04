#Include %A_ScriptDir%/manager/sync.ahk
#Include %A_ScriptDir%/screen/get.ahk
#Include %A_ScriptDir%/window/get_hidden.ahk

/*
  Possible indications for a ...
    new window: 1 (started by Windows Explorer) or 6 (started by cmd, shell or Win+E).
      There doesn't seem to be a reliable way to get all application starts.
    closed window: 2 (always?) or 13 (ghost)
    focus change: 4 or 32772
    title change: 6 or 32774
*/
on_shell_message(wParam, lParam) {
    ; HSHELL_* become global.

    ; MESSAGE NAME AND         ... NUMBER    COMMENTS, POSSIBLE EVENTS
    HSHELL_WINDOWCREATED        :=  1         ; window shown
    HSHELL_WINDOWDESTROYED      :=  2         ; window hidden, destroyed or deactivated
    HSHELL_ACTIVATESHELLWINDOW  :=  3
    HSHELL_WINDOWACTIVATED      :=  4         ; window title changed, window activated (by mouse, Alt+Tab or hotkey); alternative message: 32772
    HSHELL_GETMINRECT           :=  5
    HSHELL_REDRAW               :=  6         ; window title changed
    HSHELL_TASKMAN              :=  7
    HSHELL_LANGUAGE             :=  8
    HSHELL_SYSMENU              :=  9
    HSHELL_ENDTASK              := 10
    HSHELL_ACCESSIBILITYSTATE   := 11
    HSHELL_APPCOMMAND           := 12
    ; The following two are seen when a hung window recovers.
    HSHELL_WINDOWREPLACED       := 13         ; hung window recovered and replaced the ghost window (lParam indicates the ghost window.)
    HSHELL_WINDOWREPLACING      := 14         ; hung window recovered (lParam indicates the previously hung and now recovered window.)
    HSHELL_HIGHBIT              := 32768      ; 0x8000
    HSHELL_FLASH                := 32774      ; (HSHELL_REDRAW|HSHELL_HIGHBIT); window signalling an application update (The window is flashing due to some event, one message for each flash.)
    HSHELL_RUDEAPPACTIVATED     := 32772      ; (HSHELL_WINDOWACTIVATED|HSHELL_HIGHBIT); full-screen app or root-privileged window activated? alternative message: 4
    ; Any message may be missed, if bug.n is hung or they come in too quickly.

    Setformat, Integer, hex

    lParam := lParam + 0

    Setformat, Integer, d

    config = context["config"]

    manager = context["manager"]

    window_is_hidden := window_get_hidden(lParam)

    if window_is_hidden {
        ; if there is no window class or title, it is assumed that the window is not identifiable.
        ;   The problem was, that i. a. claws-mail triggers manager_sync, but the application window
        ;   would not be ready for being managed, i. e. class and title were not available. Therefore more
        ;   attempts were needed.
        return
    }

    window_is_desktop := (lParam = 0)

    if window_is_desktop {
        WinGetClass, window_class, A
        WinGetTitle, window_title, A
    }

    WinGet, aWndId, ID, A

    WinGetClass, aWndClass, ahk_id %aWndId%

    WinGetTitle, aWndTitle, ahk_id %aWndId%

    if ((wParam = 4 or wParam = 32772) and (aWndClass = "WorkerW" and aWndTitle = "" or lParam = 0 and aWndClass = "Progman" and aWndTitle = "Program Manager")) {
        MouseGetPos, x, y

        m := screen_get(manager_screens(manager), x, y)

        ; The current position of the mouse cursor defines the active screen, if the desktop has been activated.
        if m
            manager["current_screen_id"] := m
    }

    ; This was previously inactive due to `HSHELL_WINDOWREPLACED` not being defined in this function.
    ; Afterwards it caused problems managing new windows, when messages come in too quickly.
    ;  if (wParam = HSHELL_WINDOWREPLACED)
    ;  {    ; This shouldn't need a redraw because the window was supposedly replaced.
    ;    manager_unmanage(lParam)
    ;  }

    ; if (wParam = 14)
    ; {    ; Window recovered from being hung. Maybe force a redraw.
    ; }

    ; @todo: There are two problems with the use of manager_hideShow:
    ;   1) if manager_hideShow is set when we hit this block, we won't take some actions that should eventually be taken.
    ;      This _may_ explain why some windows never get picked up when spamming Win+E
    ;   2) There is a race condition between the time that manager_hideShow is checked and any other action which we are
    ;      trying to protect against. if another process (hotkey) enters a hideShow block after manager_hideShow has
    ;      been checked here, bad things could happen. I've personally observed that windows may be permanently hidden.
    ;   Look into the use of AHK synchronization primitives.
    if (wParam = 1 or wParam = 2 or wParam = 4 or wParam = 6 or wParam = 32772) and lParam and not manager_hideShow {
        Sleep, % config["shell_messasge_delay"]

        window_ids := ""

        a := is_changed := manager_sync(manager, window_ids)

        if window_ids
            is_changed := false

        if is_changed {
            if config["dynamic_tiling"]
                desktop_arrange(manager["active_screen"], manager["screens"][manager["active_screen"]]["active_desktop1"])
        }

        screens := manager_screens(manager)

        if (array_count(screens) > 1 and a > -1) {
            WinGet, window_id, ID, A

            WinGetPos, x, y, width, height, ahk_id %window_id%

            m := screen_get(screens, x + width / 2, y + height / 2)

            ; The currently active window defines the active screen.
            if m
                manager["active_screen"] := m
        }

        if window_ids {
            ; if there are new (unrecognized) windows, which are hidden ...
            ; ... change the view to show the first hidden window
            if (config["onActiveHiddenWnds"] = "view") {
                windowId := SubStr(window_ids, 1, InStr(window_ids, ";") - 1)

                loop % Config_viewCount {
                    if (window_#%windowId%_tags & 1 << A_Index - 1) {
                        ; A newly created window defines the active screen, if it is visible.
                        manager["active_screen"] := window_#%windowId%_screen

                        screen_activateView(A_Index)

                        Break
                    }
                }
            }
            else { ; ... re-hide them
                StringTrimRight, window_ids, window_ids, 1
                StringSplit, windowId, window_ids, `;

                if (Config_onActiveHiddenWnds = "hide") {
                    loop % windowId0 {
                        window_hide(windowId%A_Index%)
                    }
                }
                else if (Config_onActiveHiddenWnds = "tag") {
                    ; ... or tag all of them for the current view.
                    t := manager["screens"][manager["active_screen"]]["active_desktop1"]

                    loop % windowId0 {
                        windowId := windowId%A_Index%

                        desktop_#%manager["active_screen"]%_#%t%_window_ids := windowId ";" desktop_#%manager["active_screen"]%_#%t%_window_ids

                        desktop_set_active_window(manager["active_screen"], t, windowId)

                        window_#%windowId%_tags += 1 << t - 1
                    }

                    if Config_dynamicTiling
                        desktop_arrange(manager["active_screen"], t)
                }
            }
        }

        if array_contains(manager["managed_window_ids"], lParam) {
            WinGet, window_id, ID, A

            WinGetPos, x, y, width, height, ahk_id %lParam%

            if (screen_get(screens, x + width / 2, y + height / 2) = manager["active_screen"])
                desktop_set_active_window(manager["active_screen"], manager["screens"][manager["active_screen"]]["active_desktop1"], lParam)
            else
                manager_activate_window(desktop_current_window(manager["active_screen"], manager["screens"][manager["active_screen"]]["active_desktop1"]))

            if window_#%lParam%_isMinimized {
                window_#%lParam%_isFloating := false
                window_#%lParam%_isMinimized := false

                desktop_arrange(manager["active_screen"], manager["screens"][manager["active_screen"]]["active_desktop1"])
            }
        }
    }
}