// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to USWorld.m instead.

#import "_USWorld.h"

@implementation USWorldID
@end

@implementation _USWorld

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"USWorld" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"USWorld";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"USWorld" inManagedObjectContext:moc_];
}

- (USWorldID*)objectID {
	return (USWorldID*)[super objectID];
}




@dynamic ySize;



- (int)ySizeValue {
	NSNumber *result = [self ySize];
	return [result intValue];
}

- (void)setYSizeValue:(int)value_ {
	[self setYSize:[NSNumber numberWithInt:value_]];
}

- (int)primitiveYSizeValue {
	NSNumber *result = [self primitiveYSize];
	return [result intValue];
}

- (void)setPrimitiveYSizeValue:(int)value_ {
	[self setPrimitiveYSize:[NSNumber numberWithInt:value_]];
}





@dynamic xSize;



- (int)xSizeValue {
	NSNumber *result = [self xSize];
	return [result intValue];
}

- (void)setXSizeValue:(int)value_ {
	[self setXSize:[NSNumber numberWithInt:value_]];
}

- (int)primitiveXSizeValue {
	NSNumber *result = [self primitiveXSize];
	return [result intValue];
}

- (void)setPrimitiveXSizeValue:(int)value_ {
	[self setPrimitiveXSize:[NSNumber numberWithInt:value_]];
}





@dynamic blocks;

	
- (NSMutableSet*)blocksSet {
	[self willAccessValueForKey:@"blocks"];
	NSMutableSet *result = [self mutableSetValueForKey:@"blocks"];
	[self didAccessValueForKey:@"blocks"];
	return result;
}
	

@dynamic characters;

	
- (NSMutableSet*)charactersSet {
	[self willAccessValueForKey:@"characters"];
	NSMutableSet *result = [self mutableSetValueForKey:@"characters"];
	[self didAccessValueForKey:@"characters"];
	return result;
}
	



@end
