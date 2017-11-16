//
//  QDatePickerView.h
//  zhl
//
//  Created by zhl on 2017/9/12.
//  Copyright © 2017年 zhl. All rights reserved.
//


#import "QDatePickerView.h"


@interface QDatePickerView()

@property (nonatomic, weak)UIDatePicker *datePicker;
//传入数据
@property (nonatomic,assign)UIDatePickerMode pickModel;
@property (nonatomic,strong)NSDate * minDate;
@property (nonatomic,strong)NSDate * maxDate;
@property (nonatomic,strong)NSDate * nowDate;
//返回数据
@property (nonatomic,strong)NSString * dateStr;
@property (nonatomic, copy)void(^datePickerOkBtnAction)(NSString * date);
@end


@implementation QDatePickerView



+(QDatePickerView *)showModeDateQDatePickerViewWithTitle:(NSString *)title datePickerOkBtnAction:(void(^)(NSString * dateStr))dateblock{
    
    QDatePickerView * datePickerView = [QDatePickerView showQDatePickerViewWithTitle:title leftButtonTitle:@"取消" rightButtonTitle:@"确定" datePickerMode:UIDatePickerModeDate dateFormat:@"yyyy-MM-dd" datePickerMinDate:nil datePickerMaxDate:nil datePickerNowDate:nil topBacview:YES datePickerOkBtnAction:dateblock];
    return datePickerView;
}
+(QDatePickerView *)showModeDateAndTimeQDatePickerViewWithTitle:(NSString *)title datePickerOkBtnAction:(void(^)(NSString * dateStr))dateblock{
    
    QDatePickerView * datePickerView = [QDatePickerView showQDatePickerViewWithTitle:title leftButtonTitle:@"取消" rightButtonTitle:@"确定" datePickerMode:UIDatePickerModeDateAndTime dateFormat:@"MM-dd HH:mm:ss" datePickerMinDate:nil datePickerMaxDate:nil datePickerNowDate:nil topBacview:YES datePickerOkBtnAction:dateblock];
    return datePickerView;
}
+(QDatePickerView *)showCountDownTimerQDatePickerViewWithTitle:(NSString *)title datePickerOkBtnAction:(void(^)(NSString * dateStr))dateblock{
    
    QDatePickerView * datePickerView = [QDatePickerView showQDatePickerViewWithTitle:title leftButtonTitle:@"取消" rightButtonTitle:@"确定" datePickerMode:UIDatePickerModeCountDownTimer dateFormat:@"HH:mm" datePickerMinDate:nil datePickerMaxDate:nil datePickerNowDate:nil topBacview:YES datePickerOkBtnAction:dateblock];
    return datePickerView;
}

+(QDatePickerView *)showQDatePickerViewWithTitle:(NSString *)title datePickerMode:(UIDatePickerMode)model dateFormat:(NSString *)dateFormat datePickerOkBtnAction:(void(^)(NSString * dateStr))dateblock{
    
    QDatePickerView * datePickerView = [QDatePickerView showQDatePickerViewWithTitle:title leftButtonTitle:@"取消" rightButtonTitle:@"确定" datePickerMode:model dateFormat:dateFormat datePickerMinDate:nil datePickerMaxDate:nil datePickerNowDate:nil topBacview:YES datePickerOkBtnAction:dateblock];
    
    return datePickerView;
}

+(QDatePickerView *)showQDatePickerViewWithTitle:(NSString *)title leftButtonTitle:(NSString *)lefttitle rightButtonTitle:(NSString *)rightTitle datePickerMode:(UIDatePickerMode)model dateFormat:(NSString *)dateFormat datePickerMinDate:(NSString *)minDate datePickerMaxDate:(NSString *)maxDate datePickerNowDate:(NSString *)nowDate topBacview:(BOOL)topbool datePickerOkBtnAction:(void(^)(NSString * dateStr))dateblock{
    
    
    QDatePickerView * datePickerView = [[QDatePickerView alloc]init];
    datePickerView.title = title;
    datePickerView.lefttitle = lefttitle;
    datePickerView.rightTitle = rightTitle;
    datePickerView.pickModel = model;
    datePickerView.dateFormat = dateFormat;
    datePickerView.minDate = [datePickerView convertDateFromString:minDate];
    datePickerView.maxDate = [datePickerView convertDateFromString:maxDate];
    datePickerView.nowDate = [datePickerView convertDateFromString:nowDate];
    datePickerView.topHide = topbool;
    [datePickerView setterUI];
    [datePickerView show];
    datePickerView.datePickerOkBtnAction = dateblock;
    
    return datePickerView;
}
//初始化
-(void)setterUI{
    
    [super setterUI];
    
    self.datePicker.frame = CGRectMake(0, QA_Header_H, self.mainView.frame.size.width, QA_Row_H);
    self.datePicker.datePickerMode = self.pickModel;
    self.datePicker.minimumDate = self.minDate;
    self.datePicker.maximumDate = self.maxDate;
    self.datePicker.date = self.nowDate;
    
    
}

#pragma mark UI事件
//确定
- (void)okAction{
    
    if (self.datePickerOkBtnAction) {
        
        self.datePickerOkBtnAction(self.dateStr);
        
    }
    [super okAction];
}

//UIDatePicker滚动监听
-(void)dateChanged:(id)sender{
    
//    UIDatePicker* control = (UIDatePicker*)sender;
//    NSDate* _date = control.date;
//    NSDateFormatter *dateF  = [[NSDateFormatter alloc]init];
//    [dateF setDateFormat:self.dateFormat];
//    NSString *str =  [dateF stringFromDate:_date];
//    self.dateStr = str;
    
}
//NSString 传 NSDate
-(NSDate *)convertDateFromString:(NSString*)uiDate{
    
    if (!uiDate) {
        
        return nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:self.dateFormat];
    NSDate *date=[formatter dateFromString:uiDate];
    return date;
}
-(NSDate *)maxDate{
    
    if (!_maxDate) {
        _maxDate = [NSDate distantFuture];
    }
    return _maxDate;
}

-(NSDate *)minDate{
    
    if (!_minDate) {
        
        _minDate = [NSDate distantPast];
        
    }
    
    return _minDate;
}
-(NSDate *)nowDate{
    
    if (!_nowDate) {
        
        _nowDate = [NSDate date];
    }
    return _nowDate;
}

-(NSString *)dateFormat{
    
    if (!_dateFormat || _dateFormat.length == 0) {
        _dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    return _dateFormat;
}
//反回数据处理
-(NSString *)dateStr{
    NSDate* _date = self.datePicker.date;
    NSDateFormatter *dateF  = [[NSDateFormatter alloc]init];
    [dateF setDateFormat:self.dateFormat];
    NSString *str =  [dateF stringFromDate:_date];
    return str;
}
- (UIDatePicker *)datePicker{
    if (!_datePicker) {
        UIDatePicker *datePicker = [[UIDatePicker alloc]init];
        [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        
        [self.mainView addSubview:datePicker];
        _datePicker = datePicker;
    }
    return _datePicker;
}

@end
