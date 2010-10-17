#import "USWorld.h"
#import "USCharacter.h"
#import "USGlobals.h"
#import "USBlock.h"

@implementation USWorld
@synthesize blocksMatrix;

// Custom logic goes here.

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    [self addCharactersObject:[USCharacter insertInManagedObjectContext:[self managedObjectContext]]];
}

- (void)awakeFromFetch
{
    
}

+ (USWorld *)worldWithSize:(CGSize)worldSize inManagedObjectContext:(NSManagedObjectContext *)context
{
    USWorld *world = [USWorld insertInManagedObjectContext:context];
    
    NSInteger horizontalTileCount = round(worldSize.width / TILESIZE) + 1;
    NSInteger verticalTileCount = round(worldSize.height / TILESIZE) + 1;
    NSInteger halfVerticalTileCount = round(verticalTileCount / 2);
    
    world.xSize = [NSNumber numberWithInt:horizontalTileCount];
    world.ySize = [NSNumber numberWithInt:verticalTileCount];

    world.blocksMatrix = (USBlock * **)malloc(horizontalTileCount * sizeof(USBlock * **));
    for (NSInteger x = 0; x < horizontalTileCount; x++ )
    {
        world.blocksMatrix[x] = (USBlock * *) malloc(verticalTileCount * sizeof(USBlock * *));
        for (NSInteger y = 0; y < verticalTileCount; y++)
        {
            if (y < halfVerticalTileCount)
            {
                world.blocksMatrix[x][y] = NULL;
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
                
                world.blocksMatrix[x][y] = block;
            }
        }
    }

//    NSInteger horizontalTileCount = round(worldSize.width / TILESIZE) + 1;
//    NSInteger verticalTileCount = round(worldSize.height / TILESIZE) + 1;
//    NSInteger halfVerticalTileCount = round(verticalTileCount / 2);
//
//    world.xSize = [NSNumber numberWithInt:horizontalTileCount];
//    world.ySize = [NSNumber numberWithInt:verticalTileCount];
//
//    for (NSInteger x = 0; x < horizontalTileCount; x++)
//    {
//        for (NSInteger y = halfVerticalTileCount; y < verticalTileCount; y++)
//        {
//            USBlock *block = [USBlock insertInManagedObjectContext:context];
//            block.world = world;
//            block.xPosition = [NSNumber numberWithInt:x];
//            block.yPosition = [NSNumber numberWithInt:y];
//
//            // 1 in 20 chance of preciousness
//            NSInteger stoneType = arc4random() % 20;
//            block.isPreciousValue = (stoneType == 14);
    //        }
//    }
    
    return world;
}

- (USBlock *)blockAtPoint:(CGPoint)point
{
    //NSLog(@"getting block point %f, %f", point.x, point.y);
    
//    NSManagedObjectContext *context = [USMainContext mainContext];
//    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
//    [request setEntity:[USBlock entityInManagedObjectContext:context]];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"xPosition == %i AND yPosition == %i AND world != NULL",
//                              (NSInteger)point.x, (NSInteger)point.y];
//    [request setPredicate:predicate];
//    
//    NSError *error = nil;
//    NSArray *results = [context executeFetchRequest:request error:&error];
//    
//    if ([results count])
//    {
//        //NSLog(@"GOT A BLOCK");
//        return [results lastObject];
//    }
//    else
//    {
//        return nil;
//    }
    
    return self.blocksMatrix[(NSInteger)point.x][(NSInteger)point.y];
}

- (NSDictionary *) blocksAroundCharacterPoint:(CGPoint)point
{
    //NSLog(@"Getting blocks around player point at %f, %f", point.x, point.y);
    
    point = CGPointMake((NSInteger) (point.x / TILESIZE), (NSInteger) (point.y / TILESIZE));
    
    //NSLog(@"player block point is %f, %f", point.x, point.y);
    
    NSMutableDictionary *returnDict = [[NSMutableDictionary alloc] initWithCapacity:6];
    
    USBlock *block = [self blockAtPoint:point];
    [returnDict setObject:(block ? block : (USBlock *)[NSNull null]) forKey: [NSValue valueWithCGPoint:CGPointMake(0, 0)]];
    block = [self blockAtPoint:CGPointMake(point.x + 1, point.y)];
    [returnDict setObject:(block ? block : (USBlock *)[NSNull null]) forKey: [NSValue valueWithCGPoint:CGPointMake(1, 0)]];
    block = [self blockAtPoint:CGPointMake(point.x, point.y + 1)];
    [returnDict setObject:(block ? block : (USBlock *)[NSNull null]) forKey: [NSValue valueWithCGPoint:CGPointMake(0, 1)]];
    block = [self blockAtPoint:CGPointMake(point.x + 1, point.y + 1)];
    [returnDict setObject:(block ? block : (USBlock *)[NSNull null]) forKey: [NSValue valueWithCGPoint:CGPointMake(1, 1)]];
    block = [self blockAtPoint:CGPointMake(point.x, point.y + 2)];
    [returnDict setObject:(block ? block : (USBlock *)[NSNull null]) forKey: [NSValue valueWithCGPoint:CGPointMake(0, 2)]];
    block = [self blockAtPoint:CGPointMake(point.x + 1, point.y + 2)];
    [returnDict setObject:(block ? block : (USBlock *)[NSNull null]) forKey: [NSValue valueWithCGPoint:CGPointMake(1, 2)]];
    
    return returnDict;
}


- (void)dealloc
{
//    for (NSInteger x = 0; x < self.xSizeValue; x++ )
//    {
//        free(self.blocksMatrix[x]);
//    }
//    free(self.blocksMatrix);
    
    [super dealloc];
}

@end
