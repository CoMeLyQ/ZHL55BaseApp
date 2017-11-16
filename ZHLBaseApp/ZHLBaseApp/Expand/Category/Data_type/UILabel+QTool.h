//
//  UILabel+QTool.h
//  KeDouJiaApp
//
//  Created by zzz on 2017/1/16.
//  Copyright © 2017年 kedoujia. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    ZHLlabelColor,        // 颜色
    ZHLlabelFont,         // 字体大小
    ZHLlabelLine,          // 带斜线
    ZHLlabelDownLine,      //下划线
    ZHLlabelBackColor,     // 背景颜色
    ZHLlabelshadow,          // 阴影
    ZHLlabelsloping          //字体倾斜
    
} ZHLLabelType;




@interface UILabel (QTool)

-(void)labelSetColorWithAttributedStringType:(ZHLLabelType)type textstr:(NSString *)text content:(id)content location:(NSInteger)loc length:(NSInteger)len;


@end
