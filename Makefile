ARCHS=armv7 arm64

include theos/makefiles/common.mk

TWEAK_NAME = BBMCallConfirm
BBMCallConfirm_FILES = Tweak.xm
BBMCallConfirm_FRAMEWORKS = UIKit
TARGET_SDKVERSION = 7.0

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 BBM;"
