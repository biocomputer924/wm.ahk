window_is_elevated(id) {
    WinGetTitle, title, ahk_id %id%

    WinSetTitle, ahk_id %id%, , % title . " "

    WinGetTitle, new_title, ahk_id %id%

    WinSetTitle, ahk_id %id%, , % title

    return (new_title = title)
}
