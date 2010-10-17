#import "_USBlock.h"

@class USWorldBlockView;

@interface USBlock : _USBlock {

    UIView *view;
    
}
// Custom logic goes here.
- (USWorldBlockView *) worldBlockView;
+ (USBlock *) blockAtPoint:(CGPoint)point;

@property (nonatomic, retain) IBOutlet UIView *view;

@end
