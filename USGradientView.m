//
//  USGradientView.m
//  Undersong
//
//  Created by Luke Iannini on 10/17/10.
//  Copyright 2010 Hello, Chair Inc. All rights reserved.
//

#import "USGradientView.h"
#import <QuartzCore/QuartzCore.h>

@implementation USGradientView

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

@end
