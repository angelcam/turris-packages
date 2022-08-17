# NOTE: The Rust target triplet does not always match the target triplet used
# by OpenWrt. You can add exceptions for your device here.

RUST_TARGET_LDFLAGS := $(TARGET_LDFLAGS)

# Turris MOX
ifneq ($(findstring aarch64,$(CONFIG_ARCH)),)
  RUST_TARGET := aarch64-unknown-linux-musl
# Turris Omnia
else ifneq ($(findstring arm,$(CONFIG_ARCH)),)
  RUST_TARGET := armv7-unknown-linux-musleabihf
# Turris 1.x
else ifneq ($(findstring powerpc,$(CONFIG_ARCH)),)
  RUST_TARGET := powerpc-unknown-linux-muslspe
  RUST_TARGET_LDFLAGS += -lssp_nonshared
else
  RUST_TARGET := $(shell echo $(CONFIG_ARCH)-unknown-linux-$(CONFIG_TARGET_SUFFIX))
endif

define CARGO_CONFIG
[target.$(RUST_TARGET)]
ar = "$(TARGET_AR)"
linker = "$(TARGET_CC)"
rustflags = [
  "-C", "link-args=$(RUST_TARGET_LDFLAGS)",
  "-C", "target-feature=-crt-static",
]
endef

export CARGO_CONFIG

define Build/Prepare/Rust
	mkdir $(PKG_BUILD_DIR)/.cargo
	echo "$$$$CARGO_CONFIG" > $(PKG_BUILD_DIR)/.cargo/config
endef

export CC_$(subst -,_,$(RUST_TARGET)):=$(TARGET_CC)
export CFLAGS_$(subst -,_,$(RUST_TARGET)):=$(TARGET_CFLAGS)
