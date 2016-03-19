#!/usr/bin/env bash

: ${CTARGET:=$(portageq envvar CHOST)}
: ${BPREFIX:=$(portageq envvar PORTAGE_CONFIGROOT)}
: ${EPREFIX:=$(portageq envvar EPREFIX)}

specs_path=$(dirname $(${CTARGET}-gcc -print-libgcc-file-name))/specs
ROOT=${BPREFIX}usr/${CTARGET}${EPREFIX}/
osd=$(${CTARGET}-gcc -print-multi-os-directory)

std_path(){
        [[ -e $1 ]] || mkdir -p $1
        echo $(realpath $1)
}

dlprefix=$(std_path ${ROOT}lib/${osd})
libprefix=$(std_path ${ROOT}usr/lib/${osd})

${CTARGET}-gcc -dumpspecs | sed -r \
        -e "s,[^:]*(/lib/ld-linux[^.]*\.so(.[:digit:]+)?),${EPREFIX}\1,g" \
        -e "/^\*self_spec:/{n;s,$, -I${ROOT}usr/include -L${libprefix} -L${dlprefix},;}" \
        > ${specs_path}

echo "writing to ${specs_path}
set runtime sysroot to: ${EPREFIX}
compile time sysroot to: ${ROOT}"
