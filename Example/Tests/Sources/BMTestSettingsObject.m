//
//  BMTestSettingsObject.m
//  BMCommons
//
//  Created by Werner Altewischer on 20/10/14.
//  Copyright (c) 2014 BehindMedia. All rights reserved.
//

#import "BMTestSettingsObject.h"
#import <BMCommons/BMSettingsPropertyDescriptor.h>

#define AH_SETTINGS_MYLIST_SORT_ORDER_STATE	@"AHMyListStoreOrderState"
#define AH_SETTINGS_SYNCHING_ENABLED			@"AHSynchingEnabled"
#define AH_SETTINGS_MIJNAH_EMAIL				@"AHMijnAHEmail"
#define AH_SETTINGS_STORE_FOR_MY_LIST_ORDER		@"AHStoreForMyListOrder"
#define AH_SETTINGS_STORE_FOR_PRODUCT_FINDER	@"AHStoreForProductFinder"


@interface BMTestSettingsObject()

@end

@implementation BMTestSettingsObject

+ (NSArray *)keysArray {
    return @[AH_SETTINGS_MIJNAH_EMAIL, AH_SETTINGS_MYLIST_SORT_ORDER_STATE, AH_SETTINGS_SYNCHING_ENABLED];
}

+ (NSArray *)settingsPropertiesDescriptorsArray {
    return @[
             [BMSettingsPropertyDescriptor propertyDescriptorFromKeyPath:@"mijnAHEmailAddress" valueType:BMValueTypeObject defaultValue:@"test@mail.com" keyName:AH_SETTINGS_MIJNAH_EMAIL],
             
             [BMSettingsPropertyDescriptor propertyDescriptorFromKeyPath:@"myListSortOrderState" valueType:BMValueTypeUnsignedInteger defaultValue:@(AHShoppingListOrderModeSorted) keyName:	AH_SETTINGS_MYLIST_SORT_ORDER_STATE],
             
             [BMSettingsPropertyDescriptor propertyDescriptorFromKeyPath:@"synchingEnabled" valueType:BMValueTypeBoolean defaultValue:@(YES) keyName:AH_SETTINGS_SYNCHING_ENABLED]
             
              ];
}

- (BOOL)isLoggedIn {
    return (self.mijnAHEmailAddress != nil);
}

- (void)clearMijnAHEmailAddress {
    self.mijnAHEmailAddress = nil;
}

- (void)setSynchingEnabled:(BOOL)synchingEnabled {
    _synchingEnabled = synchingEnabled;
}

- (void)setMyListSortOrderState:(AHShoppingListSortState)myListSortOrderState {
    _myListSortOrderState = myListSortOrderState;
}

- (void)loadStateFromUserDefaults:(NSUserDefaults *)defaults {
    [super loadStateFromUserDefaults:defaults];
}

- (void)saveStateInUserDefaults:(NSUserDefaults *)defaults {
    [super saveStateInUserDefaults:defaults];
}

@end
