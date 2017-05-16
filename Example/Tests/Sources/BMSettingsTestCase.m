//
//  BMSettingsTestCase.m
//  BMCommons
//
//  Created by Werner Altewischer on 19/10/14.
//  Copyright (c) 2014 BehindMedia. All rights reserved.
//

#import "BMSettingsTestCase.h"
#import <BMCommons/BMSettingsRegistry.h>
#import "BMTestSettingsObject.h"
#import "BMTestCodeableObject.h"
#import <BMCommons/NSObject+BMCommons.h>
#import <BMCommons/BMUICore.h>

@implementation BMSettingsTestCase

- (void)testSaveAndLoadSettings {
    BMSettingsRegistry *settingsRegistry = [[BMSettingsRegistry alloc] initWithClasses:@[[BMTestSettingsObject class]]];
    [settingsRegistry restoreToDefaultsByForcingReset:YES];
    [settingsRegistry finishedInitialization];
    
    BMTestSettingsObject *testSettingsObject = [BMTestSettingsObject sharedInstance];
    //Test whether defaults are set
    
    XCTAssertEqualObjects(testSettingsObject.mijnAHEmailAddress, @"test@mail.com", @"Expected defaults to be properly set");
    XCTAssertTrue(testSettingsObject.myListSortOrderState == AHShoppingListOrderModeSorted, @"Expected defaults to be properly set");
    XCTAssertTrue(testSettingsObject.synchingEnabled == YES, @"Expected defaults to be properly set");
    
    
    testSettingsObject.mijnAHEmailAddress = @"other@mail.com";
    testSettingsObject.synchingEnabled = NO;
    testSettingsObject.myListSortOrderState = AHShoppingListStoreSorted;
    
    [settingsRegistry save];
    [settingsRegistry load];
    
    XCTAssertEqualObjects(testSettingsObject.mijnAHEmailAddress, @"other@mail.com", @"Expected value to be properly saved and loaded");
    XCTAssertTrue(testSettingsObject.myListSortOrderState == AHShoppingListStoreSorted, @"Expected value to be properly saved and loaded");
    XCTAssertTrue(testSettingsObject.synchingEnabled == NO, @"Expected value to be properly saved and loaded");
    
}

- (void)testPerformSelector {
    NSString *aap = @"aap";
    NSString *noot = @"noot";
    NSString *mies = @"mies";

    [self bmSafePerformSelector:@selector(testSelectorWithArg:andArg:andArg:) withObject:aap withObject:noot withObject:mies];
}

- (void)testInvokeSelector {
    NSInteger arg1 = -1;
    BOOL arg2 = YES;
    double arg3 = 1.5;
    NSString *arg4 = @"aap";
    NSUInteger returnLength;
        
    void *args[4] = {&arg1, &arg2, &arg3, &arg4};
    NSUInteger argSizes[4] = {sizeof(NSInteger), sizeof(BOOL), sizeof(double), sizeof(NSString *)};
    
    void *ret = [self bmSafeInvokeSelector:@selector(testPrimitiveSelectorWithArg:andArg:andArg:andArg:) withArgs:args argSizes:argSizes argCount:4 returnLength:&returnLength];
    
    XCTAssertTrue(returnLength == sizeof(NSUInteger), @"Expected returnLength to be set correctly");
    XCTAssertTrue(ret != nil, @"Expected value to be returned");
    
    NSUInteger retValue;
    BM_SAFE_COPY_VALUE(NSUInteger, ret, &retValue, sizeof(NSUInteger));
    
    XCTAssertTrue(retValue == 10, @"Expected return value to be set correctly");
}

- (void)testDecodeEncodeObject {
    BMTestCodeableObject *object = [BMTestCodeableObject new];
    
    NSDate *date = [NSDate date];
    
    object.dateProperty = date;
    object.stringProperty = @"aap";
    object.numberProperty = @(1);
    object.intProperty = 2;
    object.doubleProperty = 10.5;
    object.floatProperty = 5.4;
    object.boolProperty = YES;

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    BMTestCodeableObject *objectCopy = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    XCTAssertTrue([object.dateProperty isEqual:objectCopy.dateProperty], @"Expected values to be equal");
    XCTAssertTrue([object.stringProperty isEqual:objectCopy.stringProperty], @"Expected values to be equal");
    XCTAssertTrue([object.numberProperty isEqual:objectCopy.numberProperty], @"Expected values to be equal");
    XCTAssertTrue(object.intProperty == objectCopy.intProperty, @"Expected values to be equal");
    XCTAssertTrue(object.doubleProperty == objectCopy.doubleProperty, @"Expected values to be equal");
    XCTAssertTrue(object.floatProperty == objectCopy.floatProperty, @"Expected values to be equal");
    XCTAssertTrue(object.boolProperty == objectCopy.boolProperty, @"Expected values to be equal");
}


- (void)testSelectorWithArg:(id)arg1 andArg:(id)arg2 andArg:(id)arg3 {
    NSLog(@"%@, %@, %@", arg1, arg2, arg3);
}


- (NSUInteger)testPrimitiveSelectorWithArg:(NSInteger)arg1 andArg:(BOOL)arg2 andArg:(double)arg3 andArg:(id)arg4 {
    NSLog(@"%zd, %d, %f, %@", arg1, arg2, arg3, arg4);
    return 10;
}

@end
