//
//  QPickerView.m
//  55likeLibDemo
//
//  Created by 55like on 2017/9/13.
//  Copyright © 2017年 55like lj. All rights reserved.
//


#import "QPickerView.h"
#import "QPickerModel.h"
#import "YYModel.h"

@interface QPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong)UIPickerView * pickerview;
//传入数据
@property (nonatomic,strong)NSArray * allArray;
//所有数据
@property (nonatomic,strong)NSMutableArray * dataArray;
//返回数据
@property (nonatomic,copy)void(^pickerDataBlock)(NSMutableArray * titleArray,NSMutableArray *indexArray,NSMutableArray *indexDataArray);
@end



@implementation QPickerView
{
    NSInteger rowOfProvince; // 保存选中的省份对应的下标
    NSInteger rowOfCity;     // 保存选中市对应的下标
    NSInteger rowOfTown;     // 保存选中区对应的下标
    NSMutableArray * titleArray;// 保存选中的title数组 1、2、3
    NSMutableArray * indexArray;// 保存选中下标数组 1、2、3
    NSMutableArray * indexDataArray;// 保存选中对应的下标数据数组 1、2、3
}
/**
 使用默认数据
 */
+(QPickerView *)showQPickerViewWithdDtaBlock:(void(^)(NSMutableArray * titleArray,NSMutableArray *indexArray,NSMutableArray *indexDataArray))dataBlock{
    
    [QPickerView setModelKeyWithQPickerModel_name:@"name" QPickerModel_city:@"subs" QPickerCityModel_name:@"name" QPickerCityModel_town:@"thrs" QPickerTownModel_name:@"name"];
    return [QPickerView showQPickerViewWithTitle:@"请选择地址" Data:nil dataBlock:dataBlock];
}
+(QPickerView *)showQPickerViewWithdSeacherScrollToProvince:(NSString *)Province city:(NSString *)city town:(NSString *)town dataBlock:(void(^)(NSMutableArray * titleArray,NSMutableArray *indexArray,NSMutableArray *indexDataArray))dataBlock{
    
    [QPickerView setModelKeyWithQPickerModel_name:@"name" QPickerModel_city:@"subs" QPickerCityModel_name:@"name" QPickerCityModel_town:@"thrs" QPickerTownModel_name:@"name"];
    return [QPickerView showSeachQPickerViewWithTitle:@"请选择地址" Data:nil scrollToProvince:Province city:city town:town dataBlock:dataBlock];
}
+(QPickerView *)showQPickerViewWithTitle:(NSString *)title Data:(NSArray *)data dataBlock:(void(^)(NSMutableArray * titleArray,NSMutableArray *indexArray,NSMutableArray *indexDataArray))dataBlock{
    
    return [QPickerView showSeachQPickerViewWithTitle:title Data:data scrollToProvince:nil city:nil town:nil dataBlock:dataBlock];
}


+(QPickerView *)showSeachQPickerViewWithTitle:(NSString *)title Data:(NSArray *)data scrollToProvince:(NSString *)Province city:(NSString *)city town:(NSString *)town dataBlock:(void(^)(NSMutableArray * titleArray,NSMutableArray *indexArray,NSMutableArray *indexDataArray))dataBlock{
    
    return [QPickerView showQPickerViewWithTitle:title Data:data scrollToProvince:Province city:city town:town topBGview:YES dataBlock:dataBlock];
}

