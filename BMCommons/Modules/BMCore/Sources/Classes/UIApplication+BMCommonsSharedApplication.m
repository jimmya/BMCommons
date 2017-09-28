//
//  UIApplication+BMCommonsSharedApplication.m
//  BMCommons
//
//  Created by Werner Altewischer on 06/09/15.
//  Copyright (c) 2015 BehindMedia. All rights reserved.
//

#if TARGET_OS_IPHONE

#import "UIApplication+BMCommons.h"
#import <objc/runtime.h>

@implementation UIApplication (BMSharedApplication)

+ (void)load {
    // When you build an extension based on an Xcode template, you get an extension bundle that ends in .appex.
    // https://developer.apple.com/library/ios/documentation/General/Conceptual/ExtensibilityPG/ExtensionCreation.html
    if (![[[NSBundle mainBundle] bundlePath] hasSuffix:@".appex"]) {
        Method sharedApplicationMethod = class_getClassMethod([UIApplication class], @selector(sharedApplication));
        if (sharedApplicationMethod != NULL) {
            IMP sharedApplicationMethodImplementation = method_getImplementation(sharedApplicationMethod);
            Method bm_sharedApplicationMethod = class_getClassMethod([UIApplication class], @selector(bm_sharedApplication));
            method_setImplementation(bm_sharedApplicationMethod, sharedApplicationMethodImplementation);
        }
    }
}

+ (UIApplication *)bm_sharedApplication {
    return nil;
}

@end

#endif
