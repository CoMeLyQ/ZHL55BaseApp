//
//  UILabel+QTool.m
//  KeDouJiaApp
//
//  Created by zzz on 2017/1/16.
//  Copyright © 2017年 kedoujia. All rights reserved.
//

#import "UILabel+QTool.h"

@implementation UILabel (QTool)

-(void)labelSetColorWithAttributedStringType:(ZHLLabelType)type textstr:(NSString *)text content:(id)content location:(NSInteger)loc length:(NSInteger)len{
    
    
    
    
    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:text];
    
    // 颜色0
    // 字体大小1
    // 带斜线2
    //下划线3
    // 背景颜色4
    // 阴影5
    //字体倾斜6
    switch (type) {
        case 0:
        {
            [AttributedStr addAttribute:NSForegroundColorAttributeName
                                  value:content
                                  range:NSMakeRange(loc, len)];
//            算好长度不然崩溃
        }
            break;
        case 1:
        {
            [AttributedStr addAttribute:NSFontAttributeName
             
                                  value:content
             
                                  range:NSMakeRange(loc, len)];
            //            算好长度不然崩溃
        }
            break;
        case 2:
        {
            [AttributedStr addAttribute:NSStrikethroughStyleAttributeName
                                  value:@(NSUnderlineStyleSingle)
                                  range:NSMakeRange(loc, len)];
            //            算好长度不然崩溃
        }
            break;
        case 3:
        {
            [AttributedStr addAttribute:NSUnderlineStyleAttributeName
                                  value:[NSNumber numberWithInt:NSUnderlineStyleDouble]
                                  range:NSMakeRange(loc, len)];
            //            算好长度不然崩溃
        }
            break;
        case 4:
        {
            [AttributedStr addAttribute:NSBackgroundColorAttributeName
                                  value:content
                                  range:NSMakeRange(loc, len)];
            //            算好长度不然崩溃
        }
            break;
        case 5:
        {
        
            [AttributedStr addAttribute:NSShadowAttributeName value:content range:NSMakeRange(loc, len)];
            //            算好长度不然崩溃
        }
            break;
        case 6:
        {
           
            
            NSInteger num = [content integerValue];
            [AttributedStr addAttribute:NSObliquenessAttributeName value:@(num) range:NSMakeRange(loc, len)];
            //            算好长度不然崩溃
            
        }
            break;
        default:
            break;
    }
    
    
    [self setAttributedText:AttributedStr];
    
    
    
}





@end
