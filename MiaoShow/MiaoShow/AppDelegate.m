//
//  AppDelegate.m
//  MiaoShow
//
//  Created by CJW on 17/7/6.
//  Copyright © 2017年 cjw. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
//#import "SLTopWindow.h"
#import "Reachability.h"
@interface AppDelegate ()
{
    Reachability *_reacha;
    NetworkStates _preStatus;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[LoginViewController alloc]init];
    
    [self.window makeKeyAndVisible];
    [self checkNetworkStates];
    return YES;
}
// 实时监控网络状态
- (void)checkNetworkStates
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(networkChange) name:kReachabilityChangedNotification object:nil];
    _reacha = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];

}
-(void)networkChange{
    NSString * tips;
    NetworkStates currentStates = [ALinNetworkTool getNetworkStates];
    if (currentStates == _preStatus){
        return;
    }
    _preStatus = currentStates;
    switch (currentStates) {
        case NetworkStatesNone:
            tips = @"当前无网络，请检查网络连接";
            break;
        case NetworkStates2G:
            tips = @"切换到了2G网络";
            break;
        case NetworkStates3G:
            tips = @"切换到了3G网络";
            break;
        case NetworkStates4G:
            tips = @"切换到了4G网络";
            break;
        case NetworkStatesWIFI:
            tips = nil;
            break;
        default:
            break;
    }
    if(tips.length){
        [[[UIAlertView alloc]initWithTitle:@"CJW" message:tips delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
    }



}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
#pragma mark - 应用开始聚焦
- (void)applicationDidBecomeActive:(UIApplication *)application {
//     [SLTopWindow show];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





@end
