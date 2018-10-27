#import "PreferencesManager.h"
#import "NotificationKeys.h"
#import "PreferencesKeys.h"
#import "PreferencesModel.h"
#import "SharedKeys.h"

@interface PreferencesManager ()

@property(weak) IBOutlet PreferencesModel* preferencesModel;

@end

@implementation PreferencesManager

+ (void)initialize {
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    NSDictionary* dict = @{
      kIndicatorHeight : @"0.15",
      kIndicatorOpacity : @100,
      kResumeAtLogin : @YES,
      kUseCustomFrame : @NO,
      kCustomFrameTop : @0,
      kCustomFrameLeft : @0,
      kCustomFrameWidth : @100,
      kCustomFrameHeight : @100,
      kColorsLayoutOrientation : @"horizontal",
    };
    [[NSUserDefaults standardUserDefaults] registerDefaults:dict];
  });
}

- (void)loadPreferencesModel:(PreferencesModel*)preferencesModel {
  preferencesModel.resumeAtLogin = [[NSUserDefaults standardUserDefaults] boolForKey:kResumeAtLogin];
  preferencesModel.checkForUpdates = YES;

  preferencesModel.inputSourceColors = [[NSUserDefaults standardUserDefaults] arrayForKey:kCustomizedLanguageColor];

  preferencesModel.indicatorHeight = [[NSUserDefaults standardUserDefaults] floatForKey:kIndicatorHeight];
  preferencesModel.indicatorOpacity = [[NSUserDefaults standardUserDefaults] integerForKey:kIndicatorOpacity];
  preferencesModel.colorsLayoutOrientation = [[NSUserDefaults standardUserDefaults] stringForKey:kColorsLayoutOrientation];

  preferencesModel.useCustomFrame = [[NSUserDefaults standardUserDefaults] boolForKey:kUseCustomFrame];
  preferencesModel.customFrameLeft = [[NSUserDefaults standardUserDefaults] integerForKey:kCustomFrameLeft];
  preferencesModel.customFrameTop = [[NSUserDefaults standardUserDefaults] integerForKey:kCustomFrameTop];
  preferencesModel.customFrameWidth = [[NSUserDefaults standardUserDefaults] integerForKey:kCustomFrameWidth];
  preferencesModel.customFrameHeight = [[NSUserDefaults standardUserDefaults] integerForKey:kCustomFrameHeight];
}

- (void)savePreferencesModel:(PreferencesModel*)preferencesModel processIdentifier:(int)processIdentifier {
  // We should run `savePreferencesModel` in the main thread because `savePreferencesModel` calls `loadPreferencesModel` internally.
  // We should touch self.preferencesModel only in the main thread to avoid race condition.

  if (![NSThread isMainThread]) {
    NSLog(@"WARNING [PreferencesManager savePreferencesModel] is not running in main thread.");
  }

  if (!preferencesModel) {
    return;
  }

  [[NSUserDefaults standardUserDefaults] setObject:@(preferencesModel.resumeAtLogin) forKey:kResumeAtLogin];

  [[NSUserDefaults standardUserDefaults] setObject:preferencesModel.inputSourceColors forKey:kCustomizedLanguageColor];

  [[NSUserDefaults standardUserDefaults] setObject:@(preferencesModel.indicatorHeight) forKey:kIndicatorHeight];
  [[NSUserDefaults standardUserDefaults] setObject:@(preferencesModel.indicatorOpacity) forKey:kIndicatorOpacity];
  [[NSUserDefaults standardUserDefaults] setObject:preferencesModel.colorsLayoutOrientation forKey:kColorsLayoutOrientation];

  [[NSUserDefaults standardUserDefaults] setObject:@(preferencesModel.useCustomFrame) forKey:kUseCustomFrame];
  [[NSUserDefaults standardUserDefaults] setObject:@(preferencesModel.customFrameLeft) forKey:kCustomFrameLeft];
  [[NSUserDefaults standardUserDefaults] setObject:@(preferencesModel.customFrameTop) forKey:kCustomFrameTop];
  [[NSUserDefaults standardUserDefaults] setObject:@(preferencesModel.customFrameWidth) forKey:kCustomFrameWidth];
  [[NSUserDefaults standardUserDefaults] setObject:@(preferencesModel.customFrameHeight) forKey:kCustomFrameHeight];

  // ----------------------------------------
  // refresh local model.
  if (preferencesModel != self.preferencesModel) {
    [self loadPreferencesModel:self.preferencesModel];
  }

  // ----------------------------------------
  [[NSNotificationCenter defaultCenter] postNotificationName:kIndicatorConfigurationChangedNotification object:nil];
  [[NSDistributedNotificationCenter defaultCenter] postNotificationName:kShowyEdgePreferencesUpdatedNotification
                                                                 object:nil
                                                               userInfo:@{ @"processIdentifier" : @(processIdentifier) }
                                                     deliverImmediately:YES];
}

@end
