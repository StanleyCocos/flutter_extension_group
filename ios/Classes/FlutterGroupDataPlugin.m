#import "FlutterGroupDataPlugin.h"
#if __has_include(<flutter_group_data/flutter_group_data-Swift.h>)
#import <flutter_group_data/flutter_group_data-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_group_data-Swift.h"
#endif

@implementation FlutterGroupDataPlugin


+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
        methodChannelWithName:@"flutter_group_data"
              binaryMessenger:[registrar messenger]];
    FlutterGroupDataPlugin * instance = [[FlutterGroupDataPlugin alloc] init];
    [registrar addApplicationDelegate: instance];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getGroupSharedBadge" isEqualToString:call.method]) {
        NSUserDefaults * defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.addcn.target"];
        if(defaults != nil){
            NSString * value = [defaults objectForKey: @"BadgeNumber"];
            if(value == nil){
                result(@"");
            } else {
                result(value);
            }
        } else {
            result(@"");
        }
    } else if ([@"setGroupSharedBadge" isEqualToString:call.method]) {
        NSString * value = call.arguments;
        if(value == nil){ value = @"";}
        NSUserDefaults * defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.addcn.target"];
        if(defaults != nil && value != nil){
            [defaults setObject:value forKey:@"BadgeNumber"];
        }
    } else if([@"setGroupSharedIMIE" isEqualToString:call.method]){
        NSString * value = call.arguments;
        if(value == nil){ value = @"";}
        NSUserDefaults * defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.addcn.target"];
        if(defaults != nil && value != nil){
            [defaults setObject:value forKey:@"app_imei"];
        }
    }
}
@end
