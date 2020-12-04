tiler_getMFactorD(m, v, d, dFact) {
    static lastCall := 0

    callD := A_TickCount - lastCall

    lastCall := A_TickCount

    ; The minimum d, which is reached in 5 steps. maxD is d.
    if (dFact < 1)
        minD := d * dFact**5
    else
        minD := d / dFact**5

    mFactD := 0

    if (callD < Config_mFactCallInterval and d * mFactD > 0) {
        ; Accelerate mFactD, if the last call is inside the time frame and went in the same direction.
        mFactD *= dFact

        ; Reset mFactD, if it is out of bounds (d).
        if (dFact < 1 and Abs(mFactD) < Abs(minD))
            mFactD := minD
        else if (Abs(mFactD) > Abs(d))
            mFactD := d
    }
    else {
        ; Reset after a timeout or a change of direction.
        if (dFact > 1)
            mFactD := minD
        else
            mFactD := d
    }

    return mFactD
}