+(QPickerView *)showQPickerViewWithTitle:(NSString *)title Data:(NSArray *)data scrollToProvince:(NSString *)Province city:(NSString *)city town:(NSString *)town topBGview:(BOOL)topview dataBlock:(void(^)(NSMutableArray * titleArray,NSMutableArray *indexArray,NSMutableArray *indexDataArray))dataBlock{
    
    
    QPickerView * qpickerview = [[QPickerView alloc]init];
    qpickerview.pickerDataBlock = dataBlock;
    qpickerview.allArray = data;
    if (data) {
        qpickerview.dataArray = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in data) {
            QPickerModel *proviceModel = [QPickerModel yy_modelWithDictionary:dic];
            [qpickerview.dataArray addObject:proviceModel];
        }
    }
    [qpickerview isEqualKey];
    qpickerview.title = title;
    qpickerview.topHide = topview;
    [qpickerview setterUI];
    [qpickerview show];
    [qpickerview scrollToProvince:Province city:city town:town];
    return qpickerview;
}
+(void)setModelKeyWithQPickerModel_name:(NSString *)QPickerModel_name
                      QPickerModel_city:(NSString *)QPickerModel_city
                  QPickerCityModel_name:(NSString *)QPickerCityModel_name
                  QPickerCityModel_town:(NSString *)QPickerCityModel_town
                  QPickerTownModel_name:(NSString *)QPickerTownModel_name{
 
    [[QBaseData Share] setQPickerModel_name:QPickerModel_name];
    [[QBaseData Share] setQPickerModel_city:QPickerModel_city];
    [[QBaseData Share] setQPickerCityModel_name:QPickerCityModel_name];
    [[QBaseData Share] setQPickerCityModel_town:QPickerCityModel_town];
    [[QBaseData Share] setQPickerTownModel_name:QPickerTownModel_name];
 
}
-(void)setterUI{
    
    [super setterUI];
    
    self.pickerview.frame = CGRectMake(0, QA_Header_H, self.mainView.frame.size.width, QA_Row_H);
    [self scrollToRow:0 secondRow:0 thirdRow:0];
}

