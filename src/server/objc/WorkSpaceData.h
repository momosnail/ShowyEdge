/* -*- mode: objective-c -*- */

@import Cocoa;

@interface WorkSpaceData : NSObject

@property(copy, readonly) NSString* currentInputSourceID;
@property(copy, readonly) NSString* currentInputModeID;
@property(readonly) BOOL isFullScreenSpace;

- (void)setup;

@end