//
//  AppDelegate_Shared.m
//  Undersong
//
//  Created by Luke Iannini on 10/16/10.
//  Copyright 2010 Hello, Chair Inc. All rights reserved.
//

#import "AppDelegate_Shared.h"


@implementation AppDelegate_Shared

@synthesize window;
@synthesize worldController;



#pragma mark -
#pragma mark Application lifecycle

/**
 Save changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveContext];
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self saveContext];
}


- (void)saveContext
{
    NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = [USMainContext mainContext];
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.

             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc
{
    self.worldController = nil;

    [window release];
    [super dealloc];
}


@end

