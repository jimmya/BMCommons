//
//  BMCoreDataApplicationContext.h
//  BMCommons
//
//  Created by Werner Altewischer on 7/13/13.
//  Copyright (c) 2013 BehindMedia. All rights reserved.
//

#import <BMCommons/BMApplicationContext.h>
#import <BMCommons/BMCoreDataStack.h>
#import <BMCommons/BMCoreDataStoreCollectionDescriptor.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMCoreDataApplicationContext : BMApplicationContext

/**
 BMCoreDataStack instance for accessing CoreData. Is nil if core data is not used.
 */
@property(nullable, nonatomic, readonly) BMCoreDataStack *coreDataStack;

/**
 Returns the current datastore collection descriptor if present. The desciptor is a file with extension scd in the documents directory of the app and describes the
 current version of the datamodel that is used.
 */
- (nullable BMCoreDataStoreCollectionDescriptor *)currentDataStoreCollectionDescriptor;

/**
 In case of one coredata model, implement this method to return the name of the model.
 */
- (nullable NSString *)coreDataModelName;

/**
 In case of multiple coredata models, implement this method to return the names of the models. Don't implement coreDataModelName in that case. The count of the
 returned array should match the count of the returned array from coreDataModelVersions.
 */
- (nullable NSArray *)coreDataModelNames;

/**
 In case of one coredata model, implement this method to return the version of the model.
 */
- (NSInteger)coreDataModelVersion;

/**
 In case of multiple coredata models, implement this method to return the versions of the models. Don't implement coreDataModelVersion in that case. The count of
 the returned array should match the count of the returned array from coreDataModelNames.
 */
- (nullable NSArray *)coreDataModelVersions;

/**
 Implement this method if you have one model with multiple configurations. Return the names of the configurations. In the case there are multiple models and mutiple
 configurations implement the more generic dataStoreCollectionDescriptor method instead.
 */
- (nullable NSArray *)coreDataModelConfigurations;

/**
 Returns a descriptor for the core data model(s), version(s) and configuration(s) used by the application. This is the most generic method, for simple cases
 implement any of the above methods.
 */
- (nullable BMCoreDataStoreCollectionDescriptor *)dataStoreCollectionDescriptor;

@end

NS_ASSUME_NONNULL_END
