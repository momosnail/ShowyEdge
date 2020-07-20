#import "ServerController.h"
#import "PreferencesModel.h"
#import "StartAtLoginUtilities.h"

@interface ServerController ()

@property(weak) IBOutlet PreferencesModel* preferencesModel;

@end

@implementation ServerController

- (void)terminateServerProcess {
  [self updateStartAtLogin:NO];
  [NSApp terminate:nil];
}

- (BOOL)isDebuggingBundle {
  NSString* bundlePath = [[NSBundle mainBundle] bundlePath];
  if ([bundlePath length] > 0) {
    if ([bundlePath hasSuffix:@"/Build/Products/Release/ShowyEdge.app"] /* from Xcode */ ||
        [bundlePath hasSuffix:@"/build/Release/ShowyEdge.app"] /* from command line */) {
      NSLog(@"%@ is debugging bundle", bundlePath);
      return YES;
    }
  }
  return NO;
}

- (void)updateStartAtLogin:(BOOL)preferredValue {
  if (!preferredValue) {
    [StartAtLoginUtilities setStartAtLogin:NO];

  } else {
    // Do not register to StartAtLogin if kResumeAtLogin is NO.
    if (!self.preferencesModel.resumeAtLogin || [self isDebuggingBundle]) {
      [StartAtLoginUtilities setStartAtLogin:NO];
    } else {
      [StartAtLoginUtilities setStartAtLogin:YES];
    }
  }
}

@end
