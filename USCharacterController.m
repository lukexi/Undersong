    //
//  USCharacterController.m
//  Undersong
//
//  Created by Michael Rotondo on 10/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "USCharacterController.h"
#import "USBlock.h"
#import "USWorld.h"
#import <QuartzCore/QuartzCore.h>

#define kAccelerometerFrequency        30.0 //Hz
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

    UIImageView *imageView = (UIImageView *)self.view;
    imageView.image = [UIImage imageNamed:@"Underman.png"];

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
        self.velocityX += self.accelY * 2;
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

    //gravity
    self.velocityY += 0.4;
    
    //jetpack
    if (self.accelX > 0.3) {
        self.velocityY -= self.accelX;
    }
    if (self.velocityY < 0)
    {
        //air resistance while rising
        self.velocityY *= 0.9;
    }

    self.position = CGPointMake(self.position.x, self.position.y + self.velocityY);
    
    if (self.position.y < 0)
    {
        self.position = CGPointMake(self.position.x, 0);
    }
    
    [self handleCollision];
    
    self.view.frame = CGRectMake(self.position.x, self.position.y, TILESIZE, TILESIZE * 2);
}

- (void)handleCollision
{
//    NSLog(@"Handling collisions----------------------------------------");
    
    // Get block information for all points potentially covered by the character
    // Keys are NSValues corresponding to the CGPoints 
    // (0, 0), (1, 0), 
    // (0, 1), (1, 1), 
    // (0, 2), (1, 2)
    NSDictionary *blocksCovered = [USBlock blocksAroundCharacterPoint:self.position];
//    double newX, newY;
//    newX = self.position.x;
//    newY = self.position.y;
    [blocksCovered enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        USBlock *block = (USBlock *)obj;
        if (obj != [NSNull null])
        {
//            NSLog(@"Got a block");
            double xDiff = self.position.x - block.xPositionValue * TILESIZE;
            double yDiff = (self.position.y - block.yPositionValue * TILESIZE) / 2;
            
//            NSLog(@"xDiff: %f, yDiff: %f", xDiff, yDiff);
            
            if (fabs(xDiff) < TILESIZE && fabs(xDiff) < fabs(yDiff))
            {
//                NSLog(@"Colliding on a horizontal face");
                //Colliding on a horizontal face
                self.velocityY = 0.0;
                if (yDiff > 0)
                {
//                    NSLog(@"A");
                    self.position = CGPointMake(self.position.x, self.position.y + (TILESIZE - yDiff));
                }
                else
                {
//                    NSLog(@"B");
                    self.position = CGPointMake(self.position.x, (block.yPositionValue - 2) * TILESIZE);
                }
            }
            else if (fabs(yDiff) < TILESIZE && fabs(yDiff) < fabs(xDiff))
            { 
//                NSLog(@"Colliding on a vertical face");
                //Colliding on a vertical face
                self.velocityX = 0.0;
                if (xDiff > 0)
                {
//                    NSLog(@"C");
                    self.position = CGPointMake(self.position.x + (TILESIZE - xDiff), self.position.y);
                }
                else
                {
//                    NSLog(@"D");
                    self.position = CGPointMake(self.position.x - (TILESIZE + xDiff), self.position.y);
                }
            }
        }
    }];

    
    
