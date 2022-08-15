include $(TOPDIR)/rules.mk

PKG_NAME:=rust-lang
PKG_VERSION:=1.63.0
PKG_RELEASE:=1

PKG_LICENSE:=Apache-2.0 MIT
PKG_LICENSE_FILES:=LICENSE-MIT LICENSE-APACHE

PKG_HOST_ONLY:=1
HOST_BUILD_PARALLEL:=1

HOST_BUILD_DEPENDS:=rustup/host

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
include ./files/rust-env.mk

define Package/rust-lang
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Rust programming language
  URL:=https://www.rust-lang.org/
  BUILDONLY:=1
endef

Build/Compile:=:
Host/Compile:=:

define Host/Install
	rustup toolchain install \
		--target $(RUST_TARGET) \
		--profile minimal \
		$(PKG_VERSION)
endef

define Host/Clean
	$(call Host/Clean/Default)
	rustup toolchain uninstall $(PKG_VERSION)
endef

$(eval $(call BuildPackage,rust-lang))
$(eval $(call HostBuild))
