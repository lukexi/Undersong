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

@class USWorldController;

@interface USCharacterController : UIViewController <UIAccelerometerDelegate> {

    // Accelerometer handling
    CMMotionManager *motionManager;
    double accelX, accelY, accelZ;

    double velocityX, velocityY;
    CGPoint position;

    IBOutlet USWorldController *worldController;
}

- (void)collectBlockInDirection:(UISwipeGestureRecognizerDirection)direction;

@end
