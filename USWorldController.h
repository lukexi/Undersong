//
//  USWorldController.h
//  Undersong
//
//  Created by Luke Iannini on 10/16/10.
//  Copyright 2010 Hello, Chair Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USWorld.h"

#define TILESIZE 20
#define ARC4RANDOM_MAX 0x100000000

@interface USWorldController : UIViewController
{
    USWorld *world;
}

@property (nonatomic, retain) USWorld *world;

@end
