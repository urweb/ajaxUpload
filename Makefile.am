ACLOCAL_AMFLAGS = -I m4

LIB      = @LIB@
INCLUDE  = @INCLUDE@

LIB_UR   = $(LIB)/ur/ajaxUpload
LIB_JS   = $(LIB)/js

SUBDIRS  = src/c

.PHONY: package reauto

install-exec-local:
	mkdir -p $(LIB_UR)
	cp src/ur/*.urs $(LIB_UR)/
	cp src/ur/*.ur $(LIB_UR)/
	cp src/ur/*.urp $(LIB_UR)/
	mkdir -p $(LIB_JS)
	cp src/js/*.js $(LIB_JS)/
	mkdir -p $(INCLUDE)
	cp include/*.h $(INCLUDE)/
	-ldconfig

package:
	hg archive -t tgz /tmp/urweb_ajaxUpload.tgz

reauto:
	-autoreconf
	libtoolize -cf
	automake --add-missing --force-missing --copy
	autoreconf
