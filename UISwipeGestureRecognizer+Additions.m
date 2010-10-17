//
//  UISwipeGestureRecognizer+Additions.m
//  Undersong
//
//  Created by Luke Iannini on 10/17/10.
//  Copyright 2010 Hello, Chair Inc. All rights reserved.
//

#import "UISwipeGestureRecognizer+Additions.h"


@implementation UISwipeGestureRecognizer (Additions)

+ (NSArray *)us_swipeGestureRecognizersForAllDirectionsWithTarget:(id)target action:(SEL)selector;
{
    NSMutableArray *recognizers = [NSMutableArray arrayWithCapacity:4];
    UISwipeGestureRecognizer *swipeRecognizer = nil;
    swipeRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:target
                                                                 action:selector] autorelease];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [recognizers addObject:swipeRecognizer];

    swipeRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:target
                                                                 action:selector] autorelease];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [recognizers addObject:swipeRecognizer];

    swipeRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:target
                                                                 action:selector] autorelease];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [recognizers addObject:swipeRecognizer];

    swipeRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:target
                                                                 action:selector] autorelease];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [recognizers addObject:swipeRecognizer];

    return [[recognizers copy] autorelease];
}

@end
