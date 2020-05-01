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


    if([@"getPushToken" isEqualToString:call.method]){
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * token = [defaults objectForKey:@"ios_token"];
        if(token == nil || token.length <= 0){
            result(@"123");
        } else {
            result(token);
        }
    } else if ([@"getPushMessage" isEqualToString: call.method]){
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * message = [defaults objectForKey:@"push_message"];
        if(message == nil || message.length <= 0){
            result(@"0");
        } else {
            result(message);
        }
    } else {
        if ([@"getGroupShared" isEqualToString:call.method]) {
            NSString * key = call.arguments[@"key"];

            NSUserDefaults * defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.addcn.target"];
            if(defaults != nil && key != nil){
                NSString * value = [defaults objectForKey: key];
                if(value == nil){
                    result(@"");
                } else {
                    result(value);
                }
            } else {
                result(@"");
            }
        } else {
            NSString * key = call.arguments[@"key"];
            NSString * value = call.arguments[@"value"];

            NSUserDefaults * defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.addcn.target"];
            if(defaults != nil && key != nil && value != nil){
                [defaults setObject:value forKey:key];
            } else {
                //result(@"");
            }
        }
    }

}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{

    NSUInteger len = [deviceToken length];
    char * chars = (char *)[deviceToken bytes];
    NSMutableString * hexString = [[NSMutableString alloc] init];
    for(NSUInteger i = 0; i < len; i++){
        [hexString appendString:[NSString stringWithFormat:@"%0.2hhx", chars[i]]];
    }
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:hexString forKey:@"ios_token"];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
 
  //处理推送过来的数据
    NSDictionary * message = response.notification.request.content.userInfo;
    if(message != nil && [message isKindOfClass:[NSDictionary class]]){
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:message forKey:@"push_message"];
    }
    
  completionHandler();
 
}

@end
