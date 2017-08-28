//
//  BMKeyedArchiveDataTransformer.h
//  BMCommons
//
//  Created by Werner Altewischer on 22/10/14.
//  Copyright (c) 2014 BehindMedia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Value transformer which transforms an object implementing the NSCoding protocol to NSData (forward) and back (reverse) using a NSKeyedArchiver.
 */
@interface BMKeyedArchiveDataTransformer : NSValueTransformer

@end

NS_ASSUME_NONNULL_END