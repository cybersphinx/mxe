# This file is part of MXE.
# See index.html for further information.

PKG             := eb
$(PKG)_IGNORE   :=
$(PKG)_CHECKSUM := 1cc55c90fcac224bf299289e7a0fe1559f0761ab
$(PKG)_SUBDIR   := eb-$($(PKG)_VERSION)
$(PKG)_FILE     := eb-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := ftp://ftp.sra.co.jp/pub/misc/eb/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc zlib

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        --host='$(TARGET)' \
        --enable-static \
        --disable-shared \
        --disable-ebnet \
        --cache-file=win32.cache \
        --prefix='$(PREFIX)/$(TARGET)' && echo "#define DOS_FILE_PATH" >> config.h
    $(MAKE) -C '$(1)'/eb -j '$(JOBS)' install
endef
