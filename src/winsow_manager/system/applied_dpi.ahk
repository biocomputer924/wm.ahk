system_applied_dpi() {
    RegRead, x, % "HKEY_CURRENT_USER", % "Control Panel\Desktop\WindowMetrics, AppliedDPI"

    return x
}
