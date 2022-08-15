include $(TOPDIR)/rules.mk

PKG_NAME:=angelcam-connector
PKG_VERSION:=0.10.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/angelcam/arrow-client/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=31d6be013efa4bbdfb59254f2d65469cdf10a4710955d5beab133d7a3e90d07d
PKG_BUILD_DIR:=$(BUILD_DIR)/arrow-client-$(PKG_VERSION)

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Angelcam Developers <dev@angelcam.com>

PKG_BUILD_DEPENDS:=rust-lang/host

include $(INCLUDE_DIR)/package.mk
include ../rust-lang/files/rust-env.mk

define Package/angelcam-connector
  TITLE:=Angelcam Connector
  CATEGORY:=Network
  SECTION:=net
  DEPENDS:=+libpcap +libopenssl
  URL:=https://github.com/angelcam/arrow-client
endef

define Package/angelcam-connector/description
  Angelcam Connector is a simple service that allows you to connect your IP
  cameras to Angelcam Cloud easily even if you are behind a NAT. There is no
  need for port-forwarding or a public IP address.

  The application opens a secure connection to Angelcam Cloud and it works as
  a proxy for your IP cameras. It periodically scans your local network in
  order to keep track of your IP cameras.
endef

define Build/Prepare
	$(call Build/Prepare/Default)
	$(call Build/Prepare/Rust)
endef

define Build/Compile
	(\
		cd $(PKG_BUILD_DIR) && \
		export OPENSSL_LIB_DIR=$(STAGING_DIR)/usr/lib && \
		export OPENSSL_INCLUDE_DIR=$(STAGING_DIR)/usr/include && \
		cargo build \
			--features "discovery threads" \
			--release \
			--target $(RUST_TARGET) \
	)
endef

define Package/angelcam-connector/postinst
#!/bin/sh
/etc/init.d/angelcam-connector enable
/etc/init.d/angelcam-connector start
endef

define Package/angelcam-connector/prerm
#!/bin/sh
/etc/init.d/angelcam-connector stop
/etc/init.d/angelcam-connector disable
endef

define Package/angelcam-connector/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/target/$(RUST_TARGET)/release/arrow-client \
	$(1)/usr/bin/angelcam-connector

	$(INSTALL_DIR) $(1)/etc/angelcam-connector
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/rtsp-paths $(1)/etc/angelcam-connector/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/mjpeg-paths $(1)/etc/angelcam-connector/
	touch $(1)/etc/angelcam-connector/config.json
	touch $(1)/etc/angelcam-connector/config-skel.json
	chmod 600 $(1)/etc/angelcam-connector/config.json
	chmod 600 $(1)/etc/angelcam-connector/config-skel.json

	$(INSTALL_DIR) $(1)/usr/local/angelcam-connector
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/ca.pem $(1)/usr/local/angelcam-connector/

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/init-script $(1)/etc/init.d/angelcam-connector
endef

$(eval $(call BuildPackage,angelcam-connector))
