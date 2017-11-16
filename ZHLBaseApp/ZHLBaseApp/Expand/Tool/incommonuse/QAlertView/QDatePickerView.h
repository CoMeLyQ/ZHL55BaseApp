//
//  QDatePickerView.h
//  zhl
//
//  Created by zhl on 2017/9/12.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "QBaseView.h"

@interface QDatePickerView : QBaseView

/**
 年-月-日
 UIDatePickerModeDate
 dateblock:返回yyyy-MM-dd
 */
+(QDatePickerView *)showModeDateQDatePickerViewWithTitle:(NSString *)title datePickerOkBtnAction:(void(^)(NSString * dateStr))dateblock;
/**
 月-日 时:分:秒
 UIDatePickerModeCountDownTimer
 dateblock:返回MM-dd HH:mm:ss
 */
+(QDatePickerView *)showModeDateAndTimeQDatePickerViewWithTitle:(NSString *)title datePickerOkBtnAction:(void(^)(NSString * dateStr))dateblock;
/**
 时:分
 model:UIDatePickerModeCountDownTimer
 dateblock:返回 HH:mm
 */
+(QDatePickerView *)showCountDownTimerQDatePickerViewWithTitle:(NSString *)title datePickerOkBtnAction:(void(^)(NSString * dateStr))dateblock;
/**
 总方法
 title   标题
 lefttitle   左边按钮名称
 rightTitle  右边按钮名称
 model    datePickerMode
 dateFormat 时间输入和输出统一格式 不传默认为（yyyy-MM-dd hh:mm:ss）
 minDate  最小可选的时间
 maxDate  最大可选的时间
 nowDate  默认显示的时间
 topbool  点击背景是否视图消失
 dateblock 返回 dateFormat格式的字符串(dateFormat=@“yyyy-MM-dd hh-mm-ss” 返回dateStr = @“2017-01-01 00：00：00”)
 */
+(QDatePickerView *)showQDatePickerViewWithTitle:(NSString *)title
                                 leftButtonTitle:(NSString *)lefttitle
                                rightButtonTitle:(NSString *)rightTitle
                                  datePickerMode:(UIDatePickerMode)model
                                      dateFormat:(NSString *)dateFormat
                               datePickerMinDate:(NSString *)minDate
                               datePickerMaxDate:(NSString *)maxDate
                               datePickerNowDate:(NSString *)nowDate
                                      topBacview:(BOOL)topbool
                           datePickerOkBtnAction:(void(^)(NSString * dateStr))dateblock;

/**默认yyyy-MM-dd HH:mm:ss*/
@property (nonatomic,strong)NSString * dateFormat;


@end
