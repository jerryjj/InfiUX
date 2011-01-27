require infiux.inc

SRCREV = "33b867cd9ffa44366087043386c9da9eb341e074"
PV = "0.0.1-${PR}+gitr${SRCPV}"
PR = "r0"

SRC_URI = "git://github.com/jerryjj/InfiUX.git;protocol=git \
           file://disable_opengl.patch \
           file://${MACHINE}/infiux.ini.default \
"

S = "${WORKDIR}/git/ux"
