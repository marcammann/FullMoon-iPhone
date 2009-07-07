//
//  FMSettingsViewController.m
//  FullMoon
//
//  Created by Marc Ammann on 7/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FMSettingsViewController.h"

#import "FMMainViewController.h"


@implementation FMSettingsViewController

@synthesize delegate;

- (id)init {
	if (self = [super init]) {
		tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
		tableView.delegate = self;
		tableView.dataSource = self;
		
		titles = [[NSArray arrayWithObjects:@"Push Notifications", @"Credits", nil] retain];
		minutes = [[NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:60], [NSNumber numberWithInt:1440], [NSNumber numberWithInt:2880], nil] retain];
		
		settings = [[FMSettings alloc] init];
	}
	
	return self;
}

- (void)showMain:(id)sender {
	[(FMMainViewController *)delegate settingsViewControllerDidFinish:self];
}

- (void)loadView {
	[super loadView];
	
	self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor]; 
	
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(showMain:)];
	self.navigationItem.leftBarButtonItem = doneButton;
	[self.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
	
	tableView.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
	tableView.backgroundColor = [UIColor clearColor];
	
	[self.view addSubview:tableView];
}

- (void)dealloc {
	[titles release];
    [super dealloc];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = nil;
	
	switch (indexPath.section) {
		case 0:
			switch (indexPath.row) {
				case 0:
					cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
					cell.textLabel.text = @"Push Alert Enabled";
					
					cell.selectionStyle = UITableViewCellSelectionStyleNone;
					
					UISwitch *enabled = [[UISwitch alloc] initWithFrame:CGRectZero];
					enabled.center = CGPointMake(245.0f, 20.0f);

					[enabled setOn:[settings pushEnabled]];
					[enabled addTarget:self action:@selector(pushEnabled:) forControlEvents:UIControlEventValueChanged];

					[cell.contentView addSubview:enabled];
					break;
				case 1:
					cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
					cell.textLabel.text = @"1 Hour before";
					break;
				case 2:
					cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
					cell.textLabel.text = @"1 Day before";
					break;
				case 3:
					cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
					cell.textLabel.text = @"2 Days before";
					break;
				default:
					break;
			}
			
			if (settings.minutesBeforePush == [[minutes objectAtIndex:indexPath.row] intValue]) {
				activeMinuteCell = cell;
				activeMinuteCell.accessoryType = UITableViewCellAccessoryCheckmark;
			}
			
			break;
		case 1:
			switch (indexPath.row) {
				case 0:
					cell = [self creditCell:@"Graphics" value:@"Fabian Vogler" link:nil];
					break;
				case 1:
					cell = [self creditCell:@"API" value:@"isitfullmoon.com" link:nil];
					break;
				case 2:
					cell = [self creditCell:@"iPhone" value:@"Marc Ammann" link:nil];
					break;
				default:
					break;
			}
			break;
		default:
			return nil;
	}
	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	switch (indexPath.section) {
		case 0:
			[settings setMinutesBeforePush:[[minutes objectAtIndex:indexPath.row] intValue]];
			[tableView deselectRowAtIndexPath:indexPath animated:YES];
			[self setActiveMinutesCell:indexPath];
			break;
		default:
			break;
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch (section) {
		case 0:
			if (settings.pushEnabled) {
				return 4;
			} else {
				return 1;
			}
		case 1:
			return 2;
		default:
			return 0;
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [titles objectAtIndex:section];
}

- (void)pushEnabled:(id)sender {
	if (sender) {
		[settings setPushEnabled:[(UISwitch *)sender isOn]];
	}
	
	if ([settings pushEnabled]) {
		[tableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], 
										   [NSIndexPath indexPathForRow:2 inSection:0], 
										   [NSIndexPath indexPathForRow:3 inSection:0], 
										   nil] withRowAnimation:UITableViewRowAnimationTop];
	} else {
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], 
										   [NSIndexPath indexPathForRow:2 inSection:0], 
										   [NSIndexPath indexPathForRow:3 inSection:0], 
										   nil] withRowAnimation:UITableViewRowAnimationTop];
	}
}

- (void)setActiveMinutesCell:(NSIndexPath *)indexPath {
	activeMinuteCell.accessoryType = UITableViewCellAccessoryNone;
	activeMinuteCell = [tableView cellForRowAtIndexPath:indexPath];
	activeMinuteCell.accessoryType = UITableViewCellAccessoryCheckmark;
}

- (UITableViewCell *)creditCell:(NSString *)title value:(NSString *)value link:(NSString *)url {
	UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
	//cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 15.0f, 100.0f, 16.0f)];
	titleLabel.text = title;
	[cell.contentView addSubview:titleLabel];
	titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
	titleLabel.textColor = [UIColor darkGrayColor];
	
	UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(100.0f, 15.0f, 180.0f, 16.0f)];
	valueLabel.text = value;
	[cell.contentView addSubview:valueLabel];
	valueLabel.font = [UIFont systemFontOfSize:14.0f];	
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	return cell;
}

@end
