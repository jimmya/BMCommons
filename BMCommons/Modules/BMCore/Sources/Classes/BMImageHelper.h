//
//  BMImageHelper.h
//  BMCommons
//
//  Created by Werner Altewischer on 23/09/08.
//  Copyright 2008 BehindMedia. All rights reserved.
//

#import <BMCommons/BMCore.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#endif

NS_ASSUME_NONNULL_BEGIN

/**
 UIImage helper methods. 
 
 Methods that are not in the ThreadSafe category are only safe to call from the main thread.
 */
@interface BMImageHelper : BMCoreObject {

}

#if TARGET_OS_IPHONE

/**
 Scales an image to the specified size losing the aspect ratio (scales to fit) and an optional corner radius to produce a rounded image.
 */
+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size withCornerRadius:(CGFloat)cornerRadius;


/**
 Crops an image with the specified crop rectangle and optional corner radius in pixels.
 */
+ (UIImage *)cropImage:(UIImage *)image toRect:(CGRect)rect withCornerRadius:(CGFloat)cornerRadius;

/**
 * Scales an image in a non-threadsafe manner. 
 
 The aspect ratio of the image is lost, it is scaled to fit.
 */
+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)imageSize;

#endif

@end

/**
 Thread safe methods which are callable from threads other than the main thread.
 */
@interface BMImageHelper(ThreadSafe)

#if TARGET_OS_IPHONE

/**
 * Thread safe implementation for scaling an image with the supplied max resolution and keeping the aspect ratio.
 
 Image is not rotated, OrientationUp is assumed.
 
 @param maxResolution The maximum amount of pixels in either the width or height dimension depending on which is larger.
 */
+ (UIImage *)scaleImage:(UIImage *)image maxResolution:(NSInteger)maxResolution;

/**
 * Scales and rotates the supplied image (to ImageOrientationUp) in a thread safe manner by keeping the aspect ratio.
 
 @param maxResolution The maximum amount of pixels in either the width or height dimension depending on which is larger.
 */
+ (UIImage *)scaleAndRotateImage:(UIImage *)image maxResolution:(NSInteger)maxResolution;

/**
 Rotates the image to ImageOrientationUp in a thread safe manner by keeping the aspect ratio.
 */
+ (UIImage *)rotateImage:(UIImage *)image;

/**
 Guesses the orientation of the supplied image.
 */
+ (UIInterfaceOrientation)guessOrientationFromImage:(UIImage *)image;

/**
 Inverts the colors of the image such that for RGB: r = 1.0 -r, g = 1.0 - g, b = 1.0 - b.
 */
+ (UIImage *)invertedImageFromImage:(UIImage *)sourceImage;

/**
 Adjusts the brightness of the supplied image with a factor such that r = r * (1 + factor), g = g * (1 + factor) and b = b * (1 + factor).
 */
+ (UIImage*)imageFromImage:(UIImage *)source withBrightness:(CGFloat)brightnessFactor;

/**
 Method which calls scaleAndRotateImage:maxResolution: and calls the specified selector on the specified target in the main thread upon completion.
 */
+ (nullable NSData *)dataFromScaledImage:(UIImage *)image withMaxResolution:(NSInteger)maxResolution;

/**
 Method which calls scaleAndRotateImage:maxResolution: and uses the specified transformer to convert the image to NSData.

 If nil is supplied for the transformer the default UIImageToJPEGDataTransformer is used.
 
 @param targetSize The resulting size of the image after the scale/rotate operation completes.
 */
+ (nullable NSData *)dataFromScaledImage:(UIImage *)image withMaxResolution:(NSInteger)maxResolution targetSize:(nullable CGSize *)targetSize transformer:(nullable NSValueTransformer *)transformer;

/**
 Extracts a thumbnail image to show for a video at the specified URL.
 */
+ (nullable UIImage *)thumbnailFromVideoAtURL:(NSURL *)contentURL;

#endif

@end

NS_ASSUME_NONNULL_END
