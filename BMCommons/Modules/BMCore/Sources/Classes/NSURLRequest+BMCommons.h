//
//  NSURLRequest+BMCommons.h
//  BMCommons
//
//  Created by Werner Altewischer on 16/02/15.
//  Copyright (c) 2015 BehindMedia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURLRequest (BMCommons)

- (void)bmSetTimeoutInterval:(NSTimeInterval)timeoutInterval;
- (void)bmSetCachePolicy:(NSURLRequestCachePolicy)cachePolicy;

//Use this in combination with the URL to determine uniqueness of a request.
//The digest is calculated from the HTTP method, URL, header fields and body.
- (NSString *)bmDigest;

/**
 Calculates a digest by including the specified header fields and optionally also includes the request body. 
 */
- (NSString *)bmDigestByIncludingHeaders:(nullable NSArray *)includeHeaders includeBody:(BOOL)includeBody;

/**
 Calculates a digest by using all the header fields exluding the specified headers and optionally also including the request body.
 */
- (NSString *)bmDigestByExcludingHeaders:(nullable NSArray *)excludeHeaders includeBody:(BOOL)includeBody;

/**
 Whether or not BMURLCaching based on the BMURLCachingProtocol is enabled for this request.
 */
- (BOOL)isBMURLCachingEnabled;

/**
 Whether or not handling by the BMURLCachingProtocol is enabled for this request.
 */
- (BOOL)isBMURLProtocolEnabled;

/**
 * Returns the raw description for the request including the method, url, headers and body.
 */
- (NSString *)bmRawDescription;

@end

@interface NSMutableURLRequest (BMCommons)

/**
 Enables/disables URL caching based on the BMURLCachingProtocol explicitly for this request, overriding the default behavior.
 */
- (void)setBMURLCachingEnabled:(BOOL)enabled;

/**
 * Enables/disables handling by the BMURLCachingProtocol explicitly for this request, overriding the default behavior.
 */
- (void)setBMURLProtocolEnabled:(BOOL)enabled;

@end

NS_ASSUME_NONNULL_END

