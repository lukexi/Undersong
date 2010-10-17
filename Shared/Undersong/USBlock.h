#import "_USBlock.h"

@class USWorldBlockView;
@class USInventoryBlockView;

@interface USBlock : _USBlock {

    UIView *view;

}
// Custom logic goes here.
- (USWorldBlockView *)worldBlockView;
- (USInventoryBlockView *)inventoryBlockView;
+ (USBlock *)blockAtPoint:(CGPoint)point;

@property (nonatomic, retain) IBOutlet UIView *view;

@end
