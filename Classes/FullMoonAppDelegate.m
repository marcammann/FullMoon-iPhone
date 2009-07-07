//
//  FullMoonAppDelegate.m
//  FullMoon
//
//  Created by Marc Ammann on 7/7/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "FullMoonAppDelegate.h"

@implementation FullMoonAppDelegate

@synthesize window;
@synthesize settings;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	[application setStatusBarStyle:UIStatusBarStyleBlackOpaque];
	mainViewController = [[FMMainViewController alloc] init];
	[window addSubview:mainViewController.view];
	
	window.backgroundColor = [UIColor viewFlipsideBackgroundColor];
	
    // Override point for customization after application launch
    [window makeKeyAndVisible];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
	if (settings) {
		[settings registrationSucceeded:YES];
	}
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
	if (settings) {
		NSLog(@"%@", error);
		[settings registrationSucceeded:NO];
	}	
}

- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
