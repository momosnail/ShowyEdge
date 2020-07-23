#import "AppDelegate.h"
#import "MenuBarOverlayView.h"
#import "NotificationKeys.h"
#import "PreferencesKeys.h"
#import "PreferencesManager.h"
#import "PreferencesWindowController.h"
#import "SharedKeys.h"
#import "StartAtLoginUtilities.h"
#import "Updater.h"
#import "WorkSpaceData.h"
#import "weakify.h"

@interface AppDelegate ()

@property(weak) IBOutlet PreferencesWindowController* preferencesWindowController;
@property(weak) IBOutlet Updater* updater;
@property(weak) IBOutlet WorkSpaceData* workSpaceData;

@property NSMutableArray* windows;

@end

@implementation AppDelegate

- (void)observer_NSWorkspaceDidActivateApplicationNotification:(NSNotification*)notification {
  dispatch_async(dispatch_get_main_queue(), ^{
    [self adjustFrame];
  });
}

- (void)observer_kCurrentInputSourceIDChangedNotification:(NSNotification*)notification {
  dispatch_async(dispatch_get_main_queue(), ^{
    [self adjustFrame];

    // ------------------------------------------------------------
    // check customized language color
    NSString* inputsourceid = self.workSpaceData.currentInputSourceID;

    NSArray* colors = [PreferencesManager getCustomizedLanguageColorByInputSourceId:inputsourceid];
    if (colors) {
      [self setColor:colors[0] c1:colors[1] c2:colors[2]];
      return;
    }

    // ------------------------------------------------------------
    // default language color
    NSString* inputmodeid = self.workSpaceData.currentInputModeID;

    if ([inputmodeid length] > 0) {
      /*  */ if ([inputmodeid isEqual:@"com.apple.inputmethod.Japanese.Katakana"]) {
        [self setColor:[NSColor whiteColor] c1:[NSColor greenColor] c2:[NSColor whiteColor]];

      } else if ([inputmodeid isEqual:@"com.apple.inputmethod.Japanese.HalfWidthKana"]) {
        [self setColor:[NSColor whiteColor] c1:[NSColor purpleColor] c2:[NSColor whiteColor]];

      } else if ([inputmodeid isEqual:@"com.apple.inputmethod.Japanese.FullWidthRoman"]) {
        [self setColor:[NSColor whiteColor] c1:[NSColor yellowColor] c2:[NSColor whiteColor]];

      } else if ([inputmodeid hasPrefix:@"com.apple.inputmethod.Japanese"]) {
        [self setColor:[NSColor whiteColor] c1:[NSColor redColor] c2:[NSColor whiteColor]];

      } else if ([inputmodeid hasPrefix:@"com.apple.inputmethod.TCIM"]) {
        // TradChinese
        [self setColor:[NSColor redColor] c1:[NSColor redColor] c2:[NSColor redColor]];

      } else if ([inputmodeid hasPrefix:@"com.apple.inputmethod.SCIM"]) {
        // SimpChinese
        [self setColor:[NSColor redColor] c1:[NSColor redColor] c2:[NSColor redColor]];

      } else if ([inputmodeid hasPrefix:@"com.apple.inputmethod.Korean"]) {
        [self setColor:[NSColor redColor] c1:[NSColor blueColor] c2:[NSColor clearColor]];

      } else if ([inputmodeid hasPrefix:@"com.apple.inputmethod.Roman"]) {
        [self setColor:[NSColor clearColor] c1:[NSColor clearColor] c2:[NSColor clearColor]];

      } else {
        [self setColor:[NSColor grayColor] c1:[NSColor grayColor] c2:[NSColor grayColor]];
      }

    } else {
      /*  */ if ([inputsourceid hasPrefix:@"com.apple.keylayout.British"]) {
        [self setColor:[NSColor blueColor] c1:[NSColor redColor] c2:[NSColor blueColor]];

      } else if ([inputsourceid hasPrefix:@"com.apple.keylayout.Canadian"]) {
        [self setColor:[NSColor redColor] c1:[NSColor whiteColor] c2:[NSColor redColor]];

      } else if ([inputsourceid hasPrefix:@"com.apple.keylayout.French"]) {
        [self setColor:[NSColor blueColor] c1:[NSColor whiteColor] c2:[NSColor redColor]];

      } else if ([inputsourceid hasPrefix:@"com.apple.keylayout.German"]) {
        [self setColor:[NSColor grayColor] c1:[NSColor redColor] c2:[NSColor yellowColor]];

      } else if ([inputsourceid hasPrefix:@"com.apple.keylayout.Italian"]) {
        [self setColor:[NSColor greenColor] c1:[NSColor whiteColor] c2:[NSColor redColor]];

      } else if ([inputsourceid hasPrefix:@"com.apple.keylayout.Kazakh"]) {
        [self setColor:[NSColor blueColor] c1:[NSColor yellowColor] c2:[NSColor blueColor]];

      } else if ([inputsourceid hasPrefix:@"com.apple.keylayout.Portuguese"]) {
        [self setColor:[NSColor greenColor] c1:[NSColor redColor] c2:[NSColor redColor]];

      } else if ([inputsourceid hasPrefix:@"com.apple.keylayout.Russian"]) {
        [self setColor:[NSColor whiteColor] c1:[NSColor blueColor] c2:[NSColor redColor]];

      } else if ([inputsourceid hasPrefix:@"com.apple.keylayout.Swedish"]) {
        [self setColor:[NSColor blueColor] c1:[NSColor yellowColor] c2:[NSColor blueColor]];

      } else if ([inputsourceid hasPrefix:@"com.apple.keylayout.Spanish"]) {
        [self setColor:[NSColor redColor] c1:[NSColor yellowColor] c2:[NSColor redColor]];

      } else if ([inputsourceid hasPrefix:@"com.apple.keylayout.Swiss"]) {
        [self setColor:[NSColor redColor] c1:[NSColor whiteColor] c2:[NSColor redColor]];

      } else if ([inputsourceid hasPrefix:@"com.apple.keylayout.Dvorak"]) {
        [self setColor:[NSColor grayColor] c1:[NSColor grayColor] c2:[NSColor grayColor]];

      } else if ([inputsourceid hasPrefix:@"com.apple.keyboardlayout.fr-dvorak-bepo.keylayout.FrenchDvorak"]) {
        [self setColor:[NSColor grayColor] c1:[NSColor grayColor] c2:[NSColor grayColor]];

      } else {
        [self setColor:[NSColor clearColor] c1:[NSColor clearColor] c2:[NSColor clearColor]];
      }
    }
  });
}

