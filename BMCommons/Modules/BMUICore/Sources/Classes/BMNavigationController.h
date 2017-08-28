//
//  BMNavigationController.h
//  BMCommons
//
//  Created by Werner Altewischer on 1/13/11.
//  Copyright 2011 BehindMedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BMCommons/BMLocalization.h>
#import <BMCommons/BMStyleSheet.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Localizable navigation controller
 */
@interface BMNavigationController : UINavigationController<BMLocalizable> 

/**
 * Pushes a view controller with a transition other than the standard sliding animation.
 */
- (void)pushViewController: (UIViewController*)controller
    animatedWithTransition: (UIViewAnimationTransition)transition;

/**
 * Pops a view controller with a transition other than the standard sliding animation.
 */
- (nullable UIViewController*)popViewControllerAnimatedWithTransition:(UIViewAnimationTransition)transition;

/**
 Stylesheet to attach to the view controller.
 
 Will be pushed on first view load and popped on dealloc. Should be set before view load other wise it is ignored.
 */
@property(nonatomic, strong) BMStyleSheet *styleSheet;

/**
 Set to true to unload the view (pre-iOS 6 behaviour) even for iOS >= 6 in the event of a memory warning.
 */
@property(nonatomic, assign) BOOL shouldUnloadViewAtMemoryWarning;

@end

@interface BMNavigationController(Protected)

- (void)pushAnimationDidStop;

- (void)viewWillUnload;
- (void)viewDidUnload;

@end

NS_ASSUME_NONNULL_END