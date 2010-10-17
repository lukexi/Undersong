// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to USInventoryEntry.m instead.

#import "_USInventoryEntry.h"

@implementation USInventoryEntryID
@end

@implementation _USInventoryEntry

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"USInventoryEntry" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"USInventoryEntry";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"USInventoryEntry" inManagedObjectContext:moc_];
}

- (USInventoryEntryID*)objectID {
	return (USInventoryEntryID*)[super objectID];
}




@dynamic yPosition;



- (int)yPositionValue {
	NSNumber *result = [self yPosition];
	return [result intValue];
}

- (void)setYPositionValue:(int)value_ {
	[self setYPosition:[NSNumber numberWithInt:value_]];
}

- (int)primitiveYPositionValue {
	NSNumber *result = [self primitiveYPosition];
	return [result intValue];
}

- (void)setPrimitiveYPositionValue:(int)value_ {
	[self setPrimitiveYPosition:[NSNumber numberWithInt:value_]];
}





@dynamic xPosition;



- (int)xPositionValue {
	NSNumber *result = [self xPosition];
	return [result intValue];
}

- (void)setXPositionValue:(int)value_ {
	[self setXPosition:[NSNumber numberWithInt:value_]];
}

- (int)primitiveXPositionValue {
	NSNumber *result = [self primitiveXPosition];
	return [result intValue];
}

- (void)setPrimitiveXPositionValue:(int)value_ {
	[self setPrimitiveXPosition:[NSNumber numberWithInt:value_]];
}





@dynamic block;

	

@dynamic inventory;

	



@end