- (void)setupWindows {
  NSArray* screens = [NSScreen screens];

  NSRect rect = [[NSScreen mainScreen] frame];

  while ([self.windows count] < [screens count]) {
    NSWindow* w = [[NSWindow alloc] initWithContentRect:rect
                                              styleMask:NSWindowStyleMaskBorderless
                                                backing:NSBackingStoreBuffered
                                                  defer:NO];

    // Note: Do not set alpha value for window.
    // Window with alpha value causes glitch at switching a space (Mission Control).

    w.backgroundColor = [NSColor clearColor];
    w.opaque = NO;
    w.hasShadow = NO;
    w.ignoresMouseEvents = YES;
    w.collectionBehavior = NSWindowCollectionBehaviorCanJoinAllSpaces |
                           NSWindowCollectionBehaviorStationary |
                           NSWindowCollectionBehaviorIgnoresCycle;

    MenuBarOverlayView* view = [[MenuBarOverlayView alloc] initWithFrame:rect];
    [w setContentView:view];

    [self.windows addObject:w];
  }

  //
  // Update window level
  //

  for (NSWindow* w in self.windows) {
    if (PreferencesManager.showIndicatorBehindAppWindows) {
      w.level = NSNormalWindowLevel;
    } else {
      w.level = NSStatusWindowLevel;
    }
  }
}

