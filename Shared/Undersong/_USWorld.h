// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to USWorld.h instead.

#import <CoreData/CoreData.h>


@class USBlock;




@interface USWorldID : NSManagedObjectID {}
@end

@interface _USWorld : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (USWorldID*)objectID;



@property (nonatomic, retain) NSNumber *ySize;

@property int ySizeValue;
- (int)ySizeValue;
- (void)setYSizeValue:(int)value_;

//- (BOOL)validateYSize:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *xSize;

@property int xSizeValue;
- (int)xSizeValue;
- (void)setXSizeValue:(int)value_;

//- (BOOL)validateXSize:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* blocks;
- (NSMutableSet*)blocksSet;



@end

@interface _USWorld (CoreDataGeneratedAccessors)

- (void)addBlocks:(NSSet*)value_;
- (void)removeBlocks:(NSSet*)value_;
- (void)addBlocksObject:(USBlock*)value_;
- (void)removeBlocksObject:(USBlock*)value_;

@end

@interface _USWorld (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveYSize;
- (void)setPrimitiveYSize:(NSNumber*)value;

- (int)primitiveYSizeValue;
- (void)setPrimitiveYSizeValue:(int)value_;


- (NSNumber*)primitiveXSize;
- (void)setPrimitiveXSize:(NSNumber*)value;

- (int)primitiveXSizeValue;
- (void)setPrimitiveXSizeValue:(int)value_;




- (NSMutableSet*)primitiveBlocks;
- (void)setPrimitiveBlocks:(NSMutableSet*)value;


@end
