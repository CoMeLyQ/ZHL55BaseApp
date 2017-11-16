//
//  UIView+Extension.h
//  黑马微博2期
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark zxhalwaysuse 常用 使用频率很高 view控件布局 

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;


/**
 view 最右边的x坐标
 */
@property(nonatomic,assign)CGFloat XXW;

/**
 view 最下边的Y坐标
 */
@property(nonatomic,assign)CGFloat YYH;


/**
 view 最右边距离父控件右边框的距离
 */
@property(nonatomic,assign)CGFloat RRX;


/**
 view 最下边距离父控件底部的距离
 */
@property(nonatomic,assign)CGFloat BBY;


/**
 控件左右上下居中
 */
-(void)beCenter;


/**
 控件横向居中
 */
-(void)beCX;

/**
 控件竖向居中
 */
-(void)beCY;

/**
 控件变圆
 */
-(void)beRound;

/**
 获取控件所在的控制器

 @return 控件当前页面的控制器
 */
- (UIViewController*)viewController;


-(void)zaddTarget:(id)target select:(SEL)action;
@end
