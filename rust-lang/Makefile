include $(TOPDIR)/rules.mk

PKG_NAME:=rust-lang
PKG_VERSION:=1.63.0
PKG_RELEASE:=1

PKG_SOURCE:=rustc-$(PKG_VERSION)-src.tar.gz
PKG_SOURCE_URL:=https://static.rust-lang.org/dist/
PKG_HASH:=1f9580295642ef5da7e475a8da2397d65153d3f2cb92849dbd08ed0effca99d0
HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/rustc-$(PKG_VERSION)-src

PKG_LICENSE:=Apache-2.0 MIT
PKG_LICENSE_FILES:=LICENSE-MIT LICENSE-APACHE

PKG_HOST_ONLY:=1
HOST_BUILD_PARALLEL:=1

HOST_BUILD_DEPENDS:=\
	ninja/host \
	python3/host

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
include ./files/rust-env.mk

Build/Compile:=:

define Package/rust-lang
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Rust programming language
  URL:=https://www.rust-lang.org/
  BUILDONLY:=1
endef

define BUILD_CONFIG_TOML
changelog-seen = 2

[llvm]
targets = "AArch64;ARM;Mips;PowerPC;RISCV;WebAssembly;X86"

[rust]
channel = "stable"

[build]
target = [
	"$(subst pc,unknown,$(GNU_HOST_NAME))",
	"$(RUST_TARGET)",
]
docs = false
extended = true
tools = ["cargo", "src"]

[target.$(RUST_TARGET)]
musl-root = "$(TOOLCHAIN_DIR)"

[install]
prefix = "$(STAGING_DIR_HOST)"
sysconfdir = "etc"
endef

export BUILD_CONFIG_TOML

define Host/Configure
	echo "$$$$BUILD_CONFIG_TOML" > $(HOST_BUILD_DIR)/config.toml
endef

define Host/Compile
	cd $(HOST_BUILD_DIR) && ./x.py build
endef

define Host/Install
	cd $(HOST_BUILD_DIR) && ./x.py install
endef

define Host/Clean
	(\
		if [ -f $(STAGING_DIR_HOST)/lib/rustlib/uninstall.sh ]; then \
			$(STAGING_DIR_HOST)/lib/rustlib/uninstall.sh; \
		fi \
	)
	$(call Host/Clean/Default)
endef

$(eval $(call BuildPackage,rust-lang))
$(eval $(call HostBuild))
