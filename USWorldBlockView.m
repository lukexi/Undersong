//
//  USWorldBlockView.m
//  Undersong
//
//  Created by Michael Rotondo on 10/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "USWorldBlockView.h"


@implementation USWorldBlockView


- (id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)breakAction
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self.superview bringSubviewToFront:self];
                         self.alpha = 0.0;
                         self.transform = CGAffineTransformMakeScale(2, 2);
                     }
                     completion:^(BOOL finished){

                         [self removeFromSuperview];
                     }];
}

- (void)collectAction
{
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished){
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

- (void)dealloc {
    [super dealloc];
}


@end
