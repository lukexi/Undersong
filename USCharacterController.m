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
@property (nonatomic, assign) double velocityX;
@property (nonatomic, assign) double velocityY;
@property (nonatomic, assign) CGPoint position;
@end


@implementation USCharacterController
@synthesize accelX;
@synthesize accelY;
@synthesize accelZ;
@synthesize velocityX;
@synthesize velocityY;
@synthesize position;
@synthesize character;

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
- (void)viewDidLoad
{
    [super viewDidLoad];

#if TARGET_IPHONE_SIMULATOR
    [self.view setFrame:CGRectMake(100, 100, TILESIZE, TILESIZE * 2)];
#endif

    [self.view setBackgroundColor:[UIColor colorWithCGColor:[UIColor blackColor].CGColor]];

    motionManager = [[CMMotionManager alloc] init];

    NSLog(@"accelerometer available?! %@", motionManager.accelerometerAvailable ? @"YES" : @"NO" );

    UIAccelerometer*  theAccelerometer = [UIAccelerometer sharedAccelerometer];
    theAccelerometer.updateInterval = 1 / kAccelerometerFrequency;

    theAccelerometer.delegate = self;

    accelX = accelY = accelZ = 0.0;
    velocityX = velocityY = 0.0;
    position = CGPointMake(100, 100);
}


- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    // Use a basic low-pass filter to keep only the gravity component of each axis.
    self.accelX = (acceleration.x * kFilteringFactor) + (self.accelX * (1.0 - kFilteringFactor));
    self.accelY = (acceleration.y * kFilteringFactor) + (self.accelY * (1.0 - kFilteringFactor));
    self.accelZ = (acceleration.z * kFilteringFactor) + (self.accelZ * (1.0 - kFilteringFactor));

    // Use the acceleration data.
    //NSLog(@"%f, %f, %f", accelX, accelY, accelZ);
//    if (accelY < -0.09) {
//        NSLog(@"LEFT");
//    } else if (accelY > 0.09) {
//        NSLog(@"RIGHT");
//    }
//    // TODO: Take original orientation as reference
//    if (accelX > 0.08) {
//        NSLog(@"UP");
//    }


    // HACKY HACKY HACKTOWN, this should be in its own tick function, run on a tick timer.
    if (fabs(self.accelY) > 0.02) {
        self.velocityX += self.accelY;
    }
    self.velocityX *= 0.9;
    if (fabs(self.velocityX) < 0.01) {
        self.velocityX = 0.0;
    }
    self.position = CGPointMake(self.position.x + self.velocityX, self.position.y);

    if (self.position.x < 0)
    {
        self.position = CGPointMake(0, self.position.y);
    }
    // width in tiles conveniently equals screen size right now, we'll need to scroll later.
    else if (self.position.x > self.character.world.xSizeValue * TILESIZE)
    {
        self.position = CGPointMake(self.character.world.xSizeValue * TILESIZE, self.position.y);
    }



    //else if (self.position > self.
    self.view.frame = CGRectMake(self.position.x, self.position.y, TILESIZE, TILESIZE * 2);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Overriden to allow any orientation.
    return YES;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    self.character = nil;
    [super dealloc];
}

- (void)collectBlockInDirection:(UISwipeGestureRecognizerDirection)direction
{
    switch (direction)
    {
        case UISwipeGestureRecognizerDirectionUp:
            NSLog(@"collecting Up: %@", self);
            break;
        case UISwipeGestureRecognizerDirectionDown:
            NSLog(@"collecting down: %@", self);
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            NSLog(@"collecting left: %@", self);
            break;
        case UISwipeGestureRecognizerDirectionRight:
            NSLog(@"collecting right: %@", self);
            break;
        default:
            break;
    }
}

@end
