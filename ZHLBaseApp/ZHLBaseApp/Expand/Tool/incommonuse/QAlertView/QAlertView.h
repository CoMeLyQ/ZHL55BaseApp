//
//  QAlertView.h
//  QTool
//
//  Created by 衷宏磊 on 16/5/10.
//  Copyright © 2016年 qiuhailong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^EMIndexBlock)(NSInteger index);
@interface QAlertView : UIAlertView
//系统alertview
+ (UIAlertView *)showAlertViewWithTitle:(NSString*)title message:(NSString *)messge cancelButtonTitle:(NSString *)cancelButtonTitle OtherButtonsArray:(NSArray*)otherButtons clickAtIndex:(EMIndexBlock) clickAtIndex;
@end
