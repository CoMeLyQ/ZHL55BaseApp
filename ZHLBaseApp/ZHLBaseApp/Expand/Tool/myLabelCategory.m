//
//  myLabelCategory.m
//  dby
//
//  Created by user on 13-12-26.
//  Copyright (c) 2013年 thomas. All rights reserved.
//

#import "myLabelCategory.h"

@implementation UILabel(Addition)



-(BOOL)canBecomeFirstResponder{
    return YES;
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(txtCopy:)) {
        return YES;
    }
    return NO;
}

-(void)lableCopy{
    if ([self isKindOfClass:[UILabel class]]) {
        self.userInteractionEnabled=YES;
        //长按
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:recognizer];
    }
}
-(void)longPress:(UILongPressGestureRecognizer *)longPress{
    UILabel *lbl=(UILabel *)longPress.view;
    [self becomeFirstResponder];
  /*  UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:self.frame inView:self.superview];
    [menu setMenuVisible:YES animated:YES];
*/
    UIMenuController *popMenu = [UIMenuController sharedMenuController];
    // popMenu set
    UIMenuItem *item1 = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(txtCopy:)];
    NSArray *menuItems = [NSArray arrayWithObjects:item1,nil];
    [popMenu setMenuItems:menuItems];
    [popMenu setArrowDirection:UIMenuControllerArrowDown];
    [popMenu setTargetRect:self.bounds inView:self];
    [popMenu setMenuVisible:YES animated:YES];
 
    
  
    
}
-(void)txtCopy:(id)item{
  //  UIMenuController *menu=(UIMenuController*)item;
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;

    
}

@end
