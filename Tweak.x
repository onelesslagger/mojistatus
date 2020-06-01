#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>


@interface _UIStatusBarForegroundView : UIView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
-(void)setHidden:(BOOL)changeHidden;
-(BOOL)isHidden;
@end


HBPreferences *preferences;
BOOL isEnabled;
BOOL hideStatusBar;
NSInteger tweakView;
NSString *customText;
NSString *finaltext;


// not working at the moment
%hook SBDeviceApplicationSceneStatusBarBreadcrumbProvider

	+(BOOL)_shouldAddBreadcrumbToActivatingSceneEntity:(id)arg1 sceneHandle:(id)arg2 withTransitionContext:(id)arg3 {
		if(tweakView > 1 && isEnabled) {
			return NO;
		}
		return %orig;
}

%end

%hook _UIStatusBarStringView
- (void)setText:(NSString *)text {


if(isEnabled)
{
		finaltext = [NSString stringWithFormat:@"%@" , customText];

		NSDate * now = [NSDate date];
		NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
		[outputFormatter setDateFormat:@"h:mm"];
		NSString *newDateString = [outputFormatter stringFromDate:now];

		NSString *str = [NSString stringWithFormat: @"%@ %@", customText, newDateString];

		// tweakView returns 3 values:
		//	Custom Text + Stock : 1
		//	Custom Text + Time : 2
		//	Custom Text Only : 3
		
switch (tweakView){
	case 1 :
		text = [NSString stringWithFormat:@"%@ %@", finaltext, text];
		break;

	case 2 : 
		text = str;
		break;

	case 3 :
		text = finaltext;
		break;

	default:
		text = [NSString stringWithFormat:@"%@ %@", finaltext, text];


	}

}
%orig;
	
}

%end


// Extra Goodies

// 1. Hide status bar
%hook _UIStatusBarForegroundView

	%property (nonatomic, assign) BOOL hidden;

	- (void)setHidden:(BOOL)changeHidden {
		if(isEnabled) {
			if(hideStatusBar) {
				changeHidden = TRUE;
			}
		}
		%orig;
	}

	//status bar hidden on the view when created.
	- (void)setNeedsLayout {
		if(isEnabled) {
			if(hideStatusBar) {
				self.hidden = TRUE;
			}
		}
		%orig;
	}

%end


%ctor
{
	@autoreleasepool
{
	preferences = [[HBPreferences alloc] initWithIdentifier:@"com.onelesslagger.mojistatuspref"];
		[preferences registerBool:&isEnabled default:YES forKey:@"isEnabled"];
		[preferences registerBool:&hideStatusBar default:NO forKey:@"hideStatusBar"];
		[preferences registerObject:&customText default:@"" forKey:@"customTextValue"];

		[preferences registerInteger:&tweakView default:1 forKey:@"tweakView"];


}

}
