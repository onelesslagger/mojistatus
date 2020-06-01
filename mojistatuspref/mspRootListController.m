#include "mspRootListController.h"

@implementation mspRootListController


// Initialize Preferences with Cephei
- (void)viewDidLoad {
	[super viewDidLoad];

	HBAppearanceSettings *appearance = [[HBAppearanceSettings alloc] init];
	// appearance.tintColor = [UIColor colorWithRed:.450 green:.670 blue:.890 alpha:1];
	self.hb_appearanceSettings = appearance;
	self.title = @"MojiStatus 🤬";
}

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

- (void)respringMethod {
	[self.view endEditing:YES];
	[HBRespringController respringAndReturnTo:[NSURL URLWithString:@"prefs:root=MojiStatus"]];
}

@end
