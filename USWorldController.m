    //
//  USWorldController.m
//  Undersong
//
//  Created by Luke Iannini on 10/16/10.
//  Copyright 2010 Hello, Chair Inc. All rights reserved.
//

#import "USWorldController.h"
#import "USBlock.h"

float USRandomFloat(void)
{
    return (double)arc4random() / ARC4RANDOM_MAX;
}

@implementation USWorldController
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
    
    NSInteger horizontalTileCount = round(self.view.bounds.size.width / TILESIZE) + 1;
    NSInteger verticalTileCount = round(self.view.bounds.size.height / TILESIZE) + 1;
    
    for (NSInteger x = 0; x < horizontalTileCount; x++)
    {
        for (NSInteger y = 0; y < verticalTileCount; y++)
        {
            USBlock *tile = [[[USBlock alloc] initWithFrame:CGRectMake(x * TILESIZE, y * TILESIZE,
                                                                       TILESIZE, TILESIZE)] autorelease];
            
            tile.backgroundColor = [UIColor colorWithHue:USRandomFloat()
                                              saturation:0.5
                                              brightness:0.5
                                                   alpha:1];
            [self.view addSubview:tile];
        }
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
    self.characterController = nil;
    [super dealloc];
}


@end
