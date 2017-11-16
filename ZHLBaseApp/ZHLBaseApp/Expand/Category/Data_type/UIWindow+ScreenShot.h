//
//  UIWindow+ScreenShot.h
//  teacher
//
//  Created by 衷宏磊 on 16/4/27.
//  Copyright © 2016年 xiayp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (ScreenShot)
/**
 *  对屏幕截图
 *
 *  @return 返回整个屏幕的截图
 */
- (UIImage *)screenshot;
/**
 *  根据位置截图
 *
 *  @param rect 位置
 *
 *  @return 返回的截图
 */
- (UIImage *)screenshotWithRect:(CGRect)rect;
@end
