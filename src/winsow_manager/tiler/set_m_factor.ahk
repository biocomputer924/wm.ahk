tiler_setMFactor(m, v, i, d, dFact) {
    if (i > 0)
        mFact := i
    else
        mFact := desktop_#%m%_#%v%_layoutMFact

    if (desktop_#%m%_#%v%_layout_axis_#1 < 0)
        d *= -1

    mFact += tiler_getMFactorD(m, v, d, dFact)

    if (mFact > 0 and mFact < 1) {
        desktop_#%m%_#%v%_layoutMFact := mFact

        return 1
    }
    else
        return 0
}
