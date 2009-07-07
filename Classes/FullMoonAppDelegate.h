//
//  FullMoonAppDelegate.h
//  FullMoon
//
//  Created by Marc Ammann on 7/7/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMMainViewController.h"
#import "FMSettings.h"

@interface FullMoonAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	FMMainViewController *mainViewController;
	
	FMSettings *settings;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, assign) FMSettings *settings;

@end

