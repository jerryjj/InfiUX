DESCRIPTION = "InfiUX"
LICENSE = "GPL"
PR = "r0"

#SRC_URI = "file://${PN}-${PV}.tar.bz2 \
#           file://${MACHINE}/infiux.ini.default \
#"

S = "${WORKDIR}/InfiUX"

DEPENDS = "qt4-embedded"

inherit qt4e

do_configure() {
    qmake2_do_configure
}

do_compile() {
    oe_runmake
}

do_install() {
    install -d ${D}${bindir} ${D}${sysconfdir}/infiux
    install -m 0755 InfiUX ${D}${bindir}/InfiUX
    install -m 0644 ${WORKDIR}/${MACHINE}/infiux.ini.default ${D}${sysconfdir}/infiux/infiux.ini    
}

ALLOW_EMPTY = ""
RREPLACES_${PN} = "InfiUX"
RPROVIDES_${PN} = "InfiUX"

PACKAGES += "\
	${PN} \
"

FILES_${PN}  =  "\
${sysconfdir} \
${bindir}/InfiUX \
"
