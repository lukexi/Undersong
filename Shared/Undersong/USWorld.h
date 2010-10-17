#import "_USWorld.h"

@interface USWorld : _USWorld
{
    NSMutableArray *blockMatrix;
}
// Custom logic goes here.

+ (USWorld *)worldWithSize:(CGSize)worldSize inManagedObjectContext:(NSManagedObjectContext *)context;

@property (nonatomic, retain) NSMutableArray *blockMatrix;

- (USBlock *)blockAtPoint:(CGPoint)point;
- (NSDictionary *)blocksAroundCharacterPoint:(CGPoint)point;

@end
