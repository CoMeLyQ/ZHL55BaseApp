//
//  TextKeyboardView.h
//  YunDong55like
//
//  Created by junseek on 15/8/4.
//  Copyright (c) 2015年 五五来客 lj. All rights reserved.
//键盘上的输入框

#import <UIKit/UIKit.h>

typedef void (^TextKeyboardViewBlock)(NSDictionary *dict,NSIndexPath *indexPath,NSString *txtSend);
@interface TextKeyboardView : UIView

@property (nonatomic,strong) UITextField *textSend;
@property (nonatomic,assign) float selfView_Y;//默认y
@property (nonatomic, strong) TextKeyboardViewBlock keyboardText;
//内容更新
-(void)setValueForDictionary:(NSDictionary *)dic indexPath:(NSIndexPath *)indexPath sendText:(TextKeyboardViewBlock)sendText;
@end
