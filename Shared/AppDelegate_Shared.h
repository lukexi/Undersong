//
//  AppDelegate_Shared.h
//  Undersong
//
//  Created by Luke Iannini on 10/16/10.
//  Copyright 2010 Hello, Chair Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USMainContext.h"
#import "USWorldController.h"

@interface AppDelegate_Shared : NSObject <UIApplicationDelegate>
{
    UIWindow *window;

    USWorldController *worldController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet USWorldController *worldController;

- (void)saveContext;

@end

