/* -*- Mode: objc; Coding: utf-8; indent-tabs-mode: nil; -*- */

@import Cocoa;

@interface WorkSpaceData : NSObject

@property(copy, readonly) NSString* currentInputSourceID;
@property(copy, readonly) NSString* currentInputModeID;

- (void)setup;

@end
