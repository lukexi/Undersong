#import "_USWorld.h"

@interface USWorld : _USWorld {}
// Custom logic goes here.

+ (USWorld *)worldWithSize:(CGSize)worldSize inManagedObjectContext:(NSManagedObjectContext *)context;

@end
