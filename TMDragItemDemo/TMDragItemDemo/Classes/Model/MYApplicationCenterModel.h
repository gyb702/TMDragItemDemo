//
//  MYApplicationCenterModel.h
//  MYShengYiJia
//
//  Created by weibo on 17/1/16.
//  Copyright © 2017年 MYun. All rights reserved.
//

#import "MYBaseModel.h"

@interface MYApplicationCenterModel : MYBaseModel
@property (copy, nonatomic) NSString *ModuleName;       //模块名
@property (strong, nonatomic) NSNumber *ModuleCode;     //模块编码
@property (strong, nonatomic) NSNumber *IsAvailable;    //是否可用
@property (strong, nonatomic) NSNumber *SortIndex;      //排序索引号

- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
