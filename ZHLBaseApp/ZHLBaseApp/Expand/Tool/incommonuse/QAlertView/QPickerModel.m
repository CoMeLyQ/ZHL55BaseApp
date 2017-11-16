//
//  QPickerModel.m
//  55likeLibDemo
//
//  Created by 55like on 2017/9/13.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import "QPickerModel.h"





#pragma mark - QPickerModel
@implementation QPickerModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    
    //key 不能修改 修改对应的value QPickerCityModel和QPickerTownModel同理
    return @{//[[QBaseData Share] QPickerModel_name] == nil所以崩溃 初始化前先赋值调用[QPickerView setModelKeyWithQPickerxxxx...]方法 或者 改为@“name”：@“xxxx” 下边所有[QBaseData Share]同理
             @"name": [[QBaseData Share] QPickerModel_name],//改为数据一级下所要显示的Key
             @"city": [[QBaseData Share] QPickerModel_city]//改为数据二级下数组的Key
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"city": [QPickerCityModel class]
             };
}
-(NSArray *)city{
    
    if (!_city) {
        
        _city = [[NSArray alloc]init];
        
    }
    
    return _city;
}

@end

#pragma mark - QPickerCityModel
@implementation QPickerCityModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{
             @"name": [[QBaseData Share] QPickerCityModel_name],//改为数据二级下所要显示的Key
             @"town": [[QBaseData Share] QPickerCityModel_town]//改为数据三级下数组的Key
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"town": [QPickerTownModel class]
             };
}
-(NSArray *)town{
    
    if (!_town) {
        
        _town = [[NSArray alloc]init];
        
    }
    
    return _town;
}
@end

#pragma mark - QPickerTownModel
@implementation QPickerTownModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"name": [[QBaseData Share] QPickerTownModel_name]//改为数据三级下所要显示的Key
             };
}

@end
