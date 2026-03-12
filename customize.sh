ASH_STANDALONE=1
SERVICE=frpc
ui_print "$SERVICE for KernelSU."

if [ $IS64BIT == true ]; then
    ui_print "This device is arm64."
else
    ui_print "This device isn't arm64."
    abort "Failed."
fi

ui_print "Setting permissions..."
set_perm ${MODPATH}/bin/frpc 0 0 0755
set_perm ${MODPATH}/service.sh 0 0 0755
set_perm ${MODPATH}/action.sh 0 0 0755

CONFDIR=/data/local/$SERVICE.conf

test -d $CONFDIR || cp -rf $MODPATH/$SERVICE.conf $CONFDIR

ui_print "Success."
