//
//  FMSettings.h
//  FullMoon
//
//  Created by Marc Ammann on 7/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FMSettings : NSObject {
	BOOL pushEnabled;
	NSInteger minutesBeforePush;
	BOOL registredAPNS;
	BOOL registredProvider;
}

@property (nonatomic, readwrite) BOOL pushEnabled;
@property (nonatomic, readwrite) NSInteger minutesBeforePush;
- (void)setRegistredAPNS:(BOOL)registred;

- (void)registrationSucceeded:(BOOL)succ;


@end
