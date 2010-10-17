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

@interface USCharacterController : UIViewController <UIAccelerometerDelegate> {

    CMMotionManager *motionManager;
    double accelX, accelY, accelZ;
}

@end
