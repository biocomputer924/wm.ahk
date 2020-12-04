desktop_ghost_window(ByRef desktop, bodyWndId, ghostWndId) {
    search := bodyWndId ";"

    replace := search ghostWndId ";"

    StringReplace, desktop["window_ids"], desktop["window_ids"], % search, % replace
}
