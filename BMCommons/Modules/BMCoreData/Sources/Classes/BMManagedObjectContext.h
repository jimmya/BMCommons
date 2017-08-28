//
//  BMManagedObjectContext.h
//  BMCommons
//
//  Created by Werner Altewischer on 12/17/10.
//  Copyright 2010 BehindMedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <BMCommons/BMRootManagedObject.h>

NS_ASSUME_NONNULL_BEGIN

@class BMManagedObjectContext;

@protocol BMManagedObjectContextDelegate<NSObject>

@optional
- (void)managedObjectContext:(BMManagedObjectContext *)objectContext didInsertObject:(NSManagedObject *)object;
- (void)managedObjectContext:(BMManagedObjectContext *)objectContext didDeleteObject:(NSManagedObject *)object;
- (void)managedObjectContext:(BMManagedObjectContext *)objectContext didUpdateObject:(NSManagedObject *)object;
- (void)managedObjectContextDidSave:(BMManagedObjectContext *)objectContext;

@end

/**
 Extension of NSManagedObjectContext that adds support for delegates of object inserts, updates and deletes.
 */
@interface BMManagedObjectContext : NSManagedObjectContext 

- (void)addDelegate:(id <BMManagedObjectContextDelegate>)delegate;
- (void)removeDelegate:(id <BMManagedObjectContextDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END