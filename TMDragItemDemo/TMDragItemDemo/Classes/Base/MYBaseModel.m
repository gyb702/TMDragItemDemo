//
//  MYBaseModel.m
//  MYAppBaseFrame
//
//  Created by weibo on 15/12/14.
//  Copyright © 2015年 MYun. All rights reserved.
//

#import "MYBaseModel.h"

@implementation MYBaseModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    // forOverride
    self = [MYBaseModel objectWithKeyValues:dict];
    return self;
}


@end
