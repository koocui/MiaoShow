//
//  ALinNetworkTool.h
//  MiaoShow
//
//  Created by CJW on 17/7/6.
//  Copyright © 2017年 cjw. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>


typedef NS_ENUM(NSUInteger,NetworkStates){
     NetworkStatesNone,//没有网络
     NetworkStates2G,// 2G
     NetworkStates3G,//3G
     NetworkStates4G,//4G
     NetworkStatesWIFI //WIFI
};


@interface ALinNetworkTool : AFHTTPSessionManager
+(instancetype)shareTool;
//判断网络类型
+(NetworkStates)getNetworkStates;
@end
