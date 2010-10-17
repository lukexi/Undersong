    //
//  USCharacterController.m
//  Undersong
//
//  Created by Michael Rotondo on 10/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "USCharacterController.h"

#define kAccelerometerFrequency        60.0 //Hz
#define kFilteringFactor 0.1

@interface USCharacterController ()
@property (nonatomic, assign) double accelX;
@property (nonatomic, assign) double accelY;
@property (nonatomic, assign) double accelZ;
@end


@implementation USCharacterController
@synthesize accelX;
@synthesize accelY;
@synthesize accelZ;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setFrame:CGRectMake(100, 100, TILESIZE, TILESIZE * 2)];
    [self.view setBackgroundColor:[UIColor colorWithCGColor:[UIColor whiteColor].CGColor]];

    motionManager = [[CMMotionManager alloc] init];

    NSLog(@"accelerometer available?! %@", motionManager.accelerometerAvailable ? @"YES" : @"NO" );

    UIAccelerometer*  theAccelerometer = [UIAccelerometer sharedAccelerometer];
    theAccelerometer.updateInterval = 1 / kAccelerometerFrequency;

    theAccelerometer.delegate = self;
}


- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    // Use a basic low-pass filter to keep only the gravity component of each axis.
    self.accelX = (acceleration.x * kFilteringFactor) + (self.accelX * (1.0 - kFilteringFactor));
    self.accelY = (acceleration.y * kFilteringFactor) + (self.accelY * (1.0 - kFilteringFactor));
    self.accelZ = (acceleration.z * kFilteringFactor) + (self.accelZ * (1.0 - kFilteringFactor));

    // Use the acceleration data.
    // NSLog(@"%f, %f, %f", accelX, accelY, accelZ);
    if (accelY < -0.07) {
        NSLog(@"LEFT");
    } else if (accelY > 0.07) {
        NSLog(@"RIGHT");
    }
    // TODO: Take original orientation as reference
    if (accelX > 0.06) {
        NSLog(@"UP");
    }
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (void)collectBlockInDirection:(UISwipeGestureRecognizerDirection)direction
{
    switch (swipeRecognizer.direction)
    {
        case UISwipeGestureRecognizerDirectionUp:
            [characterController collectBlockInDirection:];
            break;
        case <#constant#>:
            <#statements#>
            break;

        default:
            break;
    }
}

@end
