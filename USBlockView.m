//
//  USBlock.m
//  Undersong
//
//  Created by Luke Iannini on 10/16/10.
//  Copyright 2010 Hello, Chair Inc. All rights reserved.
//

#import "USBlockView.h"


@implementation USBlockView
@synthesize block;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code.
        UITapGestureRecognizer *breakGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(breakAction:)] autorelease];

        self.gestureRecognizers = [NSArray arrayWithObject:breakGesture];
    }
    return self;
}

- (void)breakAction:(UIGestureRecognizer*)gestureRecognizer
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self.superview bringSubviewToFront:self];
                         self.alpha = 0.0;
                         self.transform = CGAffineTransformMakeScale(2, 2);
                     }
                     completion:^(BOOL finished){

                         NSManagedObjectContext *context = [self.block managedObjectContext];
                         [context deleteObject:self.block];
                         NSError *error = nil;
                         [context save:&error];

                         [self removeFromSuperview];
                     }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc
{
    self.block = nil;
    [super dealloc];
}


@end