-(void)okAction{
    
  
    if (self.pickerDataBlock) {
        self.pickerDataBlock(titleArray,indexArray,indexDataArray);
    }
    
    
    [super okAction];
    
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    
    return 3;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    QPickerModel * provinceModel = self.dataArray[rowOfProvince];
    if (component == 0) {
        //返回省个数
        return self.dataArray.count;
    }
    if (provinceModel.city.count > 0) {
       QPickerCityModel * cityModel = provinceModel.city[rowOfCity];
        if (component == 1) {
            //返回市个数
            return provinceModel.city.count;
        }
        if (cityModel.town.count > 0) {
            
            if (component == 2) {
                //返回区个数
                return cityModel.town.count;
            }
        }
    }
    return 0;
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (QA_SCREEN_W - 30) / 3, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16.0f];
    label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return label;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *showTitleValue = @"";
    if (component == 0)
    {
        QPickerModel * provinceModel = self.dataArray[row];
        showTitleValue = provinceModel.name;
        
    }
    if (component == 1)
    {
        QPickerModel * provinceModel = self.dataArray[rowOfProvince];
        QPickerCityModel * cityModel = provinceModel.city[row];
        showTitleValue = cityModel.name;
    }
    if (component == 2)
    {
        QPickerModel * provinceModel = self.dataArray[rowOfProvince];
        QPickerCityModel * cityModel = provinceModel.city[rowOfCity];
        QPickerTownModel * townModel = cityModel.town[row];
        showTitleValue = townModel.name;
    }
    return showTitleValue;
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    switch (component) {
        case 0:
        {
            rowOfProvince = row;
            rowOfCity = 0;
            rowOfTown = 0;
        }
            break;
        case 1:
        {
            rowOfCity = row;
            rowOfTown = 0;
        }
            break;
        case 2:
        {
            rowOfTown = row;
        }
            break;
        default:
            break;
    }
    // 滚动到指定行
    [self scrollToRow:rowOfProvince secondRow:rowOfCity thirdRow:rowOfTown];
    
    //如果要滑动调用请开启此代码
    if (false) {
        if (self.pickerDataBlock) {
            self.pickerDataBlock(titleArray,indexArray,indexDataArray);
        }
    }
}
#pragma mark - 滚动到指定行
- (void)scrollToRow:(NSInteger)firstRow secondRow:(NSInteger)secondRow thirdRow:(NSInteger)thirdRow {
    
    if (firstRow < 0) {
        firstRow = 0;
    }
    if (secondRow < 0) {
        secondRow = 0;
    }
    if (thirdRow < 0) {
        thirdRow = 0;
    }
    //    void(^pickerDataBlock)(NSMutableArray * titleArray,NSMutableArray *indexArray,NSMutableArray *indexDataArray);
    titleArray = [[NSMutableArray alloc]init];
    indexArray = [[NSMutableArray alloc]init];
    indexDataArray = [[NSMutableArray alloc]init];
    if (firstRow < self.dataArray.count)
    {
        rowOfProvince = firstRow;
        QPickerModel *provinceModel = self.dataArray[firstRow];
        NSDictionary *provienceData = self.allArray[firstRow];
        //第二级的标题
        [titleArray addObject:provinceModel.name];
        //第二级坐标str
        [indexArray addObject:[NSString stringWithFormat:@"%ld",firstRow]];
        //第二级数据
        if (provienceData) {
          [indexDataArray addObject:provienceData];
        }
        [self.pickerview reloadComponent:1];
        if (secondRow < provinceModel.city.count)
        {
            rowOfCity = secondRow;
            QPickerCityModel *cityModel = provinceModel.city[secondRow];
            NSDictionary * cityData = provienceData[[[QPickerModel modelCustomPropertyMapper] valueForJSONStrKey:@"city"]][secondRow];
            //第二级的标题
            [titleArray addObject:cityModel.name];
            //第二级坐标str
            [indexArray addObject:[NSString stringWithFormat:@"%ld",secondRow]];
            //第二级数据
            if (cityData) {
                [indexDataArray addObject:cityData];
            }
            [self.pickerview reloadComponent:2];
            if (thirdRow < cityModel.town.count)
            {
                rowOfTown = thirdRow;
                QPickerTownModel * townModel = cityModel.town[thirdRow];
                NSDictionary * townData = cityData[[[QPickerCityModel modelCustomPropertyMapper] valueForJSONStrKey:@"town"]][thirdRow];
                //第三级的标题
                [titleArray addObject:townModel.name];
                //第三级坐标str
                [indexArray addObject:[NSString stringWithFormat:@"%ld",thirdRow]];
                //第三级数据
                if (townData) {
                    
                  [indexDataArray addObject:townData];
                }
                [self.pickerview selectRow:firstRow inComponent:0 animated:YES];
                [self.pickerview selectRow:secondRow inComponent:1 animated:YES];
                [self.pickerview selectRow:thirdRow inComponent:2 animated:YES];
            }else{
                
                
                [self.pickerview reloadComponent:2];
                
            }
        }else{
            
            [self.pickerview reloadComponent:2];
            [self.pickerview reloadComponent:1];
            
        }
    }else{
        
        
        [self.pickerview reloadAllComponents];
        
    }
    
}
#pragma mark - 滚动到文字匹配行
//相等
- (void)scrollToProvince:(NSString *)Province city:(NSString *)city town:(NSString *)town{
    
    if (Province.length > 0)
    {
        
        for (int i = 0; i < self.dataArray.count; i++)
        {
            
            QPickerModel * provinceModel = self.dataArray[i];
            
            if ([Province isEqualToString:provinceModel.name])
            {
                
                rowOfProvince = i;
                [self.pickerview selectRow:rowOfProvince inComponent:0 animated:YES];
                for (int j = 0; j < provinceModel.city.count; j ++)
                {
                    
                    QPickerCityModel * cityModel = provinceModel.city[j];
                    if ([city isEqualToString:cityModel.name])
                    {
                        rowOfCity = j;
                        [self.pickerview selectRow:rowOfProvince inComponent:0 animated:YES];
                        [self.pickerview selectRow:rowOfCity inComponent:1 animated:YES];
                        for (int o = 0; o < cityModel.town.count; o ++)
                        {
                            
                            QPickerTownModel * townModel = cityModel.town[o];
                            if ([town isEqualToString:townModel.name])
                            {
                                rowOfTown = o;
                                [self.pickerview selectRow:rowOfProvince inComponent:0 animated:YES];
                                [self.pickerview selectRow:rowOfCity inComponent:1 animated:YES];
                                [self.pickerview selectRow:rowOfTown inComponent:2 animated:YES];
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    [self scrollToRow:rowOfProvince secondRow:rowOfCity thirdRow:rowOfTown];
    
    
}
//搜索
- (void)scrollToSeachProvince:(NSString *)Province city:(NSString *)city town:(NSString *)town{
    
    if (Province.length > 0)
    {
        
        for (int i = 0; i < self.dataArray.count; i++)
        {
            
            QPickerModel * provinceModel = self.dataArray[i];
            
            if ([Province containsString:provinceModel.name])
            {
                
                rowOfProvince = i;
                [self.pickerview selectRow:rowOfProvince inComponent:0 animated:YES];
                [self.pickerview reloadComponent:1];
                for (int j = 0; j < provinceModel.city.count; j ++)
                {
                    
                    QPickerCityModel * cityModel = provinceModel.city[j];
                    
                    if ([city containsString:cityModel.name])
                    {
                        
                        rowOfCity = j;
                       [self.pickerview selectRow:rowOfCity inComponent:1 animated:YES];
                        [self.pickerview reloadComponent:2];
                        for (int o = 0; o < cityModel.town.count; o ++)
                        {
                            
                            QPickerTownModel * townModel = cityModel.town[o];
                            
                            if ([town containsString:townModel.name])
                            {
                                
                                rowOfTown = o;
                                [self.pickerview selectRow:rowOfTown inComponent:2 animated:YES];
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    
}
-(NSMutableArray *)dataArray{
    
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in self.allArray) {
            QPickerModel *proviceModel = [QPickerModel yy_modelWithDictionary:dic];
            [_dataArray addObject:proviceModel];
        }

        
    }
    
    return _dataArray;
}
-(UIPickerView *)pickerview{
    
    if (!_pickerview) {

        UIPickerView * pickerview = [[UIPickerView alloc]init];
        pickerview.backgroundColor = [UIColor whiteColor];
        pickerview.delegate = self;
        pickerview.dataSource = self;
        [self.mainView addSubview:pickerview];
        _pickerview = pickerview;
    
    }
    return _pickerview;
}
-(NSArray *)allArray{
    
    if (!_allArray) {
        _allArray = [[NSArray alloc]init];
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"AppConfig"ofType:@"json"];
        //根据文件路径读取数据
        NSData *jdata = [[NSData alloc]initWithContentsOfFile:filePath];
        //格式化成json数据
        _allArray = [NSJSONSerialization JSONObjectWithData:jdata options:NSJSONReadingAllowFragments error:nil];
    }
    
    return _allArray;
}
-(void)isEqualKey{
    
    if (self.allArray.count > 0) {
        NSArray * collapseArr = @[];
        NSDictionary * dic =  self.allArray[0];
        if (dic[[[QPickerModel modelCustomPropertyMapper] valueForJSONStrKey:@"name"]] == nil) {
            /**
             点进modelCustomPropertyMapper修改name的value，改为数据中一级、二级、三级所要显示的key（不推荐） 或者用单例初始化value（推荐）
             */
            NSLog(@"\n==========*****========\n在此处崩溃，赶紧来看看！！！\n在此处崩溃，赶紧来看看！！！\n在此处崩溃，赶紧来看看！！！\n不知道在哪就 打全局断点或者全局搜索“collapseArr[1]”\n========*****========");
            NSLog(@"%@",collapseArr[1]);
            
        }
        
    }
    
}

@end
