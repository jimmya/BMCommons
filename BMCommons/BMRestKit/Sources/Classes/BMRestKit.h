//
//  BMMappingService.h
//  BMMappingService
//
//  Created by Werner Altewischer on 5/16/13.
//  Copyright (c) 2013 BehindMedia. All rights reserved.
//

#if BM_PRIVATE_ENABLED
#import <BMCommons/BMRestKit_Private.h>
#endif

#import <Foundation/Foundation.h>
#import <BMCommons/BMCore.h>
#import <BMCommons/BMXML.h>

#ifndef BMRestKitCheckLicense
#define BMRestKitCheckLicense() {}
#endif

/**
 BMRestKit module
 */
@interface BMRestKit : NSObject<BMLicensedModule>

+ (id)instance;

@end

extern NSString * const BMParserDocumentTypeXML;
extern NSString * const BMParserDocumentTypeJSONArray;
extern NSString * const BMParserDocumentTypeJSONDictionary;