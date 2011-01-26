require InfiUX.inc
PR = "r0"

SRC_URI = "git://github.com/jerryjj/InfiUX.git;protocol=git \
           file://${MACHINE}/infiux.ini.default \
"
S = "${WORKDIR}/ux"