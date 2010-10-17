// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to USInventory.m instead.

#import "_USInventory.h"

@implementation USInventoryID
@end

@implementation _USInventory

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"USInventory" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"USInventory";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"USInventory" inManagedObjectContext:moc_];
}

- (USInventoryID*)objectID {
	return (USInventoryID*)[super objectID];
}




@dynamic entries;

	
- (NSMutableSet*)entriesSet {
	[self willAccessValueForKey:@"entries"];
	NSMutableSet *result = [self mutableSetValueForKey:@"entries"];
	[self didAccessValueForKey:@"entries"];
	return result;
}
	



@end
