//
//  FMSettings.m
//  FullMoon
//
//  Created by Marc Ammann on 7/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FMSettings.h"
#import "FullMoonAppDelegate.h"

@implementation FMSettings

@synthesize minutesBeforePush;
@synthesize pushEnabled;

- (id)init {
	if (self = [super init]) {
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		
		NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:@"YES", @"pushEnabled",
									 [NSNumber numberWithInt:1440], @"minutesBeforePush",
									 @"NO", @"registredAPNS",
									 @"NO", @"registredProvider",
									 nil];
	
		[defaults registerDefaults:appDefaults];
		
		
		registredAPNS = [defaults boolForKey:@"registredAPNS"];
		registredProvider = [defaults boolForKey:@"registredProvider"];
		pushEnabled = [defaults boolForKey:@"pushEnabled"];
		minutesBeforePush = [defaults integerForKey:@"minutesBeforePush"];
	}
	
	return self;
}

- (void)registerAPNSForRemoteNotification {
	if (pushEnabled) {
		[[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert];
	} else {
		[[UIApplication sharedApplication] unregisterForRemoteNotifications];
	}
	
	[(FullMoonAppDelegate*)[[UIApplication sharedApplication] delegate] setSettings:self];
	
}

- (void)registrationSucceeded:(BOOL)succ {
	[self setRegistredAPNS:succ];
}

- (void)setRegistredAPNS:(BOOL)registred {
	registredAPNS = registred;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:registredAPNS forKey:@"registredAPNS"];
	[defaults synchronize];
}

- (void)setPushEnabled:(BOOL)enabled {
	pushEnabled = enabled;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:enabled forKey:@"pushEnabled"];
	
	[self registerAPNSForRemoteNotification];
	
	[defaults synchronize];
}

- (void)setMinutesBeforePush:(NSInteger)minutes {
	NSLog(@"%i", minutes);
	minutesBeforePush = minutes;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setInteger:minutes forKey:@"minutesBeforePush"];
	[defaults synchronize];
}

@end
