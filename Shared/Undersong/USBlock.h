#import "_USBlock.h"
#import "USCharacter.h"

@class USWorldBlockView;
@class USInventoryBlockView;

@interface USBlock : _USBlock {

    UIView *view;

}
// Custom logic goes here.
- (USWorldBlockView *) worldBlockView;
+ (USBlock *) blockAtPoint:(CGPoint)point;
- (USInventoryBlockView *)inventoryBlockView;

@property (nonatomic, retain) IBOutlet UIView *view;

- (void)moveToInventoryForCharacter:(USCharacter *)aCharacter;
- (void)moveToWorld;

@end
