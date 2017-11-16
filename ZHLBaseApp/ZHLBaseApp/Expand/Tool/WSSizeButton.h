//
//  WSSizeButton.h
//  HairDressing
//
//  Created by 55like on 22/03/2017.
//  Copyright © 2017 55like. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSSizeButton;
typedef CGRect (^ButtonSize)(WSSizeButton*btn);

@class WSSizeButton;

@interface WSSizeButton : UIButton
-(void)setImageviewColor:(UIColor *)color forState:(UIControlState)state;

-(void)setBackGroundImageviewColor:(UIColor *)color forState:(UIControlState)state;


/**
 设置按钮的lable位置
 */
@property(nonatomic,assign)CGRect btnLableFrame;

/**
 设置按钮的 图片 位置
 */
@property(nonatomic,assign)CGRect btnImageViewFrame;



@property(nonatomic,copy)ButtonSize imageviewsize;

@property(nonatomic,copy)ButtonSize lableviewSize;


@end
