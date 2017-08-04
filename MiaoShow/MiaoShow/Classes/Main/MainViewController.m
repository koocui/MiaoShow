//
//  MainViewController.m
//  MiaoShow
//
//  Created by CJW on 17/7/7.
//  Copyright © 2017年 cjw. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "ProfileController.h"
//#import "ShowTimeViewController.h"
#import "ALinNavigationController.h"
//#import "UIDevice+SLExtension.h"
#import <AVFoundation/AVFoundation.h>
@interface MainViewController ()<UITabBarControllerDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:[[HomeViewController alloc] init] imageNamed:@"toolbar_home"];
    UIViewController * showTime = [[UIViewController alloc] init];
    showTime.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:showTime imageNamed:@"toolbar_live"];
    [self addChildViewController:[[ProfileController alloc] init] imageNamed:@"toolbar_me"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildViewController:(UIViewController *)childController imageNamed:(NSString *)imageName
{
    ALinNavigationController * nav = [[ALinNavigationController alloc]initWithRootViewController:childController];
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_sel",imageName]];
    childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    if ([childController isKindOfClass:[ProfileController class]]){
        [nav.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
        nav.navigationBar.shadowImage = [[UIImage alloc]init];
        nav.navigationBar.translucent = YES;
    }
    [self  addChildViewController:nav];
    
    
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([tabBarController.childViewControllers indexOfObject:viewController] == tabBarController.childViewControllers.count -2 ){
//        if ([UIDevice])
        return NO;
    }
    
    return YES;
}

@end


























