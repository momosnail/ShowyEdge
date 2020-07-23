#import "ColorUtilities.h"

@implementation ColorUtilities

+ (NSColor*)colorFromString:(NSString*)color {
  if ([color hasPrefix:@"#"] && [color length] == 9) {
    // #RRGGBBAA

    NSString* sr = [NSString stringWithFormat:@"0x%@", [color substringWithRange:NSMakeRange(1, 2)]];
    NSString* sg = [NSString stringWithFormat:@"0x%@", [color substringWithRange:NSMakeRange(3, 2)]];
    NSString* sb = [NSString stringWithFormat:@"0x%@", [color substringWithRange:NSMakeRange(5, 2)]];
    NSString* sa = [NSString stringWithFormat:@"0x%@", [color substringWithRange:NSMakeRange(7, 2)]];

    float r = 0.0f;
    float g = 0.0f;
    float b = 0.0f;
    float a = 0.0f;
    if ([[NSScanner scannerWithString:sr] scanHexFloat:&r] &&
        [[NSScanner scannerWithString:sg] scanHexFloat:&g] &&
        [[NSScanner scannerWithString:sb] scanHexFloat:&b] &&
        [[NSScanner scannerWithString:sa] scanHexFloat:&a]) {
      return [NSColor colorWithCalibratedRed:(r / 255.0f) green:(g / 255.0f) blue:(b / 255.0f) alpha:(a / 255.0f)];
    }

  } else {
    if ([@"black" isEqualToString:color]) {
      return [NSColor grayColor];
    }
    if ([@"blue" isEqualToString:color]) {
      return [NSColor blueColor];
    }
    if ([@"brown" isEqualToString:color]) {
      return [NSColor brownColor];
    }
    if ([@"clear" isEqualToString:color]) {
      return [NSColor clearColor];
    }
    if ([@"cyan" isEqualToString:color]) {
      return [NSColor cyanColor];
    }
    if ([@"green" isEqualToString:color]) {
      return [NSColor greenColor];
    }
    if ([@"magenta" isEqualToString:color]) {
      return [NSColor magentaColor];
    }
    if ([@"orange" isEqualToString:color]) {
      return [NSColor orangeColor];
    }
    if ([@"purple" isEqualToString:color]) {
      return [NSColor purpleColor];
    }
    if ([@"red" isEqualToString:color]) {
      return [NSColor redColor];
    }
    if ([@"white" isEqualToString:color]) {
      return [NSColor whiteColor];
    }
    if ([@"yellow" isEqualToString:color]) {
      return [NSColor yellowColor];
    }

    // more colors

    // black 0.0f, 0.0f, 0.0f
    if ([@"black1.0" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
    }
    if ([@"black0.8" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.0f blue:0.0f alpha:0.8f];
    }
    if ([@"black0.6" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.0f blue:0.0f alpha:0.6f];
    }
    if ([@"black0.4" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.0f blue:0.0f alpha:0.4f];
    }
    if ([@"black0.2" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.0f blue:0.0f alpha:0.2f];
    }

    // gray 0.5f, 0.5f, 0.5f
    if ([@"gray1.0" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.5f green:0.5f blue:0.5f alpha:1.0f];
    }
    if ([@"gray0.8" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.5f green:0.5f blue:0.5f alpha:0.8f];
    }
    if ([@"gray0.6" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.5f green:0.5f blue:0.5f alpha:0.6f];
    }
    if ([@"gray0.4" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.5f green:0.5f blue:0.5f alpha:0.4f];
    }
    if ([@"gray0.2" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.5f green:0.5f blue:0.5f alpha:0.2f];
    }

    // silver 0.75f, 0.75f, 0.75f
    if ([@"silver1.0" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.75f green:0.75f blue:0.75f alpha:1.0f];
    }
    if ([@"silver0.8" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.75f green:0.75f blue:0.75f alpha:0.8f];
    }
    if ([@"silver0.6" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.75f green:0.75f blue:0.75f alpha:0.6f];
    }
    if ([@"silver0.4" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.75f green:0.75f blue:0.75f alpha:0.4f];
    }
    if ([@"silver0.2" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.75f green:0.75f blue:0.75f alpha:0.2f];
    }

    // white 1.0f, 1.0f, 1.0f
    if ([@"white1.0" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    }
    if ([@"white0.8" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:1.0f green:1.0f blue:1.0f alpha:0.8f];
    }
    if ([@"white0.6" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:1.0f green:1.0f blue:1.0f alpha:0.6f];
    }
    if ([@"white0.4" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:1.0f green:1.0f blue:1.0f alpha:0.4f];
    }
    if ([@"white0.2" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:1.0f green:1.0f blue:1.0f alpha:0.2f];
    }

    // maroon 0.5f, 0.0f, 0.0f
    if ([@"maroon1.0" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.5f green:0.0f blue:0.0f alpha:1.0f];
    }
    if ([@"maroon0.8" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.5f green:0.0f blue:0.0f alpha:0.8f];
    }
    if ([@"maroon0.6" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.5f green:0.0f blue:0.0f alpha:0.6f];
    }
    if ([@"maroon0.4" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.5f green:0.0f blue:0.0f alpha:0.4f];
    }
    if ([@"maroon0.2" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.5f green:0.0f blue:0.0f alpha:0.2f];
    }

    // red 1.0f, 0.0f, 0.0f
    if ([@"red1.0" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:1.0f green:0.0f blue:0.0f alpha:1.0f];
    }
    if ([@"red0.8" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:1.0f green:0.0f blue:0.0f alpha:0.8f];
    }
    if ([@"red0.6" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:1.0f green:0.0f blue:0.0f alpha:0.6f];
    }
    if ([@"red0.4" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:1.0f green:0.0f blue:0.0f alpha:0.4f];
    }
    if ([@"red0.2" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:1.0f green:0.0f blue:0.0f alpha:0.2f];
    }

    // olive 0.5f, 0.5f, 0.0f
    if ([@"olive1.0" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.5f green:0.5f blue:0.0f alpha:1.0f];
    }
    if ([@"olive0.8" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.5f green:0.5f blue:0.0f alpha:0.8f];
    }
    if ([@"olive0.6" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.5f green:0.5f blue:0.0f alpha:0.6f];
    }
    if ([@"olive0.4" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.5f green:0.5f blue:0.0f alpha:0.4f];
    }
    if ([@"olive0.2" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.5f green:0.5f blue:0.0f alpha:0.2f];
    }

    // yellow 1.0f, 1.0f, 0.0f
    if ([@"yellow1.0" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:1.0f green:1.0f blue:0.0f alpha:1.0f];
    }
    if ([@"yellow0.8" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:1.0f green:1.0f blue:0.0f alpha:0.8f];
    }
    if ([@"yellow0.6" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:1.0f green:1.0f blue:0.0f alpha:0.6f];
    }
    if ([@"yellow0.4" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:1.0f green:1.0f blue:0.0f alpha:0.4f];
    }
    if ([@"yellow0.2" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:1.0f green:1.0f blue:0.0f alpha:0.2f];
    }

    // green 0.0f, 0.5f, 0.0f
    if ([@"green1.0" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.5f blue:0.0f alpha:1.0f];
    }
    if ([@"green0.8" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.5f blue:0.0f alpha:0.8f];
    }
    if ([@"green0.6" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.5f blue:0.0f alpha:0.6f];
    }
    if ([@"green0.4" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.5f blue:0.0f alpha:0.4f];
    }
    if ([@"green0.2" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.5f blue:0.0f alpha:0.2f];
    }

    // lime 0.0f, 1.0f, 0.0f
    if ([@"lime1.0" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:1.0f blue:0.0f alpha:1.0f];
    }
    if ([@"lime0.8" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:1.0f blue:0.0f alpha:0.8f];
    }
    if ([@"lime0.6" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:1.0f blue:0.0f alpha:0.6f];
    }
    if ([@"lime0.4" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:1.0f blue:0.0f alpha:0.4f];
    }
    if ([@"lime0.2" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:1.0f blue:0.0f alpha:0.2f];
    }

    // teal 0.0f, 0.5f, 0.5f
    if ([@"teal1.0" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.5f blue:0.5f alpha:1.0f];
    }
    if ([@"teal0.8" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.5f blue:0.5f alpha:0.8f];
    }
    if ([@"teal0.6" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.5f blue:0.5f alpha:0.6f];
    }
    if ([@"teal0.4" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.5f blue:0.5f alpha:0.4f];
    }
    if ([@"teal0.2" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.5f blue:0.5f alpha:0.2f];
    }

    // aqua 0.0f, 1.0f, 1.0f
    if ([@"aqua1.0" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:1.0f blue:1.0f alpha:1.0f];
    }
    if ([@"aqua0.8" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:1.0f blue:1.0f alpha:0.8f];
    }
    if ([@"aqua0.6" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:1.0f blue:1.0f alpha:0.6f];
    }
    if ([@"aqua0.4" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:1.0f blue:1.0f alpha:0.4f];
    }
    if ([@"aqua0.2" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:1.0f blue:1.0f alpha:0.2f];
    }

    // navy 0.0f, 0.0f, 0.5f
    if ([@"navy1.0" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.0f blue:0.5f alpha:1.0f];
    }
    if ([@"navy0.8" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.0f blue:0.5f alpha:0.8f];
    }
    if ([@"navy0.6" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.0f blue:0.5f alpha:0.6f];
    }
    if ([@"navy0.4" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.0f blue:0.5f alpha:0.4f];
    }
    if ([@"navy0.2" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.0f blue:0.5f alpha:0.2f];
    }

    // blue 0.0f, 0.0f, 1.0f
    if ([@"blue1.0" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.0f blue:1.0f alpha:1.0f];
    }
    if ([@"blue0.8" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.0f blue:1.0f alpha:0.8f];
    }
    if ([@"blue0.6" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.0f blue:1.0f alpha:0.6f];
    }
    if ([@"blue0.4" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.0f blue:1.0f alpha:0.4f];
    }
    if ([@"blue0.2" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.0f green:0.0f blue:1.0f alpha:0.2f];
    }

    // purple 0.5f, 0.0f, 0.5f
    if ([@"purple1.0" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.5f green:0.0f blue:0.5f alpha:1.0f];
    }
    if ([@"purple0.8" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.5f green:0.0f blue:0.5f alpha:0.8f];
    }
    if ([@"purple0.6" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.5f green:0.0f blue:0.5f alpha:0.6f];
    }
    if ([@"purple0.4" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.5f green:0.0f blue:0.5f alpha:0.4f];
    }
    if ([@"purple0.2" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:0.5f green:0.0f blue:0.5f alpha:0.2f];
    }

    // fuchsia 1.0f, 0.0f, 1.0f
    if ([@"fuchsia1.0" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:1.0f green:0.0f blue:1.0f alpha:1.0f];
    }
    if ([@"fuchsia0.8" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:1.0f green:0.0f blue:1.0f alpha:0.8f];
    }
    if ([@"fuchsia0.6" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:1.0f green:0.0f blue:1.0f alpha:0.6f];
    }
    if ([@"fuchsia0.4" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:1.0f green:0.0f blue:1.0f alpha:0.4f];
    }
    if ([@"fuchsia0.2" isEqualToString:color]) {
      return [NSColor colorWithCalibratedRed:1.0f green:0.0f blue:1.0f alpha:0.2f];
    }
  }

  return [NSColor clearColor];
}

@end
