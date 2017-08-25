/*
     File: KeychainItemWrapper.h
 Abstract: 
 Objective-C wrapper for accessing a single keychain item.
 
  Version: 1.2
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2010 Apple Inc. All Rights Reserved.
 
*/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
    The KeychainItemWrapper class is an abstraction layer for the iPhone Keychain communication. 
 
    This is merely a simple wrapper to provide a distinct barrier between all the idiosyncracies involved with the Keychain
    CF/NS container objects.
*/
@interface BMKeychainItemWrapper : NSObject

/**
 Value transformer for converting the value data.
 
 The forward transformation should be to NSData and the value transformer should support reverse transformation.
 By default the value is transformed to a NSString using UTF8 encoding.

 If set to nil the NSData from the keychain is not transformed.
 */
@property (nullable, nonatomic, readonly) NSValueTransformer *valueDataTransformer;

/**
 Designated initializer.
 
 Initializes with the supplied identifier and optional accessGroup (in case more than one application from the same company share the same keychain, see Apple documentation for more info).
 */
- (id)initWithIdentifier: (NSString *)identifier accessGroup:(nullable NSString *) accessGroup;
- (id)initWithIdentifier: (NSString *)identifier accessGroup:(nullable NSString *) accessGroup valueDataTransformer:(nullable NSValueTransformer *)transformer NS_DESIGNATED_INITIALIZER;

/**
 Sets the object for the specified key and flushes immediately.
 */
- (void)setObject:(id)inObject forKey:(id)key;

/**
 Sets the object for the specified key and optionally flushes immediately.
 */
- (void)setObject:(id)inObject forKey:(id)key flush:(BOOL)flush;

/**
 Sets the object and keys that exist in the specified dictionary (leaves other keys untouched).
 Flushes immediately.
 */
- (void)setObjectAndKeysFromDictionary:(NSDictionary *)dictionary;

/**
 Returns the object for the specified key.
 */
- (nullable id)objectForKey:(id)key;

/** 
 Initializes and resets the default generic keychain item data.
 
 */
- (void)resetKeychainItem;

/**
 Flushes the keychain.
 */
- (void)flush;

@end

NS_ASSUME_NONNULL_END
