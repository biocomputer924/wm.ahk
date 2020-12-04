system_make_directory(path) {
    IfNotExist, % path
    {
        FileCreateDir, % path

        if ErrorLevel {
            MsgBox, % "Error (" . ErrorLevel . ") when creating '" . path . "'. Aborting."
            ExitApp
        }
    }
    else {
        FileGetAttrib, attrib, %path%

        IfNotInString, attrib, D
        {
            MsgBox, % "The file path '" . path . " already exists and is not a directory. Aborting."
            ExitApp
        }
    }
}
