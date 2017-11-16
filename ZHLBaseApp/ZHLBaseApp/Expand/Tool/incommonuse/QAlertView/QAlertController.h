//
//  QAlertController.h
//  55likeLibDemo
//
//  Created by 55like on 2017/9/11.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface QAlertController : UIAlertController


/** 
 style:UIAlertControllerStyleActionSheet  UIAlertControllerStyleAlert
 num:按钮的个数
 vc:当前控制器
 numArray:要改颜色按钮下标数组 如要改第一个按钮字体颜色 @[@"0"]
 makeblock:按顺序return @“title” 同return tableviewcell
 styleindex:按顺序return 每个按钮的style
 colorstrBlock:return 按钮字体uicolor if(num == 0)return [uicolor red]
 btnclick:点击事件
 */
+(QAlertController *)showQAlertControllerWithStyle:(UIAlertControllerStyle)style
                                             Title:(NSString *)title
                                           message:(NSString *)message
                                         actionNum:(int)num
                                    showController:(UIViewController *)vc
                                     setColorIndex:(NSArray *)numArray
                                UIAlertActionindex:(NSString* (^)(int index))makeblock
                                UIAlertActionStyle:(UIAlertActionStyle (^)(int index))styleindex
                           UIAlertActionColorindex:(UIColor* (^)(int index))colorstrBlock
                        QAlertControllerClickBlock:(void(^)(int index))btnclick;
/**
 Sheet 最多三个按钮 默认系统颜色
 btnclick index == 0 为取消按钮 其他按照btnArr类推
 */
+(QAlertController *)showSheetQAlertControllerWithTitle:(NSString *)title message:(NSString *)message cancelBtn:(NSString *)canceltitle otherBtnArray:(NSArray *)btnArr showController:(UIViewController *)vc  QAlertControllerClickBlock:(void(^)(int index))btnclick;
/**
 Alert 最多三个按钮 默认系统颜色
 btnclick index == 0 为取消按钮 其他按照btnArr类推
*/
+(QAlertController *)showAlertQAlertControllerWithTitle:(NSString *)title message:(NSString *)message cancelBtn:(NSString *)canceltitle otherBtnArray:(NSArray *)btnArr showController:(UIViewController *)vc  QAlertControllerClickBlock:(void(^)(int index))btnclick;
@end
