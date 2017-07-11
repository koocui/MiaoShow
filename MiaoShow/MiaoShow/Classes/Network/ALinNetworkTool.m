//
//  ALinNetworkTool.m
//  MiaoShow
//
//  Created by CJW on 17/7/6.
//  Copyright © 2017年 cjw. All rights reserved.
//

#import "ALinNetworkTool.h"

@implementation ALinNetworkTool
static ALinNetworkTool * _manager;
+(instancetype)shareTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [ALinNetworkTool manager];
        //设置超时时间
        _manager.requestSerializer.timeoutInterval = 5.0f;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    });
    return _manager;
}
/**
 *  判断网络类型
 */
+(NetworkStates)getNetworkStates{
    NSArray * subViews = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    //保存网络状态
    NetworkStates states = NetworkStatesNone;
    
    for (id child in subViews) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]){
            //获取到状态吗
            int networkType = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            
            switch (networkType) {
                case 0:
                    states = NetworkStatesNone;
                    break;
                case 1:
                    states = NetworkStates2G;
                    break;
                case 2:
                    states = NetworkStates3G;
                    break;
                case 3:
                    states = NetworkStates4G;
                    break;
                case 5:{
                    states = NetworkStatesWIFI;
                }
                    break;
                default:
                    break;
            }
        }
    }
    return states;
}

@end
