//
//  BaseModel.m
//  ZHLBaseApp
//
//  Created by zzz on 2017/5/15.
//  Copyright © 2017年 zzz. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

// 根据字典内提供的数据分别创建出对应的model来获取数据
/* 根据数据字典返回model */
+ (id)modelWithDictionary:(NSDictionary *)dic {

    __strong Class model = [[[self class] alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
    
}




@end
