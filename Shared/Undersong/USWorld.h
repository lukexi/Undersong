#import "_USWorld.h"

@interface USWorld : _USWorld {
    
    USBlock * **blocksMatrix;

}
// Custom logic goes here.

+ (USWorld *)worldWithSize:(CGSize)worldSize inManagedObjectContext:(NSManagedObjectContext *)context;
- (USBlock *) blockAtPoint:(CGPoint)point;
- (NSDictionary *) blocksAroundCharacterPoint:(CGPoint)point;

@property (nonatomic, assign) USBlock * **blocksMatrix;


@end
