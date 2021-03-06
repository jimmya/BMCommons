//
//  BMEnumeratedValueToStringTransformer.m
//  BMCommons
//
//  Created by Werner Altewischer on 5/24/11.
//  Copyright 2011 BehindMedia. All rights reserved.
//

#import <BMCommons/BMEnumeratedValueToStringTransformer.h>
#import <BMCommons/BMStringHelper.h>
#import <BMCommons/BMEnumeratedValue.h>
#import <BMCommons/BMInputValueType.h>

@implementation BMEnumeratedValueToStringTransformer

+ (Class)transformedValueClass {
	return [NSString class];
}

+ (BOOL)allowsReverseTransformation {
	return NO;
}

- (id)transformedValue:(id)value {
	BMEnumeratedValue *ev = value;
	NSString *s = nil;
	if ([BMStringHelper isEmpty:ev.label]) {
		//Convert the value back to string
		BMInputValueType *valueType = ev.valueType;
		if (valueType.valueTransformer) {
			s = [valueType.valueTransformer reverseTransformedValue:ev.value];	
		} else {
			s = [ev.value description];
		}
	} else {
		s = ev.label;
	}
	return s;
}

@end
