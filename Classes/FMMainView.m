//
//  FMMainView.m
//  FullMoon
//
//  Created by Marc Ammann on 7/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FMMainView.h"


@implementation FMMainView

@synthesize isItFullMoon;
@synthesize moon;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		isItFullMoon = [[UILabel alloc] initWithFrame:CGRectMake(40.0f, 200.0f, 220.0f, 100.0f)];
		isItFullMoon.backgroundColor = [UIColor clearColor];
		isItFullMoon.font = [UIFont systemFontOfSize:120.0f];
		isItFullMoon.textColor = [UIColor whiteColor];
		
		nextFullMoon = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 400.0f, 280.0f, 50.0f)];
		
		moon = [[UIImageView alloc] initWithFrame:CGRectMake(180.0f, 100.0f, 120.0f, 120.0f)];
		moon.image = [UIImage imageNamed:@"fullmoon.png"];
		
		backgroundView = [[UIImageView alloc] initWithFrame:frame];
		backgroundView.image = [UIImage imageNamed:@"background-main.png"];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
	[self addSubview:backgroundView];
	[self addSubview:moon];
	[self addSubview:isItFullMoon];
}

- (void)rotateMoon:(BOOL)rotate {
	if (rotate) {
		[moon.layer removeAllAnimations];
		
		animation = [self moonAnimation:CATransform3DMakeRotation(0, 0.0f, 0.0f, 1.0f)];
		[animation setRepeatCount:10000];
		[moon.layer addAnimation:animation forKey:@"transform"];
	} else {
		[moon.layer removeAllAnimations];
		
		animation = [self moonAnimation:[(CALayer*)moon.layer.presentationLayer transform]];	
		[animation setRepeatCount:1];
		[moon.layer addAnimation:animation forKey:@"transform"];
	}
}

- (CAKeyframeAnimation *)moonAnimation:(CATransform3D)currentTransform {
	CAKeyframeAnimation *anAnimation = [CAKeyframeAnimation animation];

	NSArray *values = [NSArray arrayWithObjects:
					   [NSValue valueWithCATransform3D:currentTransform],
					   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI/2, 0.0f, 0.0f, 1.0f)],
					   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f)],
					   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI * 1.5, 0.0f, 0.0f, 1.0f)],
					   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI * 2, 0.0f, 0.0f, 1.0f)],
					   nil];
	
	anAnimation = [CAKeyframeAnimation animation];
	
	[anAnimation setValues:values];
	[anAnimation setDuration:5.0f];	
	
	return anAnimation;
}

- (void)dealloc {
	[isItFullMoon release];
	[nextFullMoon release];
	[moon release];
	[backgroundView release];
    [super dealloc];
}


@end
