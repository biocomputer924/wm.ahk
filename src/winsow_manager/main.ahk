OnExit, on_cleanup_label

SetBatchLines, -1
SetTitleMatchMode, 3
SetTitleMatchMode, fast
SetWinDelay, 10

#NoEnv
#SingleInstance force
; Enable warnings to assist with detecting common errors.
; #Warn
#WinActivateforce

; Pseudo main function
    application_name := "wm.ahk"

    EnvGet, appdata, APPDATA

    config_path := appdata . "\" . application_name . "\config.ini"

    config := config_load(config_path)

    manager := {}
    manager["on_maintenance_label"] := "on_maintenance_label"
    manager["on_shell_message"] := "on_shell_message"
    manager["on_status_bar_render_label"] := "on_status_bar_render_label"

    tray_icon := {}
    tray_icon["name"] := application_name
    tray_icon["on_quit_label"] := "on_quit_label"

    context := {}
    context["config"] := config
    context["config_path"] := config_path
    context["manager"] := manager

    manager_init(manager)

    tray_icon_render(tray_icon)

    for i in config["hotkeys"] {
        Hotkey, % config["hotkeys"][i]["pattern"], % manager["on_hotkey_label"]
    }

    Sleep, 20000
return

#Include %A_ScriptDir%/config/load.ahk
#Include %A_ScriptDir%/on_cleanup_label.ahk
#Include %A_ScriptDir%/on_hotkey_label.ahk
#Include %A_ScriptDir%/on_maintenance_label.ahk
#Include %A_ScriptDir%/on_quit_label.ahk
#Include %A_ScriptDir%/on_shell_message.ahk
#Include %A_ScriptDir%/on_status_bar_render_label.ahk
#Include %A_ScriptDir%/system/make_directory.ahk
#Include %A_ScriptDir%/tray_icon/render.ahk
