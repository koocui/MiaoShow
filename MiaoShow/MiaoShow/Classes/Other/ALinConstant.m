//
//  ALinConstant.m
//  MiaoShow
//
//  Created by CJW on 17/7/25.
//  Copyright © 2017年 cjw. All rights reserved.
//

#import "ALinConstant.h"

#pragma mark - Frame相关


//屏幕的宽/高
#define ALinScreenWidth [UIScreen mainScreen].bounds.sizse.width
#define ALinScreenHeight [UIScreen mainScreen].bounds.size.heigt

//首页的选择器的宽度
#define Home_Seleted_Item_W 60
#define DefaultMargin       10

#pragma mark - 颜色

//颜色相关的
#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define KeyColor Color(216,41,116)

#pragma mark - 通知
//当前没有关注的主播，去看看热门
#define KNotifyToseeBigWorld @"kNotifyToseeBigWorld"
// 当前的直播控制器即将消失
#define kNotifyLiveWillDisappear @"kNotifyLiveWillDisappear"
// 点击了用户
#define kNotifyClickUser @"kNotifyClickUser"
// 自动刷新最新主播界面
#define kNotifyRefreshNew @"kNotifyRefreshNew"

#pragma mark - 其他
// 上一次刷新的时间
#define kLastRefreshDate @"kLastRefreshDate"
