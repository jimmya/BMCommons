//
//  BMOperationQueue.h
//  BMCommons
//
//  Created by Werner Altewischer on 3/3/11.
//  Copyright 2011 BehindMedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BMCommons/BMCoreObject.h>
#import <BMCommons/BMSingleton.h>

@class BMOperationQueue;

NS_ASSUME_NONNULL_BEGIN

/**
 Delegate protocol for BMOperationQueue.
 */
@protocol BMOperationQueueDelegate<NSObject>

/**
 Called to notify the delegate that the specified operation finished execution.
 */
- (void)operationQueue:(BMOperationQueue *)queue didFinishOperation:(NSOperation *)operation;

@end

/**
 Extension of NSOperationQueue that adds delegate notifications upon completion of NSOperations.
 */
@interface BMOperationQueue : BMCoreObject

BM_DECLARE_DEFAULT_SINGLETON

@property (nonatomic, readonly) NSOperationQueue *processingQueue;

/**
 Adds an implementor of BMOperationQueueDelegate to the delegates.
 */
- (void)addDelegate:(id <BMOperationQueueDelegate>)delegate;

/**
 Removes a delegate.
 */
- (void)removeDelegate:(id <BMOperationQueueDelegate>)delegate;

/**
 Schedules an operation for running
 */
- (void)scheduleOperation:(NSOperation *)operation;

/**
 Terminates/cancels all running and scheduled operations
 */
- (void)terminate;

/**
 Waits until all operations are finished.
 */
- (void)waitUntilReady;

/**
 Returns YES iff at least one operation is currently running or queued.
 */
- (BOOL)isBusy;

@end

NS_ASSUME_NONNULL_END
