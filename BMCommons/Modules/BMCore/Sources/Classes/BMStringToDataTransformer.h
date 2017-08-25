//
//  BMStringToDataTransformer.h
//  BMCommons
//
//  Created by Werner Altewischer on 12/31/12.
//  Copyright (c) 2012 BehindMedia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Converts an NSString to its data representation and vice versa.
 
 Uses the encoding specified.
 */
@interface BMStringToDataTransformer : NSValueTransformer

/**
 The string encoding to use.
 
 Defaults to NSUTF8StringEncoding.
 */
@property (nonatomic, assign) NSStringEncoding encoding;

@end

NS_ASSUME_NONNULL_END