//    // Which points could the player end up at?
//    BOOL ZeroZeroPossible = YES;
//    BOOL OneZeroPossible = YES;
//    BOOL ZeroOnePossible = YES;
//    BOOL OneOnePossible = YES;
//    
//    //NSLog(@"blocksCovered: %@", blocksCovered);
//    
//    if ([blocksCovered objectForKey:[NSValue valueWithCGPoint:CGPointMake(0, 0)]] != [NSNull null] ||
//        [blocksCovered objectForKey:[NSValue valueWithCGPoint:CGPointMake(0, 1)]] != [NSNull null])
//    {
//        ZeroZeroPossible = NO;
//    }
//    if ([blocksCovered objectForKey:[NSValue valueWithCGPoint:CGPointMake(1, 1)]] != [NSNull null] ||
//        [blocksCovered objectForKey:[NSValue valueWithCGPoint:CGPointMake(1, 2)]] != [NSNull null])
//    {
//        OneZeroPossible = NO;
//    }
//    if ([blocksCovered objectForKey:[NSValue valueWithCGPoint:CGPointMake(1, 0)]] != [NSNull null] ||
//        [blocksCovered objectForKey:[NSValue valueWithCGPoint:CGPointMake(1, 1)]] != [NSNull null])
//    {
//        ZeroOnePossible = NO;
//    }
//    if ([blocksCovered objectForKey:[NSValue valueWithCGPoint:CGPointMake(1, 1)]] != [NSNull null] ||
//        [blocksCovered objectForKey:[NSValue valueWithCGPoint:CGPointMake(1, 2)]] != [NSNull null])
//    {
//        OneOnePossible = NO;
//    }
//
//    // NO BLOCKS COVERED, we don't have to correct anything.
//    if (ZeroZeroPossible && OneZeroPossible && ZeroOnePossible && OneOnePossible)
//    {
//        //NSLog(@"NO COLLISION");
//        return;
//    }
//
//    
//    // SOME BLOCKS COVERED, move to the closest available position
//    CGPoint closestPoint = self.position;
//    CGFloat minSquaredDist = 1000000;
//    
//    if (ZeroZeroPossible)
//    {
//        CGPoint zeroZero = CGPointMake((NSInteger) (self.position.x - fmod(self.position.x, TILESIZE)), 
//                                       (NSInteger) (self.position.y - fmod(self.position.y, TILESIZE)));
//        CGFloat squaredDist = pow(self.position.x - zeroZero.x, 2) + pow(self.position.y - zeroZero.y, 2);
//        if (squaredDist < minSquaredDist)
//        {
//            minSquaredDist = squaredDist;
//            closestPoint = zeroZero;
//        }
//    }
//    if (OneZeroPossible)
//    {
//        CGPoint oneZero = CGPointMake((NSInteger) (self.position.x - fmod(self.position.x, TILESIZE) + TILESIZE), 
//                                       (NSInteger) (self.position.y - fmod(self.position.y, TILESIZE)));
//        CGFloat squaredDist = pow(self.position.x - oneZero.x, 2) + pow(self.position.y - oneZero.y, 2);
//        if (squaredDist < minSquaredDist)
//        {
//            minSquaredDist = squaredDist;
//            closestPoint = oneZero;
//        }
//    }
//    if (ZeroOnePossible)
//    {
//        CGPoint zeroOne = CGPointMake((NSInteger) (self.position.x - fmod(self.position.x, TILESIZE)), 
//                                       (NSInteger) (self.position.y - fmod(self.position.y, TILESIZE) + TILESIZE));
//        CGFloat squaredDist = pow(self.position.x - zeroOne.x, 2) + pow(self.position.y - zeroOne.y, 2);
//        if (squaredDist < minSquaredDist)
//        {
//            minSquaredDist = squaredDist;
//            closestPoint = zeroOne;
//        }
//    }
//    if (OneOnePossible)
//    {
//        CGPoint oneOne = CGPointMake((NSInteger) (self.position.x - fmod(self.position.x, TILESIZE) + TILESIZE), 
//                                       (NSInteger) (self.position.y - fmod(self.position.y, TILESIZE) + TILESIZE));
//        CGFloat squaredDist = pow(self.position.x - oneOne.x, 2) + pow(self.position.y - oneOne.y, 2);
//        if (squaredDist < minSquaredDist)
//        {
//            minSquaredDist = squaredDist;
//            closestPoint = oneOne;
//        }
//    }
//    
//    if (self.velocityX > 0 && closestPoint.x < self.position.x ||
//        self.velocityX < 0 && closestPoint.x > self.position.x)
//    {
//        self.velocityX = 0;
//    }
//    if (self.velocityY > 0 && closestPoint.y < self.position.y ||
//        self.velocityY < 0 && closestPoint.y > self.position.y)
//    {
//        self.velocityY = 0;
//    }
//    
//    self.position = closestPoint;
    
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
