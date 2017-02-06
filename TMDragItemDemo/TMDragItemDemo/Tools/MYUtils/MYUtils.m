//
//  MYUtils.m
//  MYAppBaseFrame
//
//  Created by weibo on 15/12/14.
//  Copyright © 2015年 MYun. All rights reserved.
//

#import "MYUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>
#import "AppConfig.h"

@implementation MYUtils

+ (UIViewController *)getControllerForView:(UIView *)view {
    
    for (UIView *next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

+ (void)roundedLayer:(CALayer *)viewLayer radius:(float)radius shadow:(BOOL)shadow
{
    [viewLayer setMasksToBounds:YES];
    [viewLayer setCornerRadius:radius];
    [viewLayer setBorderColor:[__kColorWithRGB(180, 180, 180,1) CGColor]];
    [viewLayer setBorderWidth:0.6f];
    if(shadow)
    {
        [viewLayer setShadowColor:[__kColorWithRGB(0, 0, 0,1) CGColor]];
        [viewLayer setShadowOffset:CGSizeMake(50, 50)];
        [viewLayer setShadowOpacity:1];
        [viewLayer setShadowRadius:1.0];
    }
    return;
}

+ (void)roundedLayer:(CALayer *)viewLayer radius:(float)radius borderWidth:(CGFloat)borderWidth shadow:(BOOL)shadow
{
    [viewLayer setMasksToBounds:YES];
    [viewLayer setCornerRadius:radius];
    [viewLayer setBorderColor:[__kColorWithRGB(180, 180, 180,1) CGColor]];
    [viewLayer setBorderWidth:borderWidth];
    if(shadow)
    {
        [viewLayer setShadowColor:[__kColorWithRGB(0, 0, 0,1) CGColor]];
        [viewLayer setShadowOffset:CGSizeMake(50, 50)];
        [viewLayer setShadowOpacity:1];
        [viewLayer setShadowRadius:1.0];
    }
    return;
}

+ (void)roundedLayer:(CALayer *)viewLayer radius:(float)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor shadow:(BOOL)shadow
{
    [viewLayer setMasksToBounds:YES];
    [viewLayer setCornerRadius:radius];
    if (borderColor) {
        [viewLayer setBorderColor:[borderColor CGColor]];
    }else{
        [viewLayer setBorderColor:[__kColorWithRGB(180, 180, 180,1) CGColor]];
    }
    [viewLayer setBorderWidth:borderWidth];
    if(shadow)
    {
        [viewLayer setShadowColor:[__kColorWithRGB(0, 0, 0,1) CGColor]];
        [viewLayer setShadowOffset:CGSizeMake(50, 50)];
        [viewLayer setShadowOpacity:1];
        [viewLayer setShadowRadius:1.0];
    }
    return;
}


@end
