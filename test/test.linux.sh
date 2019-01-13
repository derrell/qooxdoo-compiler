set -x 
rm -rf myapp
# test create app
qx create myapp -I --type server -v || exit $?
cd myapp
qx compile -v --clean || exit $?
node source-output/myapp/myapp.js || exit $?
# test add contrib
qx contrib update  -v|| exit $?
qx contrib list    -v|| exit $?
qx contrib install oetiker/UploadWidget -v || exit $?
qx contrib install cboulanger/qx-contrib-Dialog -v || exit $?
qx contrib install johnspackman/UploadMgr -v || exit $?
qx contrib install ergobyte/qookery/qookeryace -v || exit $?
qx contrib install ergobyte/qookery/qookerymaps -v || exit $?
qx compile -v --clean || exit $?
node source-output/myapp/myapp.js || exit $?
# test reinstall contrib
qx clean || exit $?
qx contrib install -v || exit $?
qx compile -v --clean || exit $?
node source-output/myapp/myapp.js
#test remove contrib
call qx contrib remove oetiker/UploadWidget -v || EXIT /B 1
call qx contrib remove ergobyte/qookery/qookeryace -v || EXIT /B 1
call qx contrib remove ergobyte/qookery/qookerymaps -v || EXIT /B 1
call qx compile -v --clean || EXIT /B 1
call node source-output\myapp\myapp.js || EXIT /B 1
# test install without manifest
call qx contrib install ergobyte/qookery -v || EXIT /B 1
call qx compile -v --clean || EXIT /B 1
call node source-output\myapp\myapp.js || EXIT /B 1
# test add class and add script
qx add class myapp.Window --extend=qx.ui.window.Window || exit $?
qx add script ../testdata/npm/script/jszip.js --rename=zip.js || exit $?
cp ../testdata/npm/application/*.js source/class/myapp
qx lint --fix --warnAsError ||  exit $?
qx compile -v --clean || exit $?
node source-output/myapp/myapp.js || exit $?
