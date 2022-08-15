include $(TOPDIR)/rules.mk

PKG_NAME:=rustup
PKG_VERSION:=1.25.1
PKG_RELEASE:=1

PKG_SOURCE:=rustup-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/rust-lang/rustup/tar.gz/$(PKG_VERSION)?
PKG_HASH:=4d062c77b08309bd212f22dd7da1957c1882509c478e57762f34ec4fb2884c9a
HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/rustup-$(PKG_VERSION)

PKG_LICENSE:=Apache-2.0 MIT
PKG_LICENSE_FILES:=LICENSE-MIT LICENSE-APACHE

PKG_HOST_ONLY:=1
HOST_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
include ./files/rustup-env.mk

Build/Compile:=:

define Package/rustup
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=rustup - The Rust toolchain installer
  URL:=https://rustup.rs/
  BUILDONLY:=1
endef

define Host/Compile
	sh $(HOST_BUILD_DIR)/rustup-init.sh -y \
		--default-toolchain none \
		--no-modify-path
endef

define Host/Install
	ln -s $(CARGO_BIN)/rustup $(STAGING_DIR_HOST)/bin/
	ln -s $(CARGO_BIN)/cargo $(STAGING_DIR_HOST)/bin/
	ln -s $(CARGO_BIN)/rustc $(STAGING_DIR_HOST)/bin/
endef

define Host/Clean
	$(call Host/Clean/Default)
	-rm $(STAGING_DIR_HOST)/bin/rustup
	-rm $(STAGING_DIR_HOST)/bin/cargo
	-rm $(STAGING_DIR_HOST)/bin/rustc
	-rm -rf $(RUSTUP_HOME) $(CARGO_HOME)
endef

$(eval $(call BuildPackage,rustup))
$(eval $(call HostBuild))
