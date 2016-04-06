#import "ServerForUserspace.h"
#import "PreferencesKeys.h"
#import "PreferencesManager.h"
#import "ServerController.h"
#import "SharedKeys.h"
#import "Updater.h"
#import "WorkSpaceData.h"

@interface ServerForUserspace ()

@property(weak) IBOutlet PreferencesManager* preferencesManager;
@property(weak) IBOutlet PreferencesModel* preferencesModel;
@property(weak) IBOutlet ServerController* serverController;
@property(weak) IBOutlet Updater* updater;
@property(weak) IBOutlet WorkSpaceData* workSpaceData;

@property NSConnection* connection;

@end

@implementation ServerForUserspace

- (id)init {
  self = [super init];

  if (self) {
    self.connection = [NSConnection new];
  }

  return self;
}

- (BOOL) register {
  [self.connection setRootObject:self];
  if (![self.connection registerName:kShowyEdgeConnectionName]) {
    return NO;
  }
  return YES;
}

// ----------------------------------------------------------------------
- (NSString*)bundleVersion {
  return [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
}

- (NSString*)currentInputSourceID {
  return self.workSpaceData.currentInputSourceID;
}

- (NSString*)currentInputModeID {
  return self.workSpaceData.currentInputModeID;
}

- (void)loadPreferencesModel:(PreferencesModel*)preferencesModel {
  [self.preferencesManager loadPreferencesModel:preferencesModel];
}

- (void)savePreferencesModel:(PreferencesModel*)preferencesModel {
  [self.preferencesManager savePreferencesModel:preferencesModel];
}

- (BOOL)confirmQuit {
  __block BOOL quit = NO;
  dispatch_sync(dispatch_get_main_queue(), ^{
    quit = [self.serverController confirmQuit];
  });
  return quit;
}

- (void)terminateServerProcess {
  dispatch_sync(dispatch_get_main_queue(), ^{
    [self.serverController terminateServerProcess];
  });
}

- (void)checkForUpdatesStableOnly {
  dispatch_sync(dispatch_get_main_queue(), ^{
    [self.updater checkForUpdatesStableOnly];
  });
}

- (void)checkForUpdatesWithBetaVersion {
  dispatch_sync(dispatch_get_main_queue(), ^{
    [self.updater checkForUpdatesWithBetaVersion];
  });
}

@end
