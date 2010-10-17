//
//  USInventoryBlockView.h
//  Undersong
//
//  Created by Michael Rotondo on 10/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USBlockView.h"
#import "USBlock.h"

@interface USInventoryBlockView : USBlockView {
    USBlock *block;
}

@property (nonatomic, retain) USBlock *block;

@end
