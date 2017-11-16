//
//  UIImageView+QTool.h
//  teacher
//
//  Created by 衷宏磊 on 16/5/9.
//  Copyright © 2016年 xiayp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (QTool)

//固定默认图片
-(void)sd_imageUrlStr:(NSString *)str;
//自定义默认图片
-(void)sd_imageUrlStr:(NSString *)str placeholderImagename:(NSString *)imagename;



//高性能圆角
- (instancetype)initWithCornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

- (void)zy_cornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

- (instancetype)initWithRoundingRectImageView;

- (void)zy_cornerRadiusRoundingRect;

- (void)zy_attachBorderWidth:(CGFloat)width color:(UIColor *)color;
//

@end
