//
//  USInventoryController.h
//  Undersong
//
//  Created by Luke Iannini on 10/17/10.
//  Copyright 2010 Hello, Chair Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USCharacterController.h"

@interface USInventoryController : UIViewController
{
    USCharacterController *characterController;
}

+ (USInventoryController *)inventoryControllerForCharacterController:(USCharacterController *)aCharacterController;

@property (nonatomic, retain) USCharacterController *characterController;

@end
