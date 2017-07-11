//
//  ThirdLoginView.h
//  MiaoShow
//
//  Created by CJW on 17/7/7.
//  Copyright © 2017年 cjw. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,LoginType){
    LoginTypeSins,
    LoginTypeQQ,
    LoginTypeWechat
};
@interface ThirdLoginView : UIView
/*点击按钮*/
@property (nonatomic,copy) void (^clickLogin)(LoginType type);
@end
