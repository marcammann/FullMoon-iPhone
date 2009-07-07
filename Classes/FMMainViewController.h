//
//  FMMainViewController.h
//  FullMoon
//
//  Created by Marc Ammann on 7/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMMainView.h"
#import "FMFullMoon.h"

@interface FMMainViewController : UIViewController <FMFullMoonDelegate> {
	// The Main View, displaying info
	FMMainView *mainView;
	
	// The Full Moon model, receiving the stuff
	FMFullMoon *fullMoon;
	
	UIButton *infoButton;
}

- (void)showSettings:(id)sender;
- (void)settingsViewControllerDidFinish:(id)controller;

@end
