//
//  QPickerModel.h
//  55likeLibDemo
//
//  Created by 55like on 2017/9/13.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QBaseData.h"


@interface QPickerModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *city;
+ (NSDictionary *)modelCustomPropertyMapper ;
@end

@interface QPickerCityModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *town;
+ (NSDictionary *)modelCustomPropertyMapper;
@end


@interface QPickerTownModel : NSObject

@property (nonatomic, copy) NSString *name;
+ (NSDictionary *)modelCustomPropertyMapper;
@end
