#import "RaveFlutterPlugin.h"
#if __has_include(<rave_flutter/rave_flutter-Swift.h>)
#import <rave_flutter/rave_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "rave_flutter-Swift.h"
#endif

@implementation RaveFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftRaveFlutterPlugin registerWithRegistrar:registrar];
}
@end
