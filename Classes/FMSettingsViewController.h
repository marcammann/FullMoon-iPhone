//
//  FMSettingsViewController.h
//  FullMoon
//
//  Created by Marc Ammann on 7/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMSettings.h"

@interface FMSettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	id delegate;
	
	NSArray *titles;
	NSArray *minutes;
	
	FMSettings  *settings;
	
	UITableView *tableView;
	
	UITableViewCell *activeMinuteCell;
}

@property (nonatomic, assign) id delegate;

- (UITableViewCell *)creditCell:(NSString *)title value:(NSString *)value link:(NSString *)url;
- (void)setActiveMinutesCell:(NSIndexPath *)indexPath;

@end
