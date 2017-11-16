//
//  UIView+Extension.m
//  黑马微博2期
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}
-(void)setXXW:(CGFloat)XW{
    
    CGRect frame = self.frame;
    
    frame.origin.x = XW-frame.size.width;
    self.frame = frame;
}
-(CGFloat)XXW{
    
    return self.frame.origin.x+self.frame.size.width;
}
-(void)setYYH:(CGFloat)YH{
    CGRect frame = self.frame;
    
    frame.origin.y = YH-frame.size.height;
    self.frame = frame;
    
}
-(CGFloat)YYH{
    
    return self.frame.origin.y+self.frame.size.height;
}
-(void)beCenter{
//    if
    
    UIView *view=self.superview;
    if (view==nil) {
        return;
    }
    self.centerX=view.frame.size.width/2;
    self.centerY=view.frame.size.height/2;
    
}
-(void)beCX{
    UIView *view=self.superview;
    if (view==nil) {
        return;
    }
    self.centerX=view.frame.size.width/2;
    
    
}
-(void)beCY{
    UIView *view=self.superview;
    if (view==nil) {
        return;
    }
    self.centerY=view.frame.size.height/2;
    
}


-(void)beRound{
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=self.height*0.5;



}
-(void)setBBY:(CGFloat)BBY{
    UIView *view=self.superview;
    if (view==nil) {
        return;
    }
    self.frame=CGRectMake(self.frame.origin.x, view.height-BBY-self.size.height, self.frame.size.width, self.frame.size.height);
    
}
-(CGFloat)BBY{
    UIView *view=self.superview;
    if (view==nil) {
        return 0;
    }
    return view.height-self.size.height-self.origin.y;
    
}

-(void)setRRX:(CGFloat)RRX{
    
    UIView *view=self.superview;
    if (view==nil) {
        return;
    }
    self.frame=CGRectMake(view.frame.size.width-RRX-self.size.width, self.origin.y, self.frame.size.width, self.frame.size.height);
    
    
}
-(CGFloat)RRX{
    UIView *view=self.superview;
    if (view==nil) {
        return 0;
    }
    
    
    return view.width-self.origin.x-self.size.width;
    
}





- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

-(void)zaddTarget:(id)target select:(SEL)action{

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    self.userInteractionEnabled=YES;
    // 连续敲击2次,手势才能识别成功
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    // 2.添加手势识别器对象到对应的view
    [self addGestureRecognizer:tap];
    
    // 3.添加监听方法(识别到了对应的手势,就会调用监听方法)
    [tap addTarget:target action:action];


}
@end
