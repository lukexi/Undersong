//
//  USBlock.h
//  Undersong
//
//  Created by Luke Iannini on 10/16/10.
//  Copyright 2010 Hello, Chair Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USBlock.h"

@interface USBlockView : UIView
{
    USBlock *block;
}

@property (nonatomic, retain) USBlock *block;

@end