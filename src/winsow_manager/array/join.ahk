array_join(f, x)
{
    value := ""

    for i in f
        value .= f[i] . x

    return SubStr(value, 1, - StrLen(x))
}
