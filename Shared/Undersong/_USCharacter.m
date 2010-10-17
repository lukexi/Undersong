// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to USCharacter.m instead.

#import "_USCharacter.h"

@implementation USCharacterID
@end

@implementation _USCharacter

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"USCharacter" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"USCharacter";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"USCharacter" inManagedObjectContext:moc_];
}

- (USCharacterID*)objectID {
	return (USCharacterID*)[super objectID];
}




@dynamic name;






@dynamic inventoryEntries;

	
- (NSMutableSet*)inventoryEntriesSet {
	[self willAccessValueForKey:@"inventoryEntries"];
	NSMutableSet *result = [self mutableSetValueForKey:@"inventoryEntries"];
	[self didAccessValueForKey:@"inventoryEntries"];
	return result;
}
	

@dynamic world;

	



@end
