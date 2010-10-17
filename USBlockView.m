//
//  USBlock.m
//  Undersong
//
//  Created by Luke Iannini on 10/16/10.
//  Copyright 2010 Hello, Chair Inc. All rights reserved.
//

#import "USBlockView.h"
#import "USGlobals.h"
#import <QuartzCore/QuartzCore.h>

#define USPreciousColor [UIColor colorWithRed:0.206 green:1.000 blue:1.000 alpha:1.000]

float USRandomFloat(void)
{
    return (double)arc4random() / ARC4RANDOM_MAX;
}

@implementation USBlockView
@synthesize isPrecious;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithHue:USRandomFloat()
                                          saturation:0.5
                                          brightness:0.5
                                               alpha:1];
    }
    return self;
}

- (void)setIsPrecious:(BOOL)flag
{
    isPrecious = flag;
    if (isPrecious)
    {
        [self setNeedsDisplay];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if (isPrecious)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [USPreciousColor set];
        CGContextSetLineWidth(context, 2);
        CGRect pathRect = CGRectInset(self.bounds, 2, 2);
        [[UIBezierPath bezierPathWithRoundedRect:pathRect cornerRadius:3] stroke];
    }
}


- (void)dealloc
{
    [super dealloc];
}


@end
