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

#import <BMThree20/Three20UICommon/BMTTBaseViewController.h>

/**
 * A view controller with some useful additions.
 */
@interface BMTTViewController : BMTTBaseViewController {
}

/**
 * Forcefully initiates garbage collection. You may call this in your didReceiveMemoryWarning
 * message if you are worried about garbage collection memory consumption.
 *
 * See Articles/UI/GarbageCollection.mdown for a more detailed discussion.
 */
+ (void)doGarbageCollection;

@end
