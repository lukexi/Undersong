// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to USInventory.h instead.

#import <CoreData/CoreData.h>


@class USInventoryEntry;


@interface USInventoryID : NSManagedObjectID {}
@end

@interface _USInventory : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (USInventoryID*)objectID;




@property (nonatomic, retain) NSSet* entries;
- (NSMutableSet*)entriesSet;



@end

@interface _USInventory (CoreDataGeneratedAccessors)

- (void)addEntries:(NSSet*)value_;
- (void)removeEntries:(NSSet*)value_;
- (void)addEntriesObject:(USInventoryEntry*)value_;
- (void)removeEntriesObject:(USInventoryEntry*)value_;

@end

@interface _USInventory (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveEntries;
- (void)setPrimitiveEntries:(NSMutableSet*)value;


@end
