#import "_USBlock.h"

@class USWorldBlockView;
@class USInventoryBlockView;

@interface USBlock : _USBlock {

    UIView *view;

}
// Custom logic goes here.
- (USWorldBlockView *) worldBlockView;
+ (USBlock *) blockAtPoint:(CGPoint)point;
+ (NSDictionary *) blocksAroundCharacterPoint:(CGPoint)point;
- (USInventoryBlockView *)inventoryBlockView;

@property (nonatomic, retain) IBOutlet UIView *view;

@end
