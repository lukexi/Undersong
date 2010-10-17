#import "USWorld.h"
#import "USCharacter.h"
#import "USGlobals.h"
#import "USBlock.h"

@implementation USWorld

// Custom logic goes here.

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    [self addCharactersObject:[USCharacter insertInManagedObjectContext:[self managedObjectContext]]];
}

+ (USWorld *)worldWithSize:(CGSize)worldSize inManagedObjectContext:(NSManagedObjectContext *)context
{
    USWorld *world = [USWorld insertInManagedObjectContext:context];

    NSInteger horizontalTileCount = round(worldSize.width / TILESIZE) + 1;
    NSInteger verticalTileCount = round(worldSize.height / TILESIZE) + 1;

    world.xSize = [NSNumber numberWithInt:horizontalTileCount];
    world.ySize = [NSNumber numberWithInt:verticalTileCount];

    for (NSInteger x = 0; x < horizontalTileCount; x++)
    {
        for (NSInteger y = 20; y < verticalTileCount; y++)
        {
            USBlock *block = [USBlock insertInManagedObjectContext:context];
            block.world = world;
            block.xPosition = [NSNumber numberWithInt:x];
            block.yPosition = [NSNumber numberWithInt:y];
        }
    }
    
    return world;
}

@end
