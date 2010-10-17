#import "USWorld.h"
#import "USCharacter.h"
#import "USGlobals.h"
#import "USBlock.h"

@implementation USWorld
@synthesize blockMatrix;


// Custom logic goes here.

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    [self addCharactersObject:[USCharacter insertInManagedObjectContext:[self managedObjectContext]]];
}

- (void)awakeFromFetch
{
    self.blockMatrix = [NSMutableArray arrayWithCapacity:self.xSizeValue];
    for (NSInteger x = 0; x < self.xSizeValue; x++)
    {
        NSMutableArray *yArray = [NSMutableArray arrayWithCapacity:self.ySizeValue];
        [self.blockMatrix addObject:yArray];

        NSSet *currentColumn = [self.blocks filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"xPosition == %i", x]];
        for (NSInteger y = 0; y < self.ySizeValue; y++)
        {
            NSSet *blockSet = [currentColumn filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"yPosition == %i", y]];
            if ([blockSet count])
            {
                [yArray addObject:[blockSet anyObject]];
            }
            else
            {
                [yArray addObject:[NSNull null]];
            }
        }
    }
}

+ (USWorld *)worldWithSize:(CGSize)worldSize inManagedObjectContext:(NSManagedObjectContext *)context
{
    USWorld *world = [USWorld insertInManagedObjectContext:context];

    NSInteger horizontalTileCount = round(worldSize.width / TILESIZE) + 1;
    NSInteger verticalTileCount = round(worldSize.height / TILESIZE) + 1;
    NSInteger halfVerticalTileCount = round(verticalTileCount / 2);

    world.xSize = [NSNumber numberWithInt:horizontalTileCount];
    world.ySize = [NSNumber numberWithInt:verticalTileCount];

    world.blockMatrix = [NSMutableArray arrayWithCapacity:horizontalTileCount];

    for (NSInteger x = 0; x < horizontalTileCount; x++)
    {
        NSMutableArray *yArray = [NSMutableArray arrayWithCapacity:verticalTileCount];
        [world.blockMatrix addObject:yArray];

        for (NSInteger y = 0; y < verticalTileCount; y++)
        {
            if (y < halfVerticalTileCount)
            {
                [yArray addObject:[NSNull null]];
            }
            else
            {
                USBlock *block = [USBlock insertInManagedObjectContext:context];
                block.world = world;
                block.xPosition = [NSNumber numberWithInt:x];
                block.yPosition = [NSNumber numberWithInt:y];

                // 1 in 20 chance of preciousness
                NSInteger stoneType = arc4random() % 20;
                block.isPreciousValue = (stoneType == 14);

                [yArray addObject:block];
            }
        }
    }

    return world;
}

- (void)didTurnIntoFault
{
    self.blockMatrix = nil;
    [super didTurnIntoFault];
}

- (USBlock *)blockAtPoint:(CGPoint)point
{
    return [[self.blockMatrix objectAtIndex:(NSInteger)point.x] objectAtIndex:(NSInteger)point.y];
}

- (NSDictionary *)blocksAroundCharacterPoint:(CGPoint)point
{
    //NSLog(@"Getting blocks around player point at %f, %f", point.x, point.y);

    point = CGPointMake((NSInteger) (point.x / TILESIZE), (NSInteger) (point.y / TILESIZE));

    //NSLog(@"player block point is %f, %f", point.x, point.y);

    NSMutableDictionary *returnDict = [[NSMutableDictionary alloc] initWithCapacity:6];
    [returnDict setObject:[self blockAtPoint:point]
                   forKey:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
    [returnDict setObject:[self blockAtPoint:CGPointMake(point.x + 1, point.y)]
                   forKey:[NSValue valueWithCGPoint:CGPointMake(1, 0)]];
    [returnDict setObject:[self blockAtPoint:CGPointMake(point.x, point.y + 1)]
                   forKey:[NSValue valueWithCGPoint:CGPointMake(0, 1)]];
    [returnDict setObject:[self blockAtPoint:CGPointMake(point.x + 1, point.y + 1)]
                   forKey:[NSValue valueWithCGPoint:CGPointMake(1, 1)]];
    [returnDict setObject:[self blockAtPoint:CGPointMake(point.x, point.y + 2)]
                   forKey:[NSValue valueWithCGPoint:CGPointMake(0, 2)]];
    [returnDict setObject:[self blockAtPoint:CGPointMake(point.x + 1, point.y + 2)]
                   forKey:[NSValue valueWithCGPoint:CGPointMake(1, 2)]];

    return returnDict;
}

// MUST CALL THESE METHODS TO UPDATE THE BLOCK MATRIX
- (void)us_addBlocksObject:(USBlock *)aBlock
{
    [[self.blockMatrix objectAtIndex:aBlock.xPositionValue] replaceObjectAtIndex:aBlock.yPositionValue withObject:aBlock];
    [self addBlocksObject:aBlock];
}

- (void)us_removeBlocksObject:(USBlock *)aBlock
{
    [[self.blockMatrix objectAtIndex:aBlock.xPositionValue] replaceObjectAtIndex:aBlock.yPositionValue withObject:[NSNull null]];
    [self removeBlocksObject:aBlock];
}

@end
