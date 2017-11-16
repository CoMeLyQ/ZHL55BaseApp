//
//  QBaseData.h
//  55likeLibDemo
//
//  Created by 55like on 2017/9/28.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QBaseData : NSObject
/**单例初始化*/
+(id)Share;
/**一级下标题数据的Key*/
@property (nonatomic,strong)NSString * QPickerModel_name;
/**二级下对应的数组的Key*/
@property (nonatomic,strong)NSString * QPickerModel_city;
/**二级下标题的Key*/
@property (nonatomic,strong)NSString * QPickerCityModel_name;
/**对应的三级下数组的Key*/
@property (nonatomic,strong)NSString * QPickerCityModel_town;
/**三级下标题数据的Key*/
@property (nonatomic,strong)NSString * QPickerTownModel_name;
@end


