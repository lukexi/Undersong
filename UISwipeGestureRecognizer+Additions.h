//
//  UISwipeGestureRecognizer+Additions.h
//  Undersong
//
//  Created by Luke Iannini on 10/17/10.
//  Copyright 2010 Hello, Chair Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UISwipeGestureRecognizer (Additions)

+ (NSArray *)us_swipeGestureRecognizersForAllDirectionsWithTarget:(id)target action:(SEL)selector;

@end
