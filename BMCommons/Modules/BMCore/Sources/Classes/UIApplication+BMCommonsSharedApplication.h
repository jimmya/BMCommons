//
//  UIApplication+BMCommonsSharedApplication.h
//  BMCommons
//
//  Created by Werner Altewischer on 06/09/15.
//  Copyright (c) 2015 BehindMedia. All rights reserved.
//

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

@interface UIApplication (BMSharedApplication)

/**
* @return `nil` in an application extension, otherwise the app instance is created in the `UIApplicationMain` function
*/
+ (UIApplication *)bm_sharedApplication;

@end

#endif
