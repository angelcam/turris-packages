export RUSTUP_HOME:=$(STAGING_DIR_HOST)/lib/rustup
export CARGO_HOME:=$(STAGING_DIR_HOST)/lib/cargo

CARGO_BIN:=$(CARGO_HOME)/bin

# NOTE: The Rust target triplet does not always match the target triplet used
# by OpenWrt. You can add exceptions for your target profile here:
ifeq ($(CONFIG_TARGET_PROFILE),"DEVICE_cznic_turris-omnia")
  RUST_TARGET := armv7-unknown-linux-musleabihf
else
  RUST_TARGET := $(shell echo $(CONFIG_ARCH)-unknown-linux-$(CONFIG_TARGET_SUFFIX))
endif

define CARGO_CONFIG
[target.$(RUST_TARGET)]
ar = "$(TARGET_AR)"
linker = "$(TARGET_CC)"
rustflags = [
  "-C", "link-args=$(TARGET_LDFLAGS)",
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
