/*
 File: KeychainItemWrapper.m
 Abstract:
 Objective-C wrapper for accessing a single keychain item.
 
 Version: 1.2
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2010 Apple Inc. All Rights Reserved.
 
 */

#import <BMCommons/BMKeychainItemWrapper.h>
#import <Security/Security.h>
#import <BMCommons/BMErrorHelper.h>
#import <BMCommons/BMStringToDataTransformer.h>
#import <BMCommons/BMCore.h>

/*
 
 These are the default constants and their respective types,
 available for the kSecClassGenericPassword Keychain Item class:
 
 kSecAttrAccessGroup         -       CFStringRef
 kSecAttrCreationDate        -       CFDateRef
 kSecAttrModificationDate    -       CFDateRef
 kSecAttrDescription         -       CFStringRef
 kSecAttrComment             -       CFStringRef
 kSecAttrCreator             -       CFNumberRef
 kSecAttrType                -       CFNumberRef
 kSecAttrLabel               -       CFStringRef
 kSecAttrIsInvisible         -       CFBooleanRef
 kSecAttrIsNegative          -       CFBooleanRef
 kSecAttrAccount             -       CFStringRef
 kSecAttrService             -       CFStringRef
 kSecAttrGeneric             -       CFDataRef
 
 See the header file Security/SecItem.h for more details.
 
 */

@interface BMKeychainItemWrapper()

@property (nonatomic, strong) NSMutableDictionary *keychainItemData;
@property (nonatomic, strong) NSMutableDictionary *genericPasswordQuery;

@end

@interface BMKeychainItemWrapper (PrivateMethods)
/*
 The decision behind the following two methods (secItemFormatToDictionary and dictionaryToSecItemFormat) was
 to encapsulate the transition between what the detail view controller was expecting (NSString *) and what the
 Keychain API expects as a validly constructed container class.
 */
- (NSMutableDictionary *)secItemFormatToDictionary:(NSDictionary *)dictionaryToConvert;
- (NSMutableDictionary *)dictionaryToSecItemFormat:(NSDictionary *)dictionaryToConvert;

// Updates the item in the keychain, or adds it if it doesn't exist.
- (void)writeToKeychain;

@end

@implementation BMKeychainItemWrapper

- (id)initWithIdentifier: (NSString *)identifier accessGroup:(NSString *) accessGroup;
{
	return [self initWithIdentifier:identifier accessGroup:accessGroup valueDataTransformer:[BMStringToDataTransformer new]];
}

