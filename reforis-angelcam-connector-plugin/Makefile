include $(TOPDIR)/rules.mk

PKG_NAME:=reforis-angelcam-connector-plugin
PKG_VERSION:=0.1.0
PKG_RELEASE:=1

PKG_LICENSE:=Apache-2.0

PKG_BUILD_DEPENDS:=\
	node/host \
	reforis-distutils/host \

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk
include $(TOPDIR)/feeds/turrispackages/web/reforis/reforis/files/reforis-plugin.mk
include $(TOPDIR)/feeds/turrispackages/web/reforis/reforis/files/reforis-translations.mk

define Package/reforis-angelcam-connector-plugin
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=reForis
  TITLE:=reForis Angelcam Connector plugin
  DEPENDS:= \
    +reforis \
    +angelcam-connector
  VARIANT:=python3
endef

define Package/reforis-angelcam-connector-plugin/description
  reForis Angelcam Connector plugin
endef

REFORIS_TRANSLATIONS:=en

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	cp -a src/* $(PKG_BUILD_DIR)
	$(Build/Patch)
endef

$(eval $(call ReForisPlugin,reforis-angelcam-connector-plugin,reforis_angelcam_connector))
# call BuildPackage <= assures OWR build system that this is package
