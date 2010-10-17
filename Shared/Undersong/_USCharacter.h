// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to USCharacter.h instead.

#import <CoreData/CoreData.h>


@class USInventoryEntry;
@class USWorld;



@interface USCharacterID : NSManagedObjectID {}
@end

@interface _USCharacter : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (USCharacterID*)objectID;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* inventoryEntries;
- (NSMutableSet*)inventoryEntriesSet;



@property (nonatomic, retain) USWorld* world;
//- (BOOL)validateWorld:(id*)value_ error:(NSError**)error_;



@end

@interface _USCharacter (CoreDataGeneratedAccessors)

- (void)addInventoryEntries:(NSSet*)value_;
- (void)removeInventoryEntries:(NSSet*)value_;
- (void)addInventoryEntriesObject:(USInventoryEntry*)value_;
- (void)removeInventoryEntriesObject:(USInventoryEntry*)value_;

@end

@interface _USCharacter (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSMutableSet*)primitiveInventoryEntries;
- (void)setPrimitiveInventoryEntries:(NSMutableSet*)value;



- (USWorld*)primitiveWorld;
- (void)setPrimitiveWorld:(USWorld*)value;


@end
