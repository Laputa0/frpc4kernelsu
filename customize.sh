ui_print "frpc for KernelSU."

if [ $IS64BIT == true ]; then
    echo "This device is arm64."
else
    echo "This device isn't arm64."
    ui_print "Failed."
    exit
fi

ui_print "Setting permissions..."
set_perm ${MODPATH}/bin/frpc 0 0 0755
set_perm ${MODPATH}/service.sh 0 0 0755
set_perm ${MODPATH}/action.sh 0 0 0755

ui_print "Success."
