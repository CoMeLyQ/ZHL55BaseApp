//
//  QPickerView.h
//  55likeLibDemo
//
//  Created by 55like on 2017/9/13.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import "QBaseView.h"

@interface QPickerView : QBaseView


/**
 使用自定义数据时请调用此方法初始化数据中的key值
 QPickerModel_name:一级滚动的标题key
 QPickerModel_city:对应一级title的数组key
 QPickerCityModel_name：二级滚动的标题key
 QPickerCityModel_town：对应二级title的数组key
 QPickerTownModel_name：三级级滚动的标题key
 */
+(void)setModelKeyWithQPickerModel_name:(NSString *)QPickerModel_name
                      QPickerModel_city:(NSString *)QPickerModel_city
                  QPickerCityModel_name:(NSString *)QPickerCityModel_name
                  QPickerCityModel_town:(NSString *)QPickerCityModel_town
                  QPickerTownModel_name:(NSString *)QPickerTownModel_name;
/**
 使用默认数据
 */
+(QPickerView *)showQPickerViewWithdDtaBlock:(void(^)(NSMutableArray * titleArray,NSMutableArray *indexArray,NSMutableArray *indexDataArray))dataBlock;
/**
 使用默认数据并带搜索
 */
+(QPickerView *)showQPickerViewWithdSeacherScrollToProvince:(NSString *)Province city:(NSString *)city town:(NSString *)town dataBlock:(void(^)(NSMutableArray * titleArray,NSMutableArray *indexArray,NSMutableArray *indexDataArray))dataBlock;
/**
 自定义数据
 */
+(QPickerView *)showQPickerViewWithTitle:(NSString *)title Data:(NSArray *)data dataBlock:(void(^)(NSMutableArray * titleArray,NSMutableArray *indexArray,NSMutableArray *indexDataArray))dataBlock;

/** 
 自定义数据并带搜索
 */
+(QPickerView *)showSeachQPickerViewWithTitle:(NSString *)title Data:(NSArray *)data scrollToProvince:(NSString *)Province city:(NSString *)city town:(NSString *)town dataBlock:(void(^)(NSMutableArray * titleArray,NSMutableArray *indexArray,NSMutableArray *indexDataArray))dataBlock;
/**
 总方法
 title 标题
 data 需要的数据（必须NSArray）传nil用默认数据
 Province 默认滚动到一级对应的title位置  传nil不搜索
 city 默认滚动到一级对应的Province二级title位置  传nil不搜索二级
 town 默认滚动到一级对应的Province二级city位置三级title位置  传nil不搜索三级
 topview 点击背景view是否收起视图
 dataBlock 返回的数据（titleArray：@[@"一级的title",@"二级的title",@"三级的title"]）
                   （indexArray：@[@"一级的row",@"二级的row",@"三级的row"]）
                   （indexDataArray：@[@"一级的Dictionary",@"二级的Dictionary",@"三级的Dictionary"]）
                   （如果三级为空为@[@"一级的",@"二级的"]）
 */
+(QPickerView *)showQPickerViewWithTitle:(NSString *)title
                                    Data:(NSArray *)data
                        scrollToProvince:(NSString *)Province
                                    city:(NSString *)city
                                    town:(NSString *)town
                               topBGview:(BOOL)topview
                               dataBlock:(void(^)(NSMutableArray * titleArray,NSMutableArray *indexArray,NSMutableArray *indexDataArray))dataBlock;

@end
