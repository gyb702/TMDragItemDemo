//
//  MBHUDView.h
//  Notestand
//
//  Created by M B. Bitar on 9/30/12.
//  Copyright (c) 2012 progenius, inc. All rights reserved.
//

#import "MBAlertView.h"

typedef enum {
    MBAlertViewHUDTypeDefault,
    MBAlertViewHUDTypeActivityIndicator,
    MBAlertViewHUDTypeCheckmark,
    MBAlertViewHUDTypeExclamationMark,
    MBAlertViewHUDTypeLabelIcon,
    MBAlertViewHUDTypeImage,
    MBAlertViewHUDTypeImagePositive
} MBAlertViewHUDType;

@interface MBHUDView : MBAlertView
@property (nonatomic, assign) MBAlertViewHUDType hudType;
@property (nonatomic, assign) float hudHideDelay;
@property (nonatomic, assign) CGSize bodyOffset;
@property (nonatomic, strong) UILabel *iconLabel;
@property (nonatomic, strong) UIColor *backgroundColor;

// if you want to customize the HUD before showing, set show to NO, else setting to YES displays it right away
+(MBHUDView*)hudWithBody:(NSString*)body type:(MBAlertViewHUDType)type hidesAfter:(float)delay show:(BOOL)show;

+(MBHUDView*)cusHudWithBody:(NSString*)body type:(MBAlertViewHUDType)type hidesAfter:(float)delay show:(BOOL)show bgSize:(CGSize)bgSize cornerRadius:(CGFloat)cor fontSize:(CGFloat)fSize;

+(MBHUDView*)showError:(NSString*)body;
+(MBHUDView*)showSuccess:(NSString*)body;
+(MBHUDView*)show:(NSString*)body;
+(MBHUDView*)showWait:(NSString*)body;

@end
