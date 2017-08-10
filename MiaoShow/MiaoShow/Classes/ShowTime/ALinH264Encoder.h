//
//  ALinH264Encoder.h
//  MiaoShow
//
//  Created by CJW on 17/8/10.
//  Copyright © 2017年 cjw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VideoToolbox/VideoToolbox.h>
@interface ALinH264Encoder : NSObject
-(void)initWithConfiguration;
-(void)initEncode:(int)width height:(int)height;
-(void)encode:(CMSampleBufferRef)sampleBuffer;
@end
