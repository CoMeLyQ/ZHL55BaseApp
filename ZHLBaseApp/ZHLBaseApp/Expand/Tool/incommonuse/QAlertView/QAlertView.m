//
//  QAlertView.m
//  QTool
//
//  Created by 衷宏磊 on 16/5/10.
//  Copyright © 2016年 qiuhailong. All rights reserved.
//

#import "QAlertView.h"
@interface QAlertView ()<UIActionSheetDelegate>
@property (nonatomic, copy)EMIndexBlock actionSheetBlock;
@end
@implementation QAlertView
static EMIndexBlock _alertViewBlock;
+ (UIAlertView *)showAlertViewWithTitle:(NSString*)title message:(NSString *)messge cancelButtonTitle:(NSString *)cancelButtonTitle OtherButtonsArray:(NSArray*)otherButtons clickAtIndex:(EMIndexBlock) clickAtIndex
{
    _alertViewBlock = clickAtIndex;
    UIAlertView  *Al = [[UIAlertView alloc] initWithTitle:title message:messge delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles: nil];
    for (NSString *otherTitle in otherButtons) {
        [Al addButtonWithTitle:otherTitle];
    }
    [Al show];
    return Al;
}
#pragma mark   UIAlertViewDelegate
+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(_alertViewBlock)_alertViewBlock(buttonIndex);
}
+ (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    _alertViewBlock = nil;
}

@end
