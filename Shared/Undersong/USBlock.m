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

+ (USBlock *)blockAtPoint:(CGPoint)point
{
    //NSLog(@"getting block point %f, %f", point.x, point.y);

    NSManagedObjectContext *context = [USMainContext mainContext];
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    [request setEntity:[USBlock entityInManagedObjectContext:context]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"xPosition == %i AND yPosition == %i AND world != NULL",
                              (NSInteger)point.x, (NSInteger)point.y];
    [request setPredicate:predicate];

    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];

    if ([results count])
    {
        //NSLog(@"GOT A BLOCK");
        return [results lastObject];
    }
    else
    {
        return nil;
    }
}

+ (NSDictionary *) blocksAroundCharacterPoint:(CGPoint)point
{
    //NSLog(@"Getting blocks around player point at %f, %f", point.x, point.y);

    point = CGPointMake((NSInteger) (point.x / TILESIZE), (NSInteger) (point.y / TILESIZE));

    //NSLog(@"player block point is %f, %f", point.x, point.y);

    NSMutableDictionary *returnDict = [[NSMutableDictionary alloc] initWithCapacity:6];

    USBlock *block = [USBlock blockAtPoint:point];
    [returnDict setObject:(block ? block : (USBlock *)[NSNull null]) forKey: [NSValue valueWithCGPoint:CGPointMake(0, 0)]];
    block = [USBlock blockAtPoint:CGPointMake(point.x + 1, point.y)];
    [returnDict setObject:(block ? block : (USBlock *)[NSNull null]) forKey: [NSValue valueWithCGPoint:CGPointMake(1, 0)]];
    block = [USBlock blockAtPoint:CGPointMake(point.x, point.y + 1)];
    [returnDict setObject:(block ? block : (USBlock *)[NSNull null]) forKey: [NSValue valueWithCGPoint:CGPointMake(0, 1)]];
    block = [USBlock blockAtPoint:CGPointMake(point.x + 1, point.y + 1)];
    [returnDict setObject:(block ? block : (USBlock *)[NSNull null]) forKey: [NSValue valueWithCGPoint:CGPointMake(1, 1)]];
    block = [USBlock blockAtPoint:CGPointMake(point.x, point.y + 2)];
    [returnDict setObject:(block ? block : (USBlock *)[NSNull null]) forKey: [NSValue valueWithCGPoint:CGPointMake(0, 2)]];
    block = [USBlock blockAtPoint:CGPointMake(point.x + 1, point.y + 2)];
    [returnDict setObject:(block ? block : (USBlock *)[NSNull null]) forKey: [NSValue valueWithCGPoint:CGPointMake(1, 2)]];

    return returnDict;
}

- (void)dealloc
{
    self.view = nil;
    [super dealloc];
}

- (void)moveToInventoryForCharacter:(USCharacter *)aCharacter
{

}

- (void)moveToWorld
{

}

@end
