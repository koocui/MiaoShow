//
//  UIViewController+SLHUD.h
//  MiaoShow
//
//  Created by CJW on 17/8/10.
//  Copyright © 2017年 cjw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>
@interface UIViewController (SLHUD)
/*HUD*/
@property (nonatomic,weak,readonly) MBProgressHUD * HUD;
/**
 *  提示信息
 *
 *  @param view 显示在哪个view
 *  @param hint 提示
 */
-(void)showHUDInView:(UIView*)view hint:(NSString*)hint;
-(void)showHudInView:(UIView*)view hint:(NSString*)hint yOffset:(float)yOffset;
/**
 *  隐藏
 */
-(void)hideHud;
/**
 *  提示信息 mode:MBProgressHUDModeText:
 *
 *  @param hint 提示
 */
-(void)showHint:(NSString*)hint;
-(void)showHint:(NSString *)hint inView:(UIView*)view;
/**
 *  c从默认（showhint:）
 *
 *  @param hint    提示
 *  @param yOffset 便宜量
 */
-(void)showHint:(NSString *)hint yOffset:(float)yOffset;



@end
