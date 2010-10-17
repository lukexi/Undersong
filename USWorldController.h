//
//  USWorldController.h
//  Undersong
//
//  Created by Luke Iannini on 10/16/10.
//  Copyright 2010 Hello, Chair Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USGlobals.h"
#import "USCharacterController.h"

@interface USWorldController : UIViewController
{
    USCharacterController *characterController;
}
@property (nonatomic, retain) IBOutlet USCharacterController *characterController;



@end
