//
//  RegexKitLite.h
//  http://regexkit.sourceforge.net/
//  Licensesd under the terms of the BSD License, as specified below.
//

/*
 Copyright (c) 2008, John Engelhart
 
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 * Neither the name of the Zang Industries nor the names of its
 contributors may be used to endorse or promote products derived from
 this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/ 

#ifdef __OBJC__

#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSRange.h>
#import <Foundation/NSString.h>

#endif // __OBJC__

#include <limits.h>
#include <sys/types.h>

#ifdef __cplusplus
extern "C" {
#endif

// For Mac OS X < 10.5.
#ifndef NSINTEGER_DEFINED
#define NSINTEGER_DEFINED
#ifdef __LP64__ || NS_BUILD_32_LIKE_64
typedef long           NSInteger;
typedef unsigned long  NSUInteger;
#define NSIntegerMin   LONG_MIN
#define NSIntegerMax   LONG_MAX
#define NSUIntegerMax  ULONG_MAX
#else
typedef int            NSInteger;
typedef unsigned int   NSUInteger;
#define NSIntegerMin   INT_MIN
#define NSIntegerMax   INT_MAX
#define NSUIntegerMax  UINT_MAX
#endif
#endif // NSINTEGER_DEFINED

#ifndef _REGEXKITLITE_H_
#define _REGEXKITLITE_H_

#ifdef __OBJC__

NS_ASSUME_NONNULL_BEGIN

@class NSError;

// NSError error domains and user info keys.
extern NSString * const BMRegexErrorDomain;

extern NSString * const BMRegexErrorNameErrorKey;
extern NSString * const BMRegexLineErrorKey;
extern NSString * const BMRegexOffsetErrorKey;
extern NSString * const BMRegexPreContextErrorKey;
extern NSString * const BMRegexPostContextErrorKey;
extern NSString * const BMRegexRegexErrorKey;
extern NSString * const BMRegexOptionsErrorKey;

/**
 * Regular expression options, identical to their icu counterparts.
 */
typedef NS_OPTIONS(NSUInteger, BMRegexOptions) {
    BMRegexNoOptions             = 0,
    BMRegexCaseless              = 2,
    BMRegexComments              = 4,
    BMRegexDotAll                = 32,
    BMRegexMultiline             = 8,
    BMRegexUnicodeWordBoundaries = 256
};

/**
 * Extensions for performing regex operation on NSString
 */
@interface NSString (BMRegex)

/**
 * Clears the cache.
 */
+ (void)clearStringCache;

/**
 * Returns the capture count for the specified regex expression.
 *
 * Returns -1 in case of error.
 */
+ (NSInteger)captureCountForRegex:(NSString *)regexString;

/**
 * Returns the capture count for the specified regex expression, with options and error in case something went wrong.
 *
 * Returns -1 in case of error.
 *
 * @param regexString The regular expression
 * @param options The options to use for matching
 * @param error Optional error to inspect the error in case something went wrong
 * @return The capture count or -1 in case of error.
 */
+ (NSInteger)captureCountForRegex:(NSString *)regexString options:(BMRegexOptions)options error:(NSError * _Nullable * _Nullable)error;

/**
 * Whether or not the receiver is matches by the specified regex expression.
 *
 * @param regexString The regular expression
 * @return true if matched, false otherwise.
 */
- (BOOL)isMatchedByRegex:(NSString *)regexString;

/**
 * Whether or not the receiver is matches by the specified regex expression.
 *
 * @param regexString The regular expression
 * @param options The options to use for matching
 * @param range The range to use
 * @param error Optional error to inspect the error in case something went wrong
 * @return The capture count or -1 in case of error.
 */
- (BOOL)isMatchedByRegex:(NSString *)regexString options:(BMRegexOptions)options inRange:(NSRange)range error:(NSError * _Nullable * _Nullable)error;

- (NSRange)rangeOfRegex:(NSString *)regexString;
- (NSRange)rangeOfRegex:(NSString *)regexString capture:(NSInteger)capture;
- (NSRange)rangeOfRegex:(NSString *)regexString inRange:(NSRange)range;

/**
 * The range of the regular expression if matched.
 *
 * @param regexString The regular expression to match
 * @param options The options to use
 * @param range the range to search in
 * @param capture The index of the capture group
 * @param error The optional error to inspect the error in case something went wrong.
 * @return The matched range. Returns NSNotFound as location in case no match was found.
 */
- (NSRange)rangeOfRegex:(NSString *)regexString options:(BMRegexOptions)options inRange:(NSRange)range capture:(NSInteger)capture error:(NSError * _Nullable * _Nullable)error;

- (nullable NSString *)stringByMatching:(NSString *)regexString;
- (nullable NSString *)stringByMatching:(NSString *)regexString capture:(NSInteger)capture;
- (nullable NSString *)stringByMatching:(NSString *)regexString inRange:(NSRange)range;

/**
 * Returns the matches string for the specified regex.
 *
 * @param regexString the regular expression
 * @param options the options to use
 * @param range the range to search in
 * @param capture the index of the capture group
 * @param error The optional error to inspect the error in case something went wrong.
 * @return The matched string or nil if no match was found.
 */
- (nullable NSString *)stringByMatching:(NSString *)regexString options:(BMRegexOptions)options inRange:(NSRange)range capture:(NSInteger)capture error:(NSError * _Nullable * _Nullable)error;

@end

NS_ASSUME_NONNULL_END

#endif // _REGEXKITLITE_H_

#endif // __OBJC__

#ifdef __cplusplus
}  // extern "C"
#endif