- (id)initWithIdentifier: (NSString *)identifier accessGroup:(NSString *) accessGroup valueDataTransformer:(NSValueTransformer *)transformer {
	if ((self = [super init]))
    {
		_valueDataTransformer = transformer;
		
        // Begin Keychain search setup. The genericPasswordQuery leverages the special user
        // defined attribute kSecAttrGeneric to distinguish itself between other generic Keychain
        // items which may be included by the same application.
        _genericPasswordQuery = [[NSMutableDictionary alloc] init];
        
        [_genericPasswordQuery setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
        [_genericPasswordQuery setObject:identifier forKey:(id)kSecAttrGeneric];
        
        // The keychain access group attribute determines if this item can be shared
        // amongst multiple apps whose code signing entitlements contain the same keychain access group.
        if (accessGroup != nil)
        {
#if TARGET_OS_IPHONE
#if TARGET_IPHONE_SIMULATOR
            // Ignore the access group if running on the iPhone simulator.
            //
            // Apps that are built for the simulator aren't signed, so there's no keychain access group
            // for the simulator to check. This means that all apps can see all keychain items when run
            // on the simulator.
            //
            // If a SecItem contains an access group attribute, SecItemAdd and SecItemUpdate on the
            // simulator will return -25243 (errSecNoAccessForItem).
#else
            [_genericPasswordQuery setObject:accessGroup forKey:(id)kSecAttrAccessGroup];
#endif
#endif
        }
        
        // Use the proper search constants, return only the attributes of the first match.
        [_genericPasswordQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
        [_genericPasswordQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnAttributes];
        
        NSDictionary *tempQuery = [NSDictionary dictionaryWithDictionary:_genericPasswordQuery];
        
        CFTypeRef outDictionary = NULL;
        
        if (SecItemCopyMatching((__bridge CFDictionaryRef)tempQuery, (CFTypeRef *)&outDictionary) != noErr)
        {
            // Stick these default values into keychain item if nothing found.
            [self resetKeychainItem];
            
            // Add the generic attribute and the keychain access group.
            [_keychainItemData setObject:identifier forKey:(id)kSecAttrGeneric];
            if (accessGroup != nil)
            {
#if TARGET_OS_IPHONE
#if TARGET_IPHONE_SIMULATOR
                // Ignore the access group if running on the iPhone simulator.
                //
                // Apps that are built for the simulator aren't signed, so there's no keychain access group
                // for the simulator to check. This means that all apps can see all keychain items when run
                // on the simulator.
                //
                // If a SecItem contains an access group attribute, SecItemAdd and SecItemUpdate on the
                // simulator will return -25243 (errSecNoAccessForItem).
#else
                [_keychainItemData setObject:accessGroup forKey:(id)kSecAttrAccessGroup];
#endif
#endif
            }
            
            [self writeToKeychain];
        }
        else
        {
            // load the saved data from Keychain.
            self.keychainItemData = [self secItemFormatToDictionary:(__bridge NSDictionary *)outDictionary];
        }
		
        if (outDictionary != NULL) {
            CFRelease(outDictionary);
        }
    }
	return self;
}

- (void)setObject:(id)inObject forKey:(id)key flush:(BOOL)flush
{
    if (inObject == nil) return;
    [_keychainItemData setObject:inObject forKey:key];
    if (flush) {
        [self flush];
    }
}

- (void)setObject:(id)inObject forKey:(id)key {
    [self setObject:inObject forKey:key flush:YES];
}

- (void)setObjectAndKeysFromDictionary:(NSDictionary *)dictionary {
    for (id key in dictionary) {
        id value = [dictionary objectForKey:key];
        [self setObject:value forKey:key flush:NO];
    }
    [self flush];
}

- (void)flush {
    [self writeToKeychain];
}

- (id)objectForKey:(id)key
{
    return [_keychainItemData objectForKey:key];
}

- (void)resetKeychainItem {
    OSStatus junk = noErr;
    if (!_keychainItemData)
    {
        self.keychainItemData = [[NSMutableDictionary alloc] init];
    }
    else if (_keychainItemData)
    {
        NSMutableDictionary *tempDictionary = [NSMutableDictionary new];
        NSArray *keys = [[NSArray alloc] initWithObjects: (__bridge NSString *) kSecClass, kSecAttrAccount, kSecAttrService, nil];
        for (id key in keys) {
            id value = [_keychainItemData objectForKey:key];
            if (value) {
                [tempDictionary setObject:value forKey:key];
            }
        }
        [tempDictionary setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnAttributes];
        junk = SecItemDelete((__bridge CFDictionaryRef)tempDictionary);
        if (junk != noErr) {
            LogWarn(@"Problem deleting current keychain dictionary., error: %d", (int)junk );
        }
    }
    
    // Default attributes for keychain item.
    [_keychainItemData setObject:@"" forKey:(id)kSecAttrAccount];
    [_keychainItemData setObject:@"" forKey:(id)kSecAttrLabel];
    [_keychainItemData setObject:@"" forKey:(id)kSecAttrDescription];
    
    // Default data for keychain item.
	[_keychainItemData removeObjectForKey:(id)kSecValueData];
}

- (NSMutableDictionary *)dictionaryToSecItemFormat:(NSDictionary *)dictionaryToConvert
{
    // The assumption is that this method will be called with a properly populated dictionary
    // containing all the right key/value pairs for a SecItem.
    
    // Create a dictionary to return populated with the attributes and data.
    NSMutableDictionary *returnDictionary = [NSMutableDictionary dictionaryWithDictionary:dictionaryToConvert];
    
    // Add the Generic Password keychain item class attribute.
    [returnDictionary setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    
    // Convert the NSString to NSData to meet the requirements for the value type kSecValueData.
    // This is where to store sensitive data that should be encrypted.
	id password = [dictionaryToConvert objectForKey:(id)kSecValueData];
	NSData *passwordData = nil;
	if (self.valueDataTransformer) {
		passwordData = [self.valueDataTransformer transformedValue:password];
	} else if ([password isKindOfClass:[NSData class]]) {
        passwordData = password;
    }
	if (passwordData) {
		[returnDictionary setObject:passwordData forKey:(id)kSecValueData];
	} else {
		[returnDictionary removeObjectForKey:(id)kSecValueData];
	}
    return returnDictionary;
}

- (NSMutableDictionary *)secItemFormatToDictionary:(NSDictionary *)dictionaryToConvert
{
    // The assumption is that this method will be called with a properly populated dictionary
    // containing all the right key/value pairs for the UI element.
    
    // Create a dictionary to return populated with the attributes and data.
    NSMutableDictionary *returnDictionary = [NSMutableDictionary dictionaryWithDictionary:dictionaryToConvert];
    
    // Add the proper search key and class attribute.
    [returnDictionary setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [returnDictionary setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    
    // Acquire the password data from the attributes.
    CFTypeRef passwordDataRef = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)returnDictionary, (CFTypeRef *)&passwordDataRef) == noErr)
    {
        NSData *passwordData = (__bridge NSData *)passwordDataRef;
        // Remove the search, class, and identifier key/value, we don't need them anymore.
        [returnDictionary removeObjectForKey:(id)kSecReturnData];
        
        // Add the password to the dictionary, converting from NSData to NSString.
		id password = nil;
		if (passwordData) {
			if (self.valueDataTransformer) {
				password = [self.valueDataTransformer reverseTransformedValue:passwordData];
			} else {
				password = passwordData;
            }
		}
		if (password) {
			[returnDictionary setObject:password forKey:(id)kSecValueData];
		} else {
			[returnDictionary removeObjectForKey:(id)kSecValueData];
		}
    }
    else
    {
        // Don't do anything if nothing is found.
        LogWarn(@"Serious error, no matching item found in the keychain.\n");
    }
    
    if (passwordDataRef != NULL) {
        CFRelease(passwordDataRef);
    }
	
    return returnDictionary;
}

- (void)writeToKeychain
{
    CFTypeRef attributes = NULL;
    NSMutableDictionary *updateItem = NULL;
    OSStatus result;
    
	result = SecItemCopyMatching((__bridge CFDictionaryRef)_genericPasswordQuery, (CFTypeRef *)&attributes);
    if (result == noErr)
    {
        // First we need the attributes from the Keychain.
        updateItem = [NSMutableDictionary dictionaryWithDictionary:(__bridge NSDictionary *)attributes];
        // Second we need to add the appropriate search key/values.
        [updateItem setObject:[_genericPasswordQuery objectForKey:(id)kSecClass] forKey:(id)kSecClass];
        
        // Lastly, we need to set up the updated attribute list being careful to remove the class.
        NSMutableDictionary *tempCheck = [self dictionaryToSecItemFormat:_keychainItemData];
        [tempCheck removeObjectForKey:(id)kSecClass];
        
#if TARGET_IPHONE_SIMULATOR
        // Remove the access group if running on the iPhone simulator.
        //
        // Apps that are built for the simulator aren't signed, so there's no keychain access group
        // for the simulator to check. This means that all apps can see all keychain items when run
        // on the simulator.
        //
        // If a SecItem contains an access group attribute, SecItemAdd and SecItemUpdate on the
        // simulator will return -25243 (errSecNoAccessForItem).
        //
        // The access group attribute will be included in items returned by SecItemCopyMatching,
        // which is why we need to remove it before updating the item.
        [tempCheck removeObjectForKey:(id)kSecAttrAccessGroup];
#endif
        
        // An implicit assumption is that you can only update a single item at a time.
        
        result = SecItemUpdate((__bridge CFDictionaryRef)updateItem, (__bridge CFDictionaryRef)tempCheck);
        if (result != noErr) {
            LogWarn(@"Couldn't update the Keychain Item, error: %d", (int)result);
        }
    }
    else
    {
        // No previous item found; add the new one.
        result = SecItemAdd((__bridge CFDictionaryRef)[self dictionaryToSecItemFormat:_keychainItemData], NULL);
        if (result != noErr) {
            LogWarn(@"Couldn't add the Keychain Item, error: %d", (int)result);
        }
    }
    if (attributes != NULL) {
        CFRelease(attributes);
    }
}
@end
