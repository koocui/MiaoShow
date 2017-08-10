//
//  UIViewController+SLHUD.m
//  MiaoShow
//
//  Created by CJW on 17/8/10.
//  Copyright © 2017年 cjw. All rights reserved.
//

#import "UIViewController+SLHUD.h"
#import <objc/runtime.h>
static const void * HUDKey = &HUDKey;
@implementation UIViewController (SLHUD)
#pragma mark - 动态绑定HUD属性
-(MBProgressHUD*)HUD{
    return objc_getAssociatedObject(self, HUDKey);
}
-(void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark - 方法实现
-(void)showHUDInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD * hud = [[MBProgressHUD alloc]initWithView:view];
    hud.labelText = hint;
    [view addSubview:hud];
    [hud show:YES];
    [self setHUD:hud];
}
-(void)showHudInView:(UIView *)view hint:(NSString *)hint yOffset:(float)yOffset{
    MBProgressHUD * hud = [[MBProgressHUD alloc]initWithView:view];
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset += yOffset;
    [view addSubview:hud];
    [hud show:YES];
    [self setHUD:hud];
}
-(void)showHint:(NSString *)hint{
    UIView * view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}
-(void)showHint:(NSString *)hint inView:(UIView *)view{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [view addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [hud hide:YES afterDelay:2];
}
-(void)showHint:(NSString *)hint yOffset:(float)yOffset{
    UIView * view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset += yOffset;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

-(void)hideHud{
    [[self HUD] hide:YES];
}



@end













