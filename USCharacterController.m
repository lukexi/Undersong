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
#import "USWorldBlockView.h"
#import "USInventoryEntry.h"
#import <QuartzCore/QuartzCore.h>

#define kAccelerometerFrequency        30.0 //Hz
#define kFilteringFactor 0.1

NSString *USCharacterControllerDidPlaceBlock = @"USCharacterControllerDidPlaceBlock";

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

    imageView.animationImages = [NSArray arrayWithObjects:
                                 [UIImage imageNamed:@"UndermanFrame1.png"],
                                 [UIImage imageNamed:@"UndermanFrame2.png"],
                                 [UIImage imageNamed:@"UndermanFrame3.png"],
                                 [UIImage imageNamed:@"UndermanFrame4.png"],
                                 nil];
    [imageView startAnimating];
    //imageView.animationDuration

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

    self.velocityY += 0.1;
    self.position = CGPointMake(self.position.x, self.position.y + self.velocityY);
    //else if (self.position > self.

    [self handleCollision];

    self.view.frame = CGRectMake(self.position.x, self.position.y, TILESIZE, TILESIZE * 2);
}

- (void)handleCollision
{
    // Assume that character is <= one block wide, and so can be on at most 2 blocks at once.
    NSInteger x1, x2, y;
    x1 = self.position.x / TILESIZE;
    x2 = (self.position.x + TILESIZE) / TILESIZE;
    // Find the y position of the block-row that character's feet are currently in.
    y = (self.position.y + TILESIZE * 2) / TILESIZE;
    USBlock *block1 = [USBlock blockAtPoint:CGPointMake(x1, y)];
    USBlock *block2 = [USBlock blockAtPoint:CGPointMake(x2, y)];

    if (block1 != nil || block2 != nil) {
        self.velocityY = 0.0;
        self.position = CGPointMake(self.position.x, (y - 2) * TILESIZE);
    }
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

- (CGPoint)pointInDirection:(UISwipeGestureRecognizerDirection)direction
{
    CGPoint manPoint = CGPointMake(self.position.x / TILESIZE, self.position.y / TILESIZE);
    CGPoint blockPoint = CGPointZero;
    switch (direction)
    {
        case UISwipeGestureRecognizerDirectionUp:
            blockPoint = CGPointMake(manPoint.x, manPoint.y - 1);
            break;
        case UISwipeGestureRecognizerDirectionDown:
            blockPoint = CGPointMake(manPoint.x, manPoint.y + 2); // UNTERMAN is 2 blocks tall
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            blockPoint = CGPointMake(manPoint.x - 1, manPoint.y);
            break;
        case UISwipeGestureRecognizerDirectionRight:
            blockPoint = CGPointMake(manPoint.x + 1, manPoint.y);
            break;
        default:
            break;
    }
    return blockPoint;
}

- (void)collectBlockInDirection:(UISwipeGestureRecognizerDirection)direction
{
    CGPoint blockPoint = [self pointInDirection:direction];

    USBlock *block = [USBlock blockAtPoint:blockPoint];

    if (block)
    {
        NSManagedObjectContext *context = [block managedObjectContext];
        USInventoryEntry *inventoryEntry = [USInventoryEntry insertInManagedObjectContext:context];
        inventoryEntry.block = block;
        block.world = nil;
        [self.character addInventoryEntriesObject:inventoryEntry];
        [[block worldBlockView] collectAction];
        block.view = nil;
        NSLog(@"inventory entry: %@", inventoryEntry);

        NSError *error = nil;
        [context save:&error];
        //NSLog(@"inventory!: %@", self.character.inventoryEntries);
    }
}

- (BOOL)placeBlock:(USBlock *)block inDirection:(UISwipeGestureRecognizerDirection)direction
{
    CGPoint blockPoint = [self pointInDirection:direction];

    USBlock *existingBlock = [USBlock blockAtPoint:blockPoint];

    if (existingBlock)
    {
        return NO;
    }

    block.xPositionValue = blockPoint.x;
    block.yPositionValue = blockPoint.y;

    [self.character.world addBlocksObject:block];
    NSLog(@"deleting inventory: %@", block.inventoryEntry);
    [[block managedObjectContext] deleteObject:block.inventoryEntry];
    NSError *error = nil;
    [[block managedObjectContext] save:&error];

    [[NSNotificationCenter defaultCenter] postNotificationName:USCharacterControllerDidPlaceBlock
                                                        object:block];
    return YES;
}

@end
