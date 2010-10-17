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
#import "USMainContext.h"

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

    NSLog(@"View did load with orientation: %d", [self interfaceOrientation]);

}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    NSLog(@"rotated to width: %f", self.view.bounds.size.width);
    // We're treating this as our viewDidLoad, because it fires after we autorotate to the only orientation we support

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

    [self renderWorld];
}

- (void)createWorld
{
    NSManagedObjectContext *context = [USMainContext mainContext];
    self.world = [USWorld insertInManagedObjectContext:context];

    NSInteger horizontalTileCount = round(self.view.bounds.size.width / TILESIZE) + 1;
    NSInteger verticalTileCount = round(self.view.bounds.size.height / TILESIZE) + 1;

    self.world.xSize = [NSNumber numberWithInt:horizontalTileCount];
    self.world.ySize = [NSNumber numberWithInt:verticalTileCount];

    for (NSInteger x = 0; x < horizontalTileCount; x++)
    {
        for (NSInteger y = 0; y < verticalTileCount; y++)
        {
            USBlock *block = [USBlock insertInManagedObjectContext:context];
            block.world = self.world;
            block.xPosition = [NSNumber numberWithInt:x];
            block.yPosition = [NSNumber numberWithInt:y];
        }
    }

    NSError *error = nil;
    [context save:&error];
}

- (void)renderWorld
{
    for (USBlock *block in self.world.blocks)
    {
        [self.view addSubview:[block blockView]];
    }

    [self.view addSubview:self.characterController.view];
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
    self.world = nil;
    self.characterController = nil;
    [super dealloc];
}


@end
