//
//  MYUtils.h
//  MYAppBaseFrame
//
//  Created by weibo on 15/12/14.
//  Copyright © 2015年 MYun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MYChatUploadType) {
    MYChatUploadTypeImg,
    MYChatUploadTypeVoice,
};
typedef void(^ChatOSSUploadSuccessBlcok)(NSString *);

@interface MYUtils : NSObject


#pragma mark -获取view的controller
+ (UIViewController *)getControllerForView:(UIView *)view;

/**
 *  用于返回首页新VC列表
 *
 *  @param curVC 当前所处的vc
 *  @param newVC 即将要push的vc
 *
 *  @return 新组合的vc
 */
#pragma mark -用于返回首页新VC列表
+ (NSMutableArray *)viewControllersForBackToHome:(UIViewController *)curVC newVC:(UIViewController *)newVC;

/**
 *  设置view的圆角和边框阴影
 *  viewLayer 例button.layer
 *  shadow 是否显示边框（带阴影）
 */
#pragma mark -设置view的圆角和边框阴影
+ (void)roundedLayer:(CALayer *)viewLayer radius:(float)radius shadow:(BOOL)shadow;
/**
 *  设置view的圆角和边框阴影
 *  viewLayer 例button.layer
 *  borderWidth 边框宽度
 *  shadow 是否显示边框（带阴影）
 */
#pragma mark -设置view的圆角和边框阴影
+ (void)roundedLayer:(CALayer *)viewLayer radius:(float)radius borderWidth:(CGFloat)borderWidth shadow:(BOOL)shadow;
/**
 *  设置view的圆角和边框阴影
 *  viewLayer 例button.layer
 *  borderWidth 边框宽度
 *  borderColor 边框颜色
 *  shadow 是否显示边框（带阴影）
 */
#pragma mark -设置view的圆角和边框阴影
+ (void)roundedLayer:(CALayer *)viewLayer radius:(float)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor shadow:(BOOL)shadow;


@end
