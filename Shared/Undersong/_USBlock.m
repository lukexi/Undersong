// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to USBlock.m instead.

#import "_USBlock.h"

@implementation USBlockID
@end

@implementation _USBlock

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"USBlock" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"USBlock";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"USBlock" inManagedObjectContext:moc_];
}

- (USBlockID*)objectID {
	return (USBlockID*)[super objectID];
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





@dynamic isPrecious;



- (BOOL)isPreciousValue {
	NSNumber *result = [self isPrecious];
	return [result boolValue];
}

- (void)setIsPreciousValue:(BOOL)value_ {
	[self setIsPrecious:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsPreciousValue {
	NSNumber *result = [self primitiveIsPrecious];
	return [result boolValue];
}

- (void)setPrimitiveIsPreciousValue:(BOOL)value_ {
	[self setPrimitiveIsPrecious:[NSNumber numberWithBool:value_]];
}





@dynamic inventoryEntry;

	

@dynamic world;

	



@end
