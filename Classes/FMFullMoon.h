//
//  FMFullMoon.h
//  FullMoon
//
//  Created by Marc Ammann on 7/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol FMFullMoonDelegate
- (void)fullMoon:(id)fullMoon didFailWithError:(NSError *)error;
- (void)receivedDataForFullMoon:(id)fullMoon;
@end


@interface FMFullMoon : NSObject {
	NSString *timeZone;

	NSMutableData *receivedData;
	
	// The delegate where data gets sent to
	id<FMFullMoonDelegate> delegate;
	
	// For parsing the stuff
    NSMutableString *currentProperty;
	
	// Parser Error
	NSError *parseError;
	
	NSDate *nextFullMoon;
	NSDate *prevFullMoon;
	BOOL isItFullMoon;
}


@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) NSMutableString *currentProperty;

- (void)load;
- (BOOL)isItFullMoon;
- (NSDate *)nextFullMoon;
- (NSDate *)prevFullMoon;

- (NSDate *)dateFromString:(NSString *)timestamp;
- (void)parseReceivedData;

@end
