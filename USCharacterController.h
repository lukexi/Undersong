//
//  USCharacterController.h
//  Undersong
//
//  Created by Michael Rotondo on 10/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import "USGlobals.h"
#import "USCharacter.h"
#import "USBlock.h"

extern NSString *USCharacterControllerDidPlaceBlock;

@class USWorldController;

@interface USCharacterController : UIViewController <UIAccelerometerDelegate>
{
    // Accelerometer handling
    CMMotionManager *motionManager;
    double accelX, accelY, accelZ;

    double velocityX, velocityY;
    CGPoint position;

    USCharacter *character;
}

@property (nonatomic, retain) USCharacter *character;

- (void)collectBlockInDirection:(UISwipeGestureRecognizerDirection)direction;
- (BOOL)placeBlock:(USBlock *)block inDirection:(UISwipeGestureRecognizerDirection)direction;
- (void) handleCollision;

- (CGPoint)pointInDirection:(UISwipeGestureRecognizerDirection)direction;

@end
