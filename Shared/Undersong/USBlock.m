#import "USBlock.h"
#import "USWorldController.h"
#import "USBlockView.h"
#import "USWorldBlockView.h"
#import "USInventoryBlockView.h"
#import "USMainContext.h"
#import <QuartzCore/QuartzCore.h>

@implementation USBlock
@synthesize view;
// Custom logic goes here.

- (USWorldBlockView *)worldBlockView
{
    // FANCY PANTS
    if ([self.view isKindOfClass:[USWorldBlockView class]])
    {
        return (USWorldBlockView *)self.view;
    }

    NSInteger x = [self.xPosition intValue];
    NSInteger y = [self.yPosition intValue];

    USWorldBlockView *blockView = [[[USWorldBlockView alloc] initWithFrame:CGRectMake(x * TILESIZE, y * TILESIZE,
                                                                                      TILESIZE, TILESIZE)] autorelease];
    [blockView setIsPrecious:self.isPreciousValue];

    self.view = blockView;
    return blockView;
}

- (USInventoryBlockView *)inventoryBlockView
{
    if ([self.view isKindOfClass:[USInventoryBlockView class]])
    {
        return (USInventoryBlockView *)self.view;
    }

    USInventoryBlockView *blockView = [[[USInventoryBlockView alloc] initWithFrame:CGRectZero] autorelease];
    [blockView setIsPrecious:self.isPreciousValue];
    blockView.block = self;

    self.view = blockView;

    return blockView;
}

- (void)dealloc
{
    self.view = nil;
    [super dealloc];
}

@end
