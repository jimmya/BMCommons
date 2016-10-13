//
//  BMClickableTableViewCell.m
//  BehindMedia
//
//  Created by Werner Altewischer on 27/10/09.
//  Copyright 2010 BehindMedia. All rights reserved.
//

#import "BMTableViewCell.h"
#import <BMUICore/BMUICore.h>

@implementation BMTableViewCell {
	BOOL clickEnabled;
	NSObject *__weak target;
	SEL selector;
	UITableViewCellSelectionStyle enabledSelectionStyle;
	UITableViewCellSelectionStyle disabledSelectionStyle;
	NSString *customReuseIdentifier;
}

@synthesize target, selector, enabledSelectionStyle, disabledSelectionStyle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        BMUICoreCheckLicense();
		self.enabledSelectionStyle = BMSTYLEVAR(tableViewCellSelectionStyle);
		self.disabledSelectionStyle = UITableViewCellSelectionStyleNone;
        self.clickEnabled = YES;
        
        UIColor *c = BMSTYLEVAR(tableViewCellTextColor);
        if (c) {
            self.textLabel.textColor = c;
        }
        UIFont *f = BMSTYLEVAR(tableViewCellTextFont);
        if (f) {
            self.textLabel.font = f;
        }
        c = BMSTYLEVAR(tableViewCellDetailTextColor);
        if (c) {
            self.detailTextLabel.textColor = c;
        }
        f = BMSTYLEVAR(tableViewCellDetailTextFont);
        if (f) {
            self.detailTextLabel.font = f;
        }        
	}
	return self;
}

- (id)init {
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
}

- (id)initWithCoder:(NSCoder *)coder {
	if ((self = [super initWithCoder:coder])) {
        BMUICoreCheckLicense();
		self.enabledSelectionStyle = self.selectionStyle;
		self.disabledSelectionStyle = UITableViewCellSelectionStyleNone;
        self.clickEnabled = YES;
	}
	return self;
}

- (void)dealloc {
	BM_RELEASE_SAFELY(customReuseIdentifier);
}

- (void)onClick {
	if (self.clickEnabled && self.target && self.selector) {
		[self.target performSelector:self.selector withObject:self];
	}
}

- (BOOL)clickEnabled {
	return clickEnabled;
}

- (void)setClickEnabled:(BOOL)enabled {
	clickEnabled = enabled;
	if (!enabled) {
		self.selectionStyle = self.disabledSelectionStyle;
	} else {
		self.selectionStyle = self.enabledSelectionStyle;
	}
}

- (void)setReuseIdentifier:(NSString *)identifier  {
	if (identifier != customReuseIdentifier) {
		customReuseIdentifier = identifier;
	}
}

- (NSString *)reuseIdentifier {
	if (customReuseIdentifier) {
		return customReuseIdentifier;
	} else {
		return [super reuseIdentifier];
	}
}


@end
