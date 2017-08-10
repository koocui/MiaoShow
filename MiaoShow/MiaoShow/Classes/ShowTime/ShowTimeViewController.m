//
//  ShowTimeViewController.m
//  MiaoShow
//
//  Created by CJW on 17/8/10.
//  Copyright © 2017年 cjw. All rights reserved.
//

#import "ShowTimeViewController.h"
#import <LFLiveKit.h>
@interface ShowTimeViewController ()<LFLiveSessionDelegate>
@property (weak, nonatomic) IBOutlet UIButton *beautifulBtn;
@property (weak, nonatomic) IBOutlet UIButton *livingBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

/* RTMP地址 */
@property (nonatomic,copy) NSString * rtmpUrl;
@property (nonatomic,strong)LFLiveSession * session;
@property (nonatomic,weak) UIView * livingPreView;

@end

@implementation ShowTimeViewController
#pragma mark - 懒加载

-(UIView*)livingPreView{
    if (!_livingPreView){
        UIView * livingpreView = [[UIView alloc]initWithFrame:self.view.bounds];
        livingpreView.backgroundColor = [UIColor clearColor];
        livingpreView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view insertSubview:livingpreView atIndex:0];
        _livingPreView = livingpreView;
    }
    return _livingPreView;
}
-(LFLiveSession*)session{
    if (!_session){
          /***   默认分辨率368 ＊ 640  音频：44.1 iphone6以上48  双声道  方向竖屏 ***/
         _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveVideoConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Medium2]];
        /**    自己定制高质量音频128K 分辨率设置为720*1280 方向竖屏 */
        /*
         LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
         audioConfiguration.numberOfChannels = 2;
         audioConfiguration.audioBitrate = LFLiveAudioBitRate_128Kbps;
         audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
         
         LFLiveVideoConfiguration *videoConfiguration = [LFLiveVideoConfiguration new];
         videoConfiguration.videoSize = CGSizeMake(720, 1280);
         videoConfiguration.videoBitRate = 800*1024;
         videoConfiguration.videoMaxBitRate = 1000*1024;
         videoConfiguration.videoMinBitRate = 500*1024;
         videoConfiguration.videoFrameRate = 15;
         videoConfiguration.videoMaxKeyframeInterval = 30;
         videoConfiguration.orientation = UIInterfaceOrientationPortrait;
         videoConfiguration.sessionPreset = LFCaptureSessionPreset720x1280;
         
         _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:videoConfiguration liveType:LFLiveRTMP];
         */
//        设置代理
        _session.delegate = self;
        _session.running = YES;
        _session.preView = self.livingPreView;
    }
    return _session;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}
-(void)setup{
    self.beautifulBtn.layer.cornerRadius = self.beautifulBtn.frame.size.height * 0.5;
    self.beautifulBtn.layer.masksToBounds = YES;
    self.livingBtn.backgroundColor = KeyColor;
    self.livingBtn.layer.cornerRadius = self.livingBtn.frame.size.height * 0.5;
    self.livingBtn.layer.masksToBounds = YES;
    self.statusLabel.numberOfLines = 0;
    //默认开启后置摄像头，怕我太帅；
    self.session.captureDevicePosition = AVCaptureDevicePositionBack;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//关闭直播
- (IBAction)close {
    if (self.session.state == LFLivePending || self.session.state == LFLiveStart){
        [self.session stopLive];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 开启/关闭美颜相机
- (IBAction)beautiful:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.session.beautyFace = !self.session.beautyFace;
}
// 切换前置/后置摄像头
- (IBAction)switchCamare:(UIButton *)sender {
    AVCaptureDevicePosition deviceposition = self.session.captureDevicePosition;
    self.session.captureDevicePosition = (deviceposition == AVCaptureDevicePositionBack) ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
    

}
- (IBAction)living:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected){
        LFLiveStreamInfo * stream = [LFLiveStreamInfo new];
        stream.url = @"rtmp://192.168.1.102:1935/rtmplive/room";
        self.rtmpUrl = stream.url;
        [self.session startLive:stream];
    }else{
        [self.session stopLive];
        self.statusLabel.text = [NSString stringWithFormat:@"状态: 直播被关闭\nRTMP: %@", self.rtmpUrl];
    }
}

#pragma mark -- LFStreamingSessionDelegate
/** live status changed will callback */
-(void)liveSession:(LFLiveSession *)session liveStateDidChange:(LFLiveState)state
{
    NSString * tempStatus;
    switch (state) {
        case LFLiveReady:
            tempStatus = @"准备中";
            break;
        case LFLivePending:
            tempStatus = @"连接中";
            break;
        case LFLiveStart:
            tempStatus = @"已连接";
            break;
        case LFLiveStop:
            tempStatus = @"已断开";
            break;
        case LFLiveError:
            tempStatus = @"连接出错";
            break;
        default:
            break;
    }
    self.statusLabel.text = [NSString stringWithFormat:@"状态:%@\nRTMP:%@",tempStatus,self.rtmpUrl];
}
-(void)liveSession:(LFLiveSession *)session debugInfo:(LFLiveDebug *)debugInfo{
    
}
-(void)liveSession:(LFLiveSession *)session errorCode:(LFLiveSocketErrorCode)errorCode{
    
}
@end







