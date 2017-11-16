//
//  CZNavigationController.h
//  ChongZu
//
//  Created by cz10000 on 16/4/27.
//  Copyright © 2016年 cz10000. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLTNavigationController : UINavigationController

@property(strong,nonatomic)UIScreenEdgePanGestureRecognizer *panGestureRec;

@end




//--------------------------------------------------------------------


/**
 导航栏操作类型
 */
#define KLScreenWidth [UIScreen mainScreen].bounds.size.width
#define KLScreenHeight [UIScreen mainScreen].bounds.size.height

@interface AnimationContoller : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)AnimationControllerWithOperation:(UINavigationControllerOperation)operation;
+ (instancetype)AnimationControllerWithOperation:(UINavigationControllerOperation)operation NavigationController:(UINavigationController *)navigationController;

@property(nonatomic,assign)UINavigationControllerOperation  navigationOperation;
@property(nonatomic,weak)UINavigationController * navigationController;

/**
 导航栏Pop时删除了多少张截图（调用PopToViewController时，计算要删除的截图的数量）
 */
@property(nonatomic,assign)NSInteger  removeCount;

/**
 调用此方法删除数组最后一张截图 (调用pop手势或一次pop多个控制器时使用)
 */
- (void)removeLastScreenShot;
/**
 移除全部屏幕截图
 */
- (void)removeAllScreenShot;
/**
 从截屏数组尾部移除指定数量的截图
 */
- (void)removeLastScreenShotWithNumber:(NSInteger)number;
@end
