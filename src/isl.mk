# This file is part of MXE.
# See index.html for further information.

PKG             := isl
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.14
$(PKG)_CHECKSUM := b09e25df265c97ed54002cd811d227a9a26c5f9c
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := http://isl.gforge.inria.fr/$($(PKG)_FILE)
$(PKG)_URL_2    := ftp://gcc.gnu.org/pub/gcc/infrastructure/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc gmp

# stick to tested versions from gcc
define $(PKG)_UPDATE
    $(WGET) -q -O- 'ftp://gcc.gnu.org/pub/gcc/infrastructure/' | \
    $(SED) -n 's,.*isl-\([0-9][^>]*\)\.tar.*,\1,p' | \
    $(SORT) -V |
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        --host='$(TARGET)' \
        --enable-static \
        --disable-shared \
        --prefix='$(PREFIX)/$(TARGET)' \
        --with-gmp-prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j '$(JOBS)' install
endef

$(PKG)_BUILD_SHARED =
