# This file is part of MXE.
# See index.html for further information.

PKG             := tiff
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.0.4
$(PKG)_CHECKSUM := 185f844babe4ee902b5e4775d9f65915fcbabd11
$(PKG)_SUBDIR   := tiff-$($(PKG)_VERSION)
$(PKG)_FILE     := tiff-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := http://download.osgeo.org/libtiff/$($(PKG)_FILE)
$(PKG)_URL_2    := ftp://ftp.remotesensing.org/libtiff/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc zlib jpeg xz

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://www.remotesensing.org/libtiff/' | \
    $(SED) -n 's,.*>v\([0-9][^<]*\)<.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --without-x
    $(MAKE) -C '$(1)' -j '$(JOBS)' install $(MXE_DISABLE_CRUFT)
endef
