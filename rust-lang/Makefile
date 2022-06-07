include $(TOPDIR)/rules.mk

PKG_NAME := rust-lang
PKG_LICENSE := Apache-2.0/MIT
PKG_VERSION := 1.60.0
PKG_RELEASE := 1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/rust-lang/rustup.git
PKG_SOURCE_VERSION:=1.24.3
PKG_MIRROR_HASH:=ba8ebb610aaf76127a475ae899dee44e57e81341965f37b3c534196c933fc2df

include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/package.mk
include ./files/rust-env.mk

Build/Compile:=:

define Host/Compile
	sh $(HOST_BUILD_DIR)/rustup-init.sh -y \
		--default-toolchain $(PKG_VERSION) \
		--target $(RUST_TARGET) \
		--profile minimal \
		--no-modify-path
endef

define Host/Install
	ln -s $(CARGO_BIN)/cargo $(STAGING_DIR_HOST)/bin/
	ln -s $(CARGO_BIN)/rustc $(STAGING_DIR_HOST)/bin/
	ln -s $(CARGO_BIN)/rustup $(STAGING_DIR_HOST)/bin/
endef

define Host/Clean
	$(call Host/Clean/Default)
	-rm $(STAGING_DIR_HOST)/bin/cargo
	-rm $(STAGING_DIR_HOST)/bin/rustc
	-rm $(STAGING_DIR_HOST)/bin/rustup
	-rm -rf $(RUSTUP_HOME) $(CARGO_HOME)
endef

$(eval $(call HostBuild))
$(eval $(call Build/DefaultTargets))
