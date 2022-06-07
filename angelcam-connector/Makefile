include $(TOPDIR)/rules.mk

PKG_NAME := angelcam-connector
PKG_LICENSE := Apache-2.0
PKG_VERSION := 0.10.1
PKG_RELEASE := 1

PKG_BUILD_DEPENDS := rust-lang/host

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/angelcam/arrow-client.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_MIRROR_HASH:=8651cb53d51642cac468948a0d40d2b04cec28e9ff046df254641b5a46cc8d87

include $(INCLUDE_DIR)/package.mk
include ../rust-lang/files/rust-env.mk

define Package/angelcam-connector
  TITLE := Angelcam Connector
  CATEGORY := Network
  SECTION := net
  DEPENDS := +libpcap +libopenssl
  URL := https://github.com/angelcam/arrow-client
  MAINTAINER := dev@angelcam.com
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
	$(INSTALL_DIR) $(1)/etc/angelcam-connector
	$(INSTALL_DIR) $(1)/usr/local/angelcam-connector
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/target/$(RUST_TARGET)/release/arrow-client \
		$(1)/usr/bin/angelcam-connector
	$(INSTALL_BIN) ./files/init-script $(1)/etc/init.d/angelcam-connector
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/ca.pem $(1)/usr/local/angelcam-connector/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/rtsp-paths $(1)/etc/angelcam-connector/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/mjpeg-paths $(1)/etc/angelcam-connector/
	touch $(1)/etc/angelcam-connector/config.json
	touch $(1)/etc/angelcam-connector/config-skel.json
	chmod 600 $(1)/etc/angelcam-connector/config.json
	chmod 600 $(1)/etc/angelcam-connector/config-skel.json
endef

$(eval $(call BuildPackage,angelcam-connector))
