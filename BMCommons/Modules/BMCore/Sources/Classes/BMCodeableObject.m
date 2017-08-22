//
//  BMCodeableObject.m
//  BMCommons
//
//  Created by Werner Altewischer on 22/10/14.
//  Copyright (c) 2014 BehindMedia. All rights reserved.
//

#import <BMCommons/BMCodeableObject.h>
#import <BMCommons/BMCodingHelper.h>
#import "NSObject+BMCommons.h"

@implementation BMCodeableObject

+ (NSArray *)descriptorsForCodeableProperties {
    return @[];
}

- (id)initWithCoder:(NSCoder *)coder {
    if ((self = [self init])) {
        [BMCodingHelper decodePropertiesFromDescriptors:[[self class] descriptorsForCodeableProperties] withCoder:coder forTarget:self];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [BMCodingHelper encodePropertiesFromDescriptors:[[self class] descriptorsForCodeableProperties] withCoder:coder forTarget:self];
}

- (NSData *)archivedData {
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}

+ (instancetype)objectFromArchivedData:(NSData *)data {
    return [[NSKeyedUnarchiver unarchiveObjectWithData:data] bmCastSafely:self];
}

@end
