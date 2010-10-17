// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to USBlock.h instead.

#import <CoreData/CoreData.h>


@class USInventoryEntry;
@class USWorld;





@interface USBlockID : NSManagedObjectID {}
@end

@interface _USBlock : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (USBlockID*)objectID;



@property (nonatomic, retain) NSNumber *xPosition;

@property int xPositionValue;
- (int)xPositionValue;
- (void)setXPositionValue:(int)value_;

//- (BOOL)validateXPosition:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *yPosition;

@property int yPositionValue;
- (int)yPositionValue;
- (void)setYPositionValue:(int)value_;

//- (BOOL)validateYPosition:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *isPrecious;

@property BOOL isPreciousValue;
- (BOOL)isPreciousValue;
- (void)setIsPreciousValue:(BOOL)value_;

//- (BOOL)validateIsPrecious:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) USInventoryEntry* inventoryEntry;
//- (BOOL)validateInventoryEntry:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) USWorld* world;
//- (BOOL)validateWorld:(id*)value_ error:(NSError**)error_;



@end

@interface _USBlock (CoreDataGeneratedAccessors)

@end

@interface _USBlock (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveXPosition;
- (void)setPrimitiveXPosition:(NSNumber*)value;

- (int)primitiveXPositionValue;
- (void)setPrimitiveXPositionValue:(int)value_;


- (NSNumber*)primitiveYPosition;
- (void)setPrimitiveYPosition:(NSNumber*)value;

- (int)primitiveYPositionValue;
- (void)setPrimitiveYPositionValue:(int)value_;


- (NSNumber*)primitiveIsPrecious;
- (void)setPrimitiveIsPrecious:(NSNumber*)value;

- (BOOL)primitiveIsPreciousValue;
- (void)setPrimitiveIsPreciousValue:(BOOL)value_;




- (USInventoryEntry*)primitiveInventoryEntry;
- (void)setPrimitiveInventoryEntry:(USInventoryEntry*)value;



- (USWorld*)primitiveWorld;
- (void)setPrimitiveWorld:(USWorld*)value;


@end
