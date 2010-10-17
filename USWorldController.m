    //
//  USWorldController.m
//  Undersong
//
//  Created by Luke Iannini on 10/16/10.
//  Copyright 2010 Hello, Chair Inc. All rights reserved.
//

#import "USWorldController.h"
#import "USBlock.h"
#import "USBlockView.h"
#import "USWorldBlockView.h"
#import "USMainContext.h"
#import "UISwipeGestureRecognizer+Additions.h"

@interface USWorldController ()

- (void)createWorld;
- (void)renderWorld;

@end


@implementation USWorldController
@synthesize world;
@synthesize characterController;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];


    NSArray *swipeRecognizers = [UISwipeGestureRecognizer us_swipeGestureRecognizersForAllDirectionsWithTarget:self
                                                                                                        action:@selector(handleSwipe:)];

    [swipeRecognizers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        [self.view addGestureRecognizer:obj];
    }];

    // Initialization code.
    UITapGestureRecognizer *breakGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(breakBlock:)] autorelease];

    [self.view addGestureRecognizer:breakGesture];


    NSLog(@"View did load with orientation: %d", [self interfaceOrientation]);
}

- (void)breakBlock:(UIGestureRecognizer*)gestureRecognizer
{
    CGPoint loc = [gestureRecognizer locationInView:self.view];
    USBlock *block = [USBlock blockAtPoint:CGPointMake(loc.x / TILESIZE, loc.y / TILESIZE)];
    if (block)
    {
        [[block worldBlockView] breakAction];
        NSManagedObjectContext *context = [USMainContext mainContext];
        [context deleteObject:block];
        NSError *error = nil;
        [context save:&error];
    }
}


- (void)handleSwipe:(UISwipeGestureRecognizer *)swipeRecognizer
{
    [self.characterController collectBlockInDirection:swipeRecognizer.direction];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    // We're treating this as our viewDidLoad for anything that relies on
    // the XY dimensions of the view, like world creation etc.,
    // because it fires after we autorotate to the only orientation we support

    if ([self interfaceOrientation] == UIInterfaceOrientationLandscapeLeft)
    {
        NSLog(@"rotated to width: %f", self.view.bounds.size.width);

        NSManagedObjectContext *context = [USMainContext mainContext];
        NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
        [request setEntity:[USWorld entityInManagedObjectContext:context]];
        NSError *error = nil;
        NSArray *worlds = [context executeFetchRequest:request error:&error];

        if ([worlds count])
        {
            self.world = [worlds objectAtIndex:0];
        }
        else
        {
            [self createWorld];
        }
        self.characterController.character = [self.world.characters anyObject];

        [self renderWorld];

        NSLog(@"block at 0,21 is %@", [USBlock blockAtPoint:CGPointMake(0, 21)]);
    }
}

- (void)createWorld
{
    NSLog(@"HELLO");

    NSManagedObjectContext *context = [USMainContext mainContext];

    self.world = [USWorld worldWithSize:self.view.bounds.size inManagedObjectContext:context];
    NSError *error = nil;
    [context save:&error];
}

- (void)renderWorld
{
    for (USBlock *block in self.world.blocks)
    {
        [self.view addSubview:[block worldBlockView]];
    }

    [self.view addSubview:self.characterController.view];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Overriden to allow any orientation.
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
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
    self.world = nil;
    self.characterController = nil;
    [super dealloc];
}


@end
