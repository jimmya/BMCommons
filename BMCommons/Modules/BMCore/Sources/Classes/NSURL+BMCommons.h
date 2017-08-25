//
//  NSURL+BMCommons.h
//  BMCommons
//
//  Created by Werner Altewischer on 3/6/14.
//  Copyright (c) 2014 BehindMedia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (BMCommons)

/**
 * Returns a new URL by just appending the specified parameters.
 *
 * Does not look at the existing parameters, will just append even if they already exist.
 * Also look at the improved version of this method: [NSURL bmURLByUpdatingQueryParams:]
 */
- (nullable NSURL *)bmURLByAppendingQueryParams:(NSDictionary *)queryParams;

/**
 * Returns a new URL with the specified query parameters set.
 *
 * Any existing parameters are removed.
 */
- (nullable NSURL *)bmURLWithQueryParams:(NSDictionary *)parameterDict;

/**
 * Returns a new URL where the specified query parameters are added or updated if already existent.
 * Existing query parameters that are not in the specified parameter dictionary are just copied.
 * If [NSNull null] is specified as value for a parameter, that parameter is removed.
 */
- (nullable NSURL *)bmURLByUpdatingQueryParams:(NSDictionary *)queryParams;

/**
 * Returns a new URL by removing the parameters with the specified names.
 */
- (nullable NSURL *)bmURLByRemovingQueryParams:(NSArray *)queryParamNames;

/**
 * Returns a new URL by removing all query parameters.
 */
- (nullable NSURL *)bmURLByRemovingQuery;

@end

NS_ASSUME_NONNULL_END
