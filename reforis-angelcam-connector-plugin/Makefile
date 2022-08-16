include $(TOPDIR)/rules.mk

PKG_NAME:=reforis-angelcam-connector-plugin
PKG_VERSION:=0.1.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/angelcam/reforis-angelcam-connector-plugin/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=c047c81b1150185bc305c19b00a1fa976f0db3b4b8f66f11d376419b12a70aac

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

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

$(eval $(call ReForisPlugin,reforis-angelcam-connector-plugin,reforis_angelcam_connector))
# call BuildPackage <= assures OWR build system that this is package