- (void)adjustFrame {
  [self setupWindows];

  // ----------------------------------------
  NSArray* screens = [NSScreen screens];

  for (NSUInteger i = 0; i < [self.windows count]; ++i) {
    NSWindow* w = self.windows[i];
    MenuBarOverlayView* view = [w contentView];

    BOOL hide = NO;
    if (i >= [screens count]) {
      hide = YES;
    } else if (PreferencesManager.hideInFullScreenSpace &&
               self.workSpaceData.isFullScreenSpace) {
      hide = YES;
    } else if (PreferencesManager.showIndicatorBehindAppWindows &&
               self.workSpaceData.isFullScreenSpace) {
      // Hide indicator in full screen space if `Show indicator behind app windows` option is enabled.
      hide = YES;
    }

    if (hide) {
      [w orderOut:self];

    } else {
      NSRect rect = [screens[i] frame];

      if (PreferencesManager.useCustomFrame) {
        CGFloat fullWidth = rect.size.width;

        CGFloat fullHeight = rect.size.height;
        if (PreferencesManager.showIndicatorBehindAppWindows) {
          fullHeight -= [[NSApp mainMenu] menuBarHeight];
        }

        //
        // Size
        //

        CGFloat width = PreferencesManager.customFrameWidth;
        CGFloat height = PreferencesManager.customFrameHeight;

        if (PreferencesManager.customFrameWidthUnit == CustomFrameUnitPercent) {

          if (width > 100) {
            width = 100;
          }
          width = fullWidth * (width / 100);
        }

        if (PreferencesManager.customFrameHeightUnit == CustomFrameUnitPercent) {
          if (height > 100) {
            height = 100;
          }
          height = fullHeight * (height / 100);
        }

        if (width < 1.0) width = 1.0;
        if (height < 1.0) height = 1.0;

        //
        // Origin
        //

        CGFloat top = PreferencesManager.customFrameTop;
        CGFloat left = PreferencesManager.customFrameLeft;

        if (PreferencesManager.customFrameOrigin == CustomFrameOriginUpperLeft ||
            PreferencesManager.customFrameOrigin == CustomFrameOriginUpperRight) {
          top = fullHeight - top - height;
        }

        if (PreferencesManager.customFrameOrigin == CustomFrameOriginUpperRight ||
            PreferencesManager.customFrameOrigin == CustomFrameOriginLowerRight) {
          left = fullWidth - left - width;
        }

        rect.origin.x += left;
        rect.origin.y += top;
        rect.size.width = width;
        rect.size.height = height;

        [w setFrame:rect display:NO];

      } else {
        CGFloat width = rect.size.width;
        CGFloat height = [[NSApp mainMenu] menuBarHeight] * PreferencesManager.indicatorHeight;
        if (height > rect.size.height) {
          height = rect.size.height;
        }

        // To avoid top 1px gap, we need to add an adjust value to frame.size.height.
        // (Do not add an adjust value to frame.origin.y.)
        //
        // origin.y + size.height +-------------------------------------------+
        //                        |                                           |
        //               origin.y +-------------------------------------------+
        //                        origin.x                                    origin.x + size.width
        //

        CGFloat adjustHeight = view.adjustHeight;

        rect.origin.x += 0;
        rect.origin.y += rect.size.height - height;
        rect.size.width = width;
        rect.size.height = height + adjustHeight;

        [w setFrame:rect display:NO];
      }

      NSRect windowFrame = [w frame];
      [view setFrame:NSMakeRect(0, 0, windowFrame.size.width, windowFrame.size.height)];

      if (PreferencesManager.showIndicatorBehindAppWindows) {
        [w orderBack:self];
      } else {
        [w orderFront:nil];
      }
    }
  }
}

- (void)setColor:(NSColor*)c0 c1:(NSColor*)c1 c2:(NSColor*)c2 {
  for (NSWindow* window in self.windows) {
    [[window contentView] setColor:c0 c1:c1 c2:c2];
  }
}

- (void)observer_NSApplicationDidChangeScreenParametersNotification:(NSNotification*)notification {
  dispatch_async(dispatch_get_main_queue(), ^{
    NSLog(@"observer_NSApplicationDidChangeScreenParametersNotification");
    [self adjustFrame];
  });
}

- (void)observer_kIndicatorConfigurationChangedNotification:(NSNotification*)notification {
  dispatch_async(dispatch_get_main_queue(), ^{
    [self adjustFrame];
    [self observer_kCurrentInputSourceIDChangedNotification:nil];
  });
}

// ------------------------------------------------------------
- (void)applicationDidFinishLaunching:(NSNotification*)aNotification {
  [NSApplication.sharedApplication disableRelaunchOnLogin];

  // ------------------------------------------------------------
  self.windows = [NSMutableArray new];

  // ------------------------------------------------------------
  @weakify(self);

  [NSWorkspace.sharedWorkspace.notificationCenter addObserver:self
                                                     selector:@selector(observer_NSWorkspaceDidActivateApplicationNotification:)
                                                         name:NSWorkspaceDidActivateApplicationNotification
                                                       object:nil];

  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(observer_kCurrentInputSourceIDChangedNotification:)
                                             name:kCurrentInputSourceIDChangedNotification
                                           object:nil];

  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(observer_kIndicatorConfigurationChangedNotification:)
                                             name:kIndicatorConfigurationChangedNotification
                                           object:nil];

  [NSNotificationCenter.defaultCenter addObserver:self
                                         selector:@selector(observer_NSApplicationDidChangeScreenParametersNotification:)
                                             name:NSApplicationDidChangeScreenParametersNotification
                                           object:nil];

  [NSNotificationCenter.defaultCenter addObserverForName:kFullScreenModeChangedNotification
                                                  object:nil
                                                   queue:[NSOperationQueue mainQueue]
                                              usingBlock:^(NSNotification* note) {
                                                @strongify(self);
                                                if (!self) return;

                                                [self adjustFrame];
                                              }];

  // ------------------------------------------------------------
  [self.workSpaceData setup];

  // ------------------------------------------------------------
  [self.updater checkForUpdatesInBackground];

  // ------------------------------------------------------------
  [NSDistributedNotificationCenter.defaultCenter postNotificationName:kShowyEdgeServerDidLaunchNotification
                                                               object:nil
                                                             userInfo:nil
                                                   deliverImmediately:YES];

  // ------------------------------------------------------------
  [self.preferencesWindowController setup];
}

- (void)dealloc {
  [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication*)theApplication hasVisibleWindows:(BOOL)flag {
  [self.preferencesWindowController show];
  return YES;
}

@end
