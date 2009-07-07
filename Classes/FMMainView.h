//
//  FMMainView.h
//  FullMoon
//
//  Created by Marc Ammann on 7/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FMMainView : UIView {
	UILabel *isItFullMoon;
	UILabel *subline;
	UILabel *nextFullMoon;
	UIImageView *moon;
	UIImageView *backgroundView;
	
	CAKeyframeAnimation *animation;
}

@property (nonatomic, readonly) UILabel *isItFullMoon;
@property (nonatomic, readonly) UIImageView *moon;

- (void)rotateMoon:(BOOL)rotate;
- (CAKeyframeAnimation *)moonAnimation:(CATransform3D)currentTransform;

@end
