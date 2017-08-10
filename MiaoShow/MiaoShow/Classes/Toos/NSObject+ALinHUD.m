//
//  NSObject+ALinHUD.m
//  MiaoShow
//
//  Created by CJW on 17/8/10.
//  Copyright © 2017年 cjw. All rights reserved.
//

#import "NSObject+ALinHUD.h"

@implementation NSObject (ALinHUD)
-(void)showInfo:(NSString *)info{
    if ([self isKindOfClass:[UIViewController class]] || [self isKindOfClass:[UIView class]]){
        [[[UIAlertView alloc]initWithTitle:@"CJW波霸" message:info delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
    }
}
@end
