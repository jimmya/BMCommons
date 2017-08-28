//
//  BMSlider.h
//  BMCommons
//
//  Created by Werner Altewischer on 17/11/09.
//  Copyright 2009 BehindMedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BMSlider;

@protocol BMSliderDelegate<NSObject>

- (void)sliderValueChanged:(BMSlider *)slider;

@end

typedef enum BMSliderScale {
	BMSliderScaleLinear,
	BMSliderScaleLogarithmic,
	BMSliderScaleEvenlySpaced
} BMSliderScale;

@interface BMSlider : UISlider

@property (nonatomic, assign) BMSliderScale scale;
@property (nullable, nonatomic, strong) NSArray *discreteValues;
@property (nullable, nonatomic, weak) id <BMSliderDelegate> delegate;

- (void)setRealValue:(float)value animated:(BOOL)animated;
- (void)setRealValue:(float)value;
- (void)setRealMaximumValue:(float)value;
- (void)setRealMinimumValue:(float)value;
- (float)realValue;
- (float)realMinimumValue;
- (float)realMaximumValue;

@end

NS_ASSUME_NONNULL_END
