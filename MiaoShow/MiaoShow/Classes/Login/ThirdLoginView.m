//
//  ThirdLoginView.m
//  MiaoShow
//
//  Created by CJW on 17/7/7.
//  Copyright © 2017年 cjw. All rights reserved.
//

#import "ThirdLoginView.h"



@implementation ThirdLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup{
    UIImageView * sina = [self creatImageView:@"wbLoginicon_60x60" tag:LoginTypeSins];
    UIImageView * qq = [self creatImageView:@"qqloginicon_60x60" tag:LoginTypeQQ];
    UIImageView * weChat = [self creatImageView:@"wxloginicon_60x60" tag:LoginTypeWechat];
    [self addSubview:sina];
    [self addSubview:qq];
    [self addSubview:weChat];
    
    [sina mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.equalTo(@60);
    }];
    [qq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sina);
        make.right.equalTo(sina.mas_left).offset(-20);
        make.size.equalTo(sina);
    }];
    
    [weChat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sina);
        make.left.equalTo(sina.mas_right).offset(20);
        make.size.equalTo(sina);
    }];
}


-(UIImageView*)creatImageView:(NSString*)imageName tag:(NSInteger)tag {
    UIImageView * imgeV = [[UIImageView alloc]init];
    imgeV.image = [UIImage imageNamed:imageName];
    imgeV.tag = tag;
    imgeV.userInteractionEnabled = YES;
    [imgeV addGestureRecognizer:[[UIGestureRecognizer alloc]initWithTarget:self action:@selector(click:)]];
    return imgeV;
}

-(void)click:(UITapGestureRecognizer*)tap{
    if (self.clickLogin) {
        self.clickLogin(tap.view.tag);
    }
}

@end
