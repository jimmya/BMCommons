//
//  BMEnumeratedValue.h
//  BMCommons
//
//  Created by Werner Altewischer on 2/15/11.
//  Copyright 2011 BehindMedia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Class used to map an xsd enumation value.
 */
@interface BMEnumerationValue : NSObject

+ (BMEnumerationValue *)enumerationValueWithValue:(id)theValue;

/**
 The underlying value.
 */
@property (nonatomic, strong) id value;

/**
 Returns a formatted value.
 */
- (NSString *)formattedValue;

/**
 Returns a string with the objective-C declaration of the underlying value, such as @"[NSNumber numberWithInt:1]" if value is an integer number 1.
 */
- (NSString *)valueDeclaration;

/**
 Returns a string with the Swift declaration of the underlying value, such as 1 if value is an integer number 1 or "somestring" in the case of a string.
 */
- (NSString *)swiftValueDeclaration;

@end

NS_ASSUME_NONNULL_END
