INSTALL_TARGET_PROCESSES = SpringBoard
THEOS_DEVICE_IP = 10.195.1.131
THEOS_DEVICE_PORT=22

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MojiStatus

MojiStatus_FILES = Tweak.x
MojiStatus_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += mojistatuspref
include $(THEOS_MAKE_PATH)/aggregate.mk

$(TWEAK_NAME)_FRAMEWORKS = UIKit