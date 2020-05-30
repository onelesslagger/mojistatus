#import <UIKit/UIKit.h>
%hook _UIStatusBarStringView
-(void)setText:(id)arg1{

	 NSDictionary *bundleDefaults = [[NSUserDefaults standardUserDefaults]persistentDomainForName:@"com.onelesslagger.mojistatuspref"];

		id isEnabled = [bundleDefaults valueForKey:@"isEnabled"];
		id customText = [bundleDefaults valueForKey:@"customTextValue"];
		id includeTime = [bundleDefaults valueForKey:@"includeTime"];
		NSString *text = [NSString stringWithFormat:@"%@" , customText];

	NSDate * now = [NSDate date];
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateFormat:@"h:mm"];
	NSString *newDateString = [outputFormatter stringFromDate:now];

if([isEnabled isEqual:@0])
	{
		%orig;
	}
	else
	{
		if([includeTime isEqual:@0])
		{
			%orig(customText);
		}
		else
		{
			NSString *str = [NSString stringWithFormat: @"%@ %@", text, newDateString];
			%orig(str);
		}
		
	}
	
}

%end

