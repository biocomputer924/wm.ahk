screen_set_work_area(rect) {
    VarSetCapacity(area, 16)

    NumPut(rect["x"], area, 0)
    NumPut(rect["y"], area, 4)
    NumPut(rect["x"] + rect["width"], area, 8)
    NumPut(rect["y"] + rect["height"], area, 12)

    ; 0x2F = SPI_SETWORKAREA
    DllCall("SystemParametersInfo", UInt 0x2F, UInt 0, UInt &area, UInt 0)
}
