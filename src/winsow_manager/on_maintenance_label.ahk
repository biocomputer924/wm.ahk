; Asynchronous management of various WM properties.
; We want to make sure that we can recover the layout and windows in the event of
; unexpected problems.
; Periodically check for changes to these things and save them somewhere (not over
; user-defined files).
on_maintenance_manager_label:
    Critical

    ; @TODO: manager_sync?
return
