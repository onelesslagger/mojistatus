include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = mojistatuspref

mojistatuspref_FILES = mspRootListController.m
mojistatuspref_INSTALL_PATH = /Library/PreferenceBundles
mojistatuspref_FRAMEWORKS = UIKit
mojistatuspref_PRIVATE_FRAMEWORKS = Preferences
mojistatuspref_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/mojistatuspref.plist$(ECHO_END)
