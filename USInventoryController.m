    //
//  USInventoryController.m
//  Undersong
//
//  Created by Luke Iannini on 10/17/10.
//  Copyright 2010 Hello, Chair Inc. All rights reserved.
//

#import "USInventoryController.h"
#import "USInventoryBlockView.h"
#import "UISwipeGestureRecognizer+Additions.h"
#import "USInventoryEntry.h"

@implementation USInventoryController
@synthesize characterController;

+ (USInventoryController *)inventoryControllerForCharacterController:(USCharacterController *)aCharacterController
{
    USInventoryController *inventoryController = [[[USInventoryController alloc] initWithNibName:@"USInventoryController"
                                                                                          bundle:nil] autorelease];
    inventoryController.characterController = aCharacterController;
    return inventoryController;
}

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

    self.title = @"Purse";

    NSInteger itemSize = 44;
    NSInteger spacing = 2;

    NSInteger xItems = round(self.view.bounds.size.width / (itemSize + spacing));

    NSArray *objectsArray = [self.characterController.character.inventoryEntries allObjects];
    NSLog(@"Inventory entries: %@", objectsArray);
    [objectsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        NSInteger x = idx % xItems;
        NSInteger y = (int)floor(idx / xItems);

        USInventoryEntry *entry = obj;
        USBlock *block = entry.block;
        USInventoryBlockView *blockView = [block inventoryBlockView];
        blockView.frame = CGRectMake(x * (itemSize + spacing),
                                     y * (itemSize + spacing),
                                     itemSize,
                                     itemSize);
        blockView.gestureRecognizers = [UISwipeGestureRecognizer us_swipeGestureRecognizersForAllDirectionsWithTarget:self
                                                                                                               action:@selector(handleSwipe:)];

        [self.view addSubview:blockView];
    }];


    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                            target:self
                                                                                            action:@selector(doneAction:)] autorelease];
}

- (IBAction)doneAction:(id)sender
{
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipeRecognizer
{
    UISwipeGestureRecognizerDirection direction = swipeRecognizer.direction;
    USInventoryBlockView *blockView = (USInventoryBlockView *)swipeRecognizer.view;
    USBlock *block = blockView.block;
    if (!block)
    {
        return;
    }

    BOOL blockPlaced = [self.characterController placeBlock:block
                                                inDirection:direction];
    if (blockPlaced)
    {
        [UIView animateWithDuration:0.3 animations:^{
            switch (direction)
            {
                case UISwipeGestureRecognizerDirectionUp:
                    blockView.center = CGPointMake(blockView.center.x, blockView.center.y - blockView.bounds.size.height);
                    break;
                case UISwipeGestureRecognizerDirectionDown:
                    blockView.center = CGPointMake(blockView.center.x, blockView.center.y + blockView.bounds.size.height);
                    break;
                case UISwipeGestureRecognizerDirectionLeft:
                    blockView.center = CGPointMake(blockView.center.x - blockView.bounds.size.width, blockView.center.y);
                    break;
                case UISwipeGestureRecognizerDirectionRight:
                    blockView.center = CGPointMake(blockView.center.x + blockView.bounds.size.width, blockView.center.y);
                    break;
                default:
                    break;
            }
        } completion:^(BOOL finished) {
            [blockView removeFromSuperview];
        }];
    }
    else
    {
        [UIView animateWithDuration:0.15 animations:^{
            blockView.transform = CGAffineTransformMakeScale(1.5, 1.5);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                blockView.transform = CGAffineTransformIdentity;
            }];
        }];
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


- (void)dealloc
{
    self.characterController = nil;
    [super dealloc];
}


@end
