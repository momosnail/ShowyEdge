#import "PreferencesWindowController.h"
#import "PreferencesClient.h"
#import "PreferencesModel.h"
#import "Relauncher.h"
#import "ServerClient.h"
#import "SharedKeys.h"
#import "SharedUtilities.h"

@interface PreferencesWindowController ()

@property(weak) IBOutlet NSTableView* inputSourcesTableView;
@property(weak) IBOutlet NSTextField* currentInputSourceID;
@property(weak) IBOutlet NSTextField* versionText;
@property(weak) IBOutlet PreferencesClient* preferencesClient;
@property(weak) IBOutlet ServerClient* client;

@end

@implementation PreferencesWindowController

- (void)observer_kShowyEdgeServerDidLaunchNotification:(NSNotification*)notification {
  dispatch_async(dispatch_get_main_queue(), ^{
    [Relauncher relaunch];
  });
}

- (void)observer_kShowyEdgePreferencesUpdatedNotification:(NSNotification*)notification {
  dispatch_async(dispatch_get_main_queue(), ^{
    if (notification.userInfo &&
        [notification.userInfo[@"processIdentifier"] intValue] != [NSProcessInfo processInfo].processIdentifier) {
      NSLog(@"PreferencesModel is changed in another process.");
      [self.preferencesClient load];
      [self.inputSourcesTableView reloadData];
    }
  });
}

- (void)observer_kShowyEdgeCurrentInputSourceIDChangedNotification:(NSNotification*)notification {
  dispatch_async(dispatch_get_main_queue(), ^{
    NSString* inputSourceID = [self.client currentInputSourceID];
    if ([inputSourceID length] > 0) {
      [self.currentInputSourceID setStringValue:inputSourceID];
    }
  });
}

- (void)setup {
  [Relauncher resetRelaunchedCount];

  [self checkServerClient];

  // In Mac OS X 10.7, NSDistributedNotificationCenter is suspended after calling [NSAlert runModal].
  // So, we need to set suspendedDeliveryBehavior to NSNotificationSuspensionBehaviorDeliverImmediately.
  [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                      selector:@selector(observer_kShowyEdgeServerDidLaunchNotification:)
                                                          name:kShowyEdgeServerDidLaunchNotification
                                                        object:nil
                                            suspensionBehavior:NSNotificationSuspensionBehaviorDeliverImmediately];

  [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                      selector:@selector(observer_kShowyEdgePreferencesUpdatedNotification:)
                                                          name:kShowyEdgePreferencesUpdatedNotification
                                                        object:nil
                                            suspensionBehavior:NSNotificationSuspensionBehaviorDeliverImmediately];

  [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                      selector:@selector(observer_kShowyEdgeCurrentInputSourceIDChangedNotification:)
                                                          name:kShowyEdgeCurrentInputSourceIDChangedNotification
                                                        object:nil
                                            suspensionBehavior:NSNotificationSuspensionBehaviorDeliverImmediately];

  [[NSColorPanel sharedColorPanel] setShowsAlpha:YES];

  NSString* version = [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
  [self.versionText setStringValue:version];

  [self observer_kShowyEdgeCurrentInputSourceIDChangedNotification:nil];

  [self.inputSourcesTableView reloadData];
}

- (void)dealloc {
  [[NSDistributedNotificationCenter defaultCenter] removeObserver:self];
}

- (void)windowDidBecomeMain:(NSNotification*)notification {
  [self checkServerClient];
}

- (void)show {
  [self.window makeKeyAndOrderFront:self];
  [NSApp activateIgnoringOtherApps:YES];
}

- (void)checkServerClient {
  if ([[self.client bundleVersion] length] == 0) {
    NSLog(@"ShowyEdge server is not running.");
    [NSApp terminate:self];
  }
}

- (IBAction)addInputSourceID:(id)sender {
  NSString* inputSourceID = [self.currentInputSourceID stringValue];
  if ([inputSourceID length] == 0) {
    return;
  }

  [self.preferencesClient.pm addInputSourceID:inputSourceID];
  [self.preferencesClient save];
  [self.inputSourcesTableView reloadData];

  NSInteger rowIndex = [self.preferencesClient.pm getIndexOfInputSourceID:inputSourceID];
  if (rowIndex >= 0) {
    [self.inputSourcesTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:rowIndex] byExtendingSelection:NO];
    [self.inputSourcesTableView scrollRowToVisible:rowIndex];
  }
}

- (IBAction)quitWithConfirmation:(id)sender {
  if ([SharedUtilities confirmQuit]) {
    @try {
      [self.client terminateServerProcess];
    } @catch (NSException* exception) {
    }

    [NSApp terminate:nil];
  }
}

- (IBAction)checkForUpdatesStableOnly:(id)sender {
  [self.client checkForUpdatesStableOnly];
}

- (IBAction)checkForUpdatesWithBetaVersion:(id)sender {
  [self.client checkForUpdatesWithBetaVersion];
}

- (IBAction)preferencesChanged:(id)sender {
  [self.preferencesClient save];
}

- (IBAction)resumeAtLoginChanged:(id)sender {
  [self.preferencesClient save];
  [self.client updateStartAtLogin];
}

- (IBAction)openURL:(id)sender {
  [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:[sender title]]];
}

@end
