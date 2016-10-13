//
// Copyright 2009-2011 Facebook
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "Three20Style/BMTTSolidBorderStyle.h"

// Style
#import "Three20Style/BMTTStyleContext.h"
#import "Three20Style/BMTTShape.h"

// Core
#import "Three20Core/BMTTCorePreprocessorMacros.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation BMTTSolidBorderStyle

@synthesize color = _color;
@synthesize width = _width;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNext:(BMTTStyle*)next {
  if (self = [super initWithNext:next]) {
    _width = 1;
  }

  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  BMTT_RELEASE_SAFELY(_color);

  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class public


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (BMTTSolidBorderStyle*)styleWithColor:(UIColor*)color width:(CGFloat)width next:(BMTTStyle*)next {
  BMTTSolidBorderStyle* style = [[[self alloc] initWithNext:next] autorelease];
  style.color = color;
  style.width = width;
  return style;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark BMTTStyle


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)draw:(BMTTStyleContext*)context {
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  CGContextSaveGState(ctx);

  CGRect strokeRect = CGRectInset(context.frame, _width/2, _width/2);
  [context.shape addToPath:strokeRect];

  [_color setStroke];
  CGContextSetLineWidth(ctx, _width);
  CGContextStrokePath(ctx);

  CGContextRestoreGState(ctx);

  context.frame = CGRectInset(context.frame, _width, _width);
  return [self.next draw:context];
}


@end
