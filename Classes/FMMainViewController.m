//
//  FMMainViewController.m
//  FullMoon
//
//  Created by Marc Ammann on 7/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FMMainViewController.h"
#import "FMSettingsViewController.h"

@implementation FMMainViewController

- (id)init {
	if (self = [super init]) {
		fullMoon = [[FMFullMoon alloc] init];
		fullMoon.delegate = self;
		[fullMoon load];
	}
	
	return self;
}

- (void)loadView {
	[super loadView];
	mainView = [[FMMainView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)];
	[self.view addSubview:mainView];
	
	infoButton = [[UIButton buttonWithType:UIButtonTypeInfoLight] retain];
	[infoButton addTarget:self action:@selector(showSettings:) forControlEvents:UIControlEventTouchUpInside];
	infoButton.frame = CGRectMake(280.0f, 420.0f, 30.0f, 30.0f);
	[self.view addSubview:infoButton];
	
	[mainView rotateMoon:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dealloc {
    [super dealloc];
}

- (void)fullMoon:(id)fullMoon didFailWithError:(NSError *)error {
	mainView.isItFullMoon.text = @"?!";
	NSLog(@"%@", error);
	
    [mainView rotateMoon:NO];
}

- (void)receivedDataForFullMoon:(id)aFullMoon {
	if ([fullMoon isItFullMoon]) {
		mainView.isItFullMoon.text = @"Yes";
	} else {
		mainView.isItFullMoon.text = @"No";
	}
	
	[mainView rotateMoon:NO];
}

- (void)settingsViewControllerDidFinish:(FMSettingsViewController *)controller {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)showSettings:(id)sender {
	FMSettingsViewController *settingsCtrl = [[FMSettingsViewController alloc] init];
	settingsCtrl.delegate = self;
	
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:settingsCtrl];
	
	navController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	
	[self presentModalViewController:navController animated:YES];
	[navController release];
	[settingsCtrl release];
	
}

@end
