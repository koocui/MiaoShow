//
//  LoginViewController.m
//  MiaoShow
//
//  Created by CJW on 17/7/7.
//  Copyright © 2017年 cjw. All rights reserved.
//

#import "LoginViewController.h"
#import "ThirdLoginView.h"
#import "MainViewController.h"

@interface LoginViewController ()
/* player */
@property (nonatomic,strong)IJKFFMoviePlayerController * player;
/** 第三方登录 */
@property (nonatomic, weak) ThirdLoginView *thirdView;
/** 快速通道 */
@property (nonatomic, weak) UIButton *quickBtn;
/** 封面图片 */
@property (nonatomic, weak) UIImageView *coverView;
@end

@implementation LoginViewController

#pragma mark - 懒加载
-(IJKFFMoviePlayerController*)player{
    if (!_player){
        NSString * path = arc4random_uniform(10) % 2 ? @"login_video":@"loginmovie";
        IJKFFMoviePlayerController * player = [[IJKFFMoviePlayerController alloc]initWithContentURLString:[[NSBundle mainBundle] pathForResource:path ofType:@"map4"] withOptions:[IJKFFOptions optionsByDefault]];
        
        player.view.frame = self.view.bounds;
        
        player.scalingMode = IJKMPMovieScalingModeFill;
        
        [self.view addSubview:player.view];
        
        //设置自动播放
        
        player.shouldAutoplay = NO;
        
        [player prepareToPlay];
        
        _player = player;
    }
    return _player;
}

- (ThirdLoginView *)thirdView
{
    if (!_thirdView){
        ThirdLoginView * third = [[ThirdLoginView alloc]initWithFrame:CGRectMake(0, 0, 400, 200)];
        [third setClickLogin:^(LoginType type) {
              [self loginSuccess];
        }];
        
        third.hidden = YES;
        [self.view addSubview:third];
        _thirdView = third;
    }
    return _thirdView;
}
-(UIButton*)quickBtn{
    if (!_quickBtn){
        UIButton * btn = [[UIButton alloc]init];
        btn.backgroundColor = [UIColor clearColor];
        btn.layer.borderWidth = 1;
        btn.layer.backgroundColor = [UIColor yellowColor].CGColor;
        [btn setTitle:@"CJW快速通道" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(loginSuccess) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn.hidden = YES;
        _quickBtn = btn;
    }
    return _quickBtn;
}
- (UIImageView *)coverView
{
    if (!_coverView) {
        UIImageView *cover = [[UIImageView alloc] initWithFrame:self.view.bounds];
        cover.image = [UIImage imageNamed:@"LaunchImage"];
        [self.player.view addSubview:cover];
        _coverView = cover;
    }
    return _coverView;
}
#pragma mark - lifr circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.player shutdown];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.player.view removeFromSuperview];
    self.player = nil;
}
-(void)setup{
    
}


#pragma mark - private method
-(void)initObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidiChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:nil];
}

-(void)stateDidiChange{
    if ((self.player.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0){
        if (!self.player.isPlaying){
            self.coverView.frame = self.view.bounds;
            [self.view insertSubview:self.coverView atIndex:0];
            [self.player play];
//            dispatch_after(DISPATCH_TIME_NOW, (int64_t), <#^(void)block#>)
        }
    }
}


- (void)didFinish
{
    // 播放完之后, 继续重播
    [self.player play];
}

// 登录成功
- (void)loginSuccess
{
//    [self showHint:@"登录成功"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:[[MainViewController alloc] init] animated:NO completion:^{
            [self.player stop];
            [self.player.view removeFromSuperview];
            self.player = nil;
        }];
    });
    
}

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

@end











