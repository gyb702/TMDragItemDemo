//
//  AppConfig.h
//  MYAppBaseFrame
//
//  Created by weibo on 15/12/11.
//  Copyright © 2015年 MYun. All rights reserved.
//========app各模块配置文件=========

#ifndef AppConfig_h
#define AppConfig_h

#import "UIView+Extension.h"
#import "MBHUDView.h"
#import "MYUtils.h"

//演示模式
#define __DEMO_MODE__           @YES  //@NO

//============定义调试打印宏===========
#ifdef DEBUG
#define DLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

//    //调试
//    #define DebugMessage 1
#else
#define DLog( s, ... )
//    //调试
//    #define DebugMessage 0
#endif

//============弱引用化===========
#define WeakObj(o) __weak typeof(o) o##Weak = o

//===============屏幕尺寸=============
#define __kScreenBounds     [[UIScreen mainScreen]bounds]
#define __kScreenWidth      [[UIScreen mainScreen]bounds].size.width
#define __kScreenHeight     [[UIScreen mainScreen]bounds].size.height
#define NavigationBarHeight 64
#define BottomTabBarHeight  49

//===============屏幕适配==============
#define upIphone5     (__kScreenHeight == 568)
#define upIphone6     (__kScreenHeight >= 568)

//============================颜色===============================
#define __kColorWithRGB(x,y,z,a)  [UIColor colorWithRed:x/255.0 green:y/255.0  blue:z/255.0  alpha:(a/1)]   //RGB方式

#define __kColorWithRHedix(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]    //已十六进制的形式设置颜色


#define __kDefaultTitleColor            __kColorWithRHedix(0x333333)
#define __kDefaultSecondTitleColor      __kColorWithRHedix(0x666666)
#define __kDefaultContentColor          __kColorWithRHedix(0x888888)
#define __kDefaultBackgroundGrayColor   __kColorWithRHedix(0xf1f5f8)
#define __kDefaultRongYunTalkBGColor    __kColorWithRHedix(0xEBEBEB)
#define __kMYYellowColor                __kColorWithRHedix(0xffcc66)
#define __kMYRedColor                   __kColorWithRHedix(0xDA232A)
#define __kMYGreenColor                 __kColorWithRHedix(0x33cc99)
#define __kMYLineColor                  __kColorWithRHedix(0xcacaca)
#define __kMYYellowTitleColor           __kColorWithRHedix(0xf1a50f)
#define __kMYBlueTitleColor             __kColorWithRHedix(0x1386E7)
#define __kMYGrayDarkTransparentColor   __kColorWithRGB(124, 122, 118, 0.5)
#define __kMYGrayDarkColor              __kColorWithRHedix(0x7c7a76)
#define __kDefaultPlaceColor            __kColorWithRHedix(0x999999)
//导航状态栏背景颜色
#define __kNavigationBarColor   [UIColor whiteColor]
//导航栏Item颜色
#define __kNavigationItemColor  [UIColor lightGrayColor]
//导航栏Item文字大小
#define __kNavigationItemSize   [UIFont systemFontOfSize:14]
//导航栏标题大小
#define __kNavigationTitleSize  [UIFont systemFontOfSize:18]
//导航栏标题颜色
#define __kNavigationTitleColor  [UIColor grayColor]
//分割线颜色
#define __kSeparatorColor  __kColorWithRGB(213, 213, 213, 1)


//============================字体===============================
//默认最大标题自提
#define __kMYTitleFont [UIFont systemFontOfSize:14.0]
//tabbar字体
#define __kMYTabBarItemFont [UIFont fontWithName:@"Helvetica" size:13.0]


#endif /* AppConfig_h */
