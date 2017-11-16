//
//  QAlertController.m
//  55likeLibDemo
//
//  Created by 55like on 2017/9/11.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import "QAlertController.h"

@interface QAlertController ()



@end

@implementation QAlertController


+(QAlertController *)showQAlertControllerWithStyle:(UIAlertControllerStyle)style Title:(NSString *)title
                                           message:(NSString *)message
                                         actionNum:(int)num
                                    showController:(UIViewController *)vc
                                     setColorIndex:(NSArray *)numArray
                                UIAlertActionindex:(NSString* (^)(int index))makeblock
                                UIAlertActionStyle: (UIAlertActionStyle (^)(int index))styleindex
                           UIAlertActionColorindex:(UIColor* (^)(int index))colorstrBlock
                        QAlertControllerClickBlock:(void(^)(int index))btnclick{
    QAlertController * alertController = [QAlertController alertControllerWithTitle:title message:message preferredStyle: style];
    NSMutableArray * buttonArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < num; i ++) {
        UIAlertAction *nanAction = [UIAlertAction actionWithTitle:makeblock?makeblock(i):@"" style:styleindex?styleindex(i):UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (btnclick) {
                btnclick(i);
            }
        }];
        [alertController addAction:nanAction];
        [buttonArray addObject:nanAction];
    }
    for (int j = 0; j < numArray.count; j ++) {
        int  strnum = [numArray[j] intValue];
        UIAlertAction *nanAction = buttonArray[strnum];
        if (colorstrBlock) {
            [nanAction setValue:colorstrBlock(strnum) forKey:@"titleTextColor"];
        }
    }
     [vc presentViewController:alertController animated:YES completion:nil];
    return alertController;
}
//Sheet 最多三个按钮 默认系统颜色
+(QAlertController *)showSheetQAlertControllerWithTitle:(NSString *)title message:(NSString *)message cancelBtn:(NSString *)canceltitle otherBtnArray:(NSArray *)btnArr showController:(UIViewController *)vc  QAlertControllerClickBlock:(void(^)(int index))btnclick{
    
    return [QAlertController showQAlertControllerWithStyle:UIAlertControllerStyleActionSheet Title:title message:message cancelBtn:canceltitle otherBtnArray:btnArr showController:vc QAlertControllerClickBlock:btnclick];
}
//Alert 最多三个按钮 默认系统颜色
+(QAlertController *)showAlertQAlertControllerWithTitle:(NSString *)title message:(NSString *)message cancelBtn:(NSString *)canceltitle otherBtnArray:(NSArray *)btnArr showController:(UIViewController *)vc  QAlertControllerClickBlock:(void(^)(int index))btnclick{
    
    return [QAlertController showQAlertControllerWithStyle:UIAlertControllerStyleAlert Title:title message:message cancelBtn:canceltitle otherBtnArray:btnArr showController:vc QAlertControllerClickBlock:btnclick];
}
//Alert or Sheet 最多三个按钮 默认系统颜色
+(QAlertController *)showQAlertControllerWithStyle:(UIAlertControllerStyle)style Title:(NSString *)title message:(NSString *)message cancelBtn:(NSString *)canceltitle otherBtnArray:(NSArray *)btnArr showController:(UIViewController *)vc  QAlertControllerClickBlock:(void(^)(int index))btnclick{
    
    QAlertController * alertController = [QAlertController showQAlertControllerWithStyle:style Title:title message:message actionNum:3 showController:vc setColorIndex:nil UIAlertActionindex:^NSString *(int index) {
        
        switch (index) {
            case 0:
            {
                return canceltitle;
            }
                break;
                
            default:
                return btnArr[index];
                break;
        }
        
    } UIAlertActionStyle:^UIAlertActionStyle(int index) {
        switch (index) {
            case 0:
            {
                return UIAlertActionStyleCancel;
            }
                break;
                
            default:
                return UIAlertActionStyleDefault;
                break;
        }
    } UIAlertActionColorindex:nil QAlertControllerClickBlock:btnclick];
    
    return alertController;
}

@end
