// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to USInventoryEntry.h instead.

#import <CoreData/CoreData.h>


@class USBlock;
@class USInventory;




@interface USInventoryEntryID : NSManagedObjectID {}
@end

@interface _USInventoryEntry : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (USInventoryEntryID*)objectID;



@property (nonatomic, retain) NSNumber *yPosition;

@property int yPositionValue;
- (int)yPositionValue;
- (void)setYPositionValue:(int)value_;

//- (BOOL)validateYPosition:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *xPosition;

@property int xPositionValue;
- (int)xPositionValue;
- (void)setXPositionValue:(int)value_;

//- (BOOL)validateXPosition:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) USBlock* block;
//- (BOOL)validateBlock:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) USInventory* inventory;
//- (BOOL)validateInventory:(id*)value_ error:(NSError**)error_;



@end

@interface _USInventoryEntry (CoreDataGeneratedAccessors)

@end

@interface _USInventoryEntry (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveYPosition;
- (void)setPrimitiveYPosition:(NSNumber*)value;

- (int)primitiveYPositionValue;
- (void)setPrimitiveYPositionValue:(int)value_;


- (NSNumber*)primitiveXPosition;
- (void)setPrimitiveXPosition:(NSNumber*)value;

- (int)primitiveXPositionValue;
- (void)setPrimitiveXPositionValue:(int)value_;




- (USBlock*)primitiveBlock;
- (void)setPrimitiveBlock:(USBlock*)value;



- (USInventory*)primitiveInventory;
- (void)setPrimitiveInventory:(USInventory*)value;


@end
