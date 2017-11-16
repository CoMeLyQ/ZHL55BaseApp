//
//  TextKeyboardView.m
//  YunDong55like
//
//  Created by junseek on 15/8/4.
//  Copyright (c) 2015年 五五来客 lj. All rights reserved.
//

#import "TextKeyboardView.h"
#import "Foundation.h"
@interface TextKeyboardView ()<UITextFieldDelegate>{
    
    NSIndexPath *tempIndexPath;
    NSDictionary *tempDic;
    
}


@end

@implementation TextKeyboardView

-(instancetype)init{
    self=[super init];
    if (self) {
        self.frame=CGRectMake(0, 0, kScreenWidth, 44);
        [self setBackgroundColor:[UIColor whiteColor]];
        UIView *viewBG=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        [self addSubview:viewBG];
        [viewBG setBackgroundColor:RGBCOLOR(237, 237, 237)];
        [viewBG addSubview:[RHMethods imageviewWithFrame:CGRectMake(0, 0, kScreenWidth, 1) defaultimage:@"userLine"]];
        
        
        _textSend = [RHMethods textFieldlWithFrame:CGRectMake(10, 7, kScreenWidth - 70, 30) font:Font(15) color:nil placeholder:@"评论" text:nil];
        _textSend.delegate=self;
        _textSend.borderStyle=UITextBorderStyleRoundedRect;
        _textSend.backgroundColor = [UIColor whiteColor];
        [_textSend setReturnKeyType:UIReturnKeySend];
        [viewBG addSubview:_textSend];
        
        UIButton *actionBtn = [RHMethods buttonWithFrame:CGRectMake(XW(_textSend), 0, kScreenWidth - XW(_textSend), H(viewBG)) title:@"发送" image:nil bgimage:nil];
        [actionBtn setTitleColor:rgbTxtDeepGray forState:UIControlStateHighlighted];
        [actionBtn setBackgroundColor:RGBCOLOR(237, 237, 237)];
        [actionBtn addTarget:self action:@selector(sendActionOfArgue) forControlEvents:UIControlEventTouchUpInside];
        [viewBG addSubview:actionBtn];
    }    
    return self;
}

//内容更新
-(void)setValueForDictionary:(NSDictionary *)dic indexPath:(NSIndexPath *)indexPath sendText:(TextKeyboardViewBlock)sendText{
    RegisterNotify(UIKeyboardWillShowNotification, @selector(handleKeyboardDidShow:))
    RegisterNotify(UIKeyboardWillHideNotification, @selector(handleKeyboardWillHide:))
    tempDic=dic;
    tempIndexPath=indexPath;
    self.keyboardText=sendText;
    [_textSend becomeFirstResponder];
    
}

#pragma mark button
-(void)sendActionOfArgue{
    [_textSend resignFirstResponder];
    self.keyboardText?self.keyboardText(tempDic,tempIndexPath,_textSend.text):nil;
    self.keyboardText=nil;
    RemoveNofify
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self sendActionOfArgue];
    return YES;
}

#pragma mark Keyboard
-(void)handleKeyboardDidShow:(NSNotification *)notification{
    
    NSDictionary *info = [notification userInfo];
    CGRect keyboardFrame;
    [[info objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    CGFloat distanceToMove = kbSize.height;
    NSLog(@"---->动态键盘高度:%f",distanceToMove);
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frameY=kScreenHeight-distanceToMove-44;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)handleKeyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        self.frameY=_selfView_Y;
    }completion:^(BOOL finished) {
        
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
