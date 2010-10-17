#import "USBlock.h"
#import "USWorldController.h"
#import "USBlockView.h"

@implementation USBlock

// Custom logic goes here.

- (USBlockView *)blockView
{
    NSInteger x = [self.xPosition intValue];
    NSInteger y = [self.yPosition intValue];
    USBlockView *blockView = [[[USBlockView alloc] initWithFrame:CGRectMake(x * TILESIZE, y * TILESIZE,
                                                                            TILESIZE, TILESIZE)] autorelease];

    blockView.backgroundColor = [UIColor colorWithHue:USRandomFloat()
                                           saturation:0.5
                                           brightness:0.5
                                                alpha:1];

    return blockView;
}

@end
