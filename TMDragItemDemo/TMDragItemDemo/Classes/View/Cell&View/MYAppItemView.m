//
//  MYAppItemView.m
//  MYShengYiJia
//
//  Created by weibo on 17/1/22.
//  Copyright © 2017年 MYun. All rights reserved.
//

#import "MYAppItemView.h"
#import "AppConfig.h"

@implementation MYAppItemView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.img = [[UIImageView alloc] init];
        [self addSubview:self.img];
        
//        self.icon = [[UIImageView alloc] init];
//        [self addSubview:self.icon];
        
        self.name = [[UILabel alloc] init];
        self.name.textColor = __kDefaultTitleColor;
        self.name.font = [UIFont systemFontOfSize:10.0];
        self.name.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.name];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat padding = 3;

    CGFloat nW = self.width;
    CGFloat nH = 26;
    CGFloat nX = 0;
    CGFloat nY = self.height - nH - padding;
    self.name.frame = CGRectMake(nX, nY, nW, nH);
//    self.name.backgroundColor = __kMYRedColor;
    
    CGFloat iH = self.height - nH - padding*2;
    CGFloat iW = iH;
    CGFloat iX = (self.width - iW)/2;
    CGFloat iY = padding;
    self.img.frame = CGRectMake(iX, iY, iW, iH);
    [MYUtils roundedLayer:self.img.layer radius:self.img.width/2 borderWidth:0.0 borderColor:[UIColor clearColor] shadow:NO];
    self.img.backgroundColor = __kMYGreenColor;
    
//    CGFloat icH = 12;
//    CGFloat icW = icH;
//    CGFloat icX = self.width - icW*2.2;
//    CGFloat icY = CGRectGetMaxY(self.img.frame) - icH;
//    self.icon.frame = CGRectMake(icX, icY, icW, icH);
//    [MYUtils roundedLayer:self.icon.layer radius:self.icon.width/2 borderWidth:0.0 borderColor:[UIColor clearColor] shadow:NO];
//    self.icon.backgroundColor = __kMYYellowColor;
}

//- (void)awakeFromNib{
//    [self initView];
//}

- (void)initView{

}

@end
