// -*- Mode: objc; Coding: utf-8; indent-tabs-mode: nil; -*-

@import Cocoa;
#import "ServerClientProtocol.h"

@interface ServerForUserspace : NSObject <ServerClientProtocol>

- (BOOL)registerService;

@end
