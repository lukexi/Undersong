#import "USBlock.h"
#import "USWorldController.h"
#import "USBlockView.h"
#import "USWorldBlockView.h"
#import "USInventoryBlockView.h"
#import "USMainContext.h"

@implementation USBlock
@synthesize view;
// Custom logic goes here.

- (USWorldBlockView *)worldBlockView
{
    // FANCY PANTS
    if ([self.view isKindOfClass:[USWorldBlockView class]])
    {
        return (USWorldBlockView *) self.view;
    }
    
    NSInteger x = [self.xPosition intValue];
    NSInteger y = [self.yPosition intValue];
    
    USWorldBlockView *blockView = [[[USWorldBlockView alloc] initWithFrame:CGRectMake(x * TILESIZE, y * TILESIZE,
                                                                            TILESIZE, TILESIZE)] autorelease];

    blockView.backgroundColor = [UIColor colorWithHue:USRandomFloat()
                                           saturation:0.5
                                           brightness:0.5
                                                alpha:1];
    self.view = blockView;
    return blockView;
}

+ (USBlock *) blockAtPoint:(CGPoint)point
{
    NSManagedObjectContext *context = [USMainContext mainContext];
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    [request setEntity:[USBlock entityInManagedObjectContext:context]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"xPosition == %i AND yPosition == %i", point.x, point.y];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if ([results count])
    {
        return [results lastObject];
    }
    else 
    {
        return nil;
    }
}

- (void)dealloc
{    
    self.view = nil;
    [super dealloc];
}

@end
