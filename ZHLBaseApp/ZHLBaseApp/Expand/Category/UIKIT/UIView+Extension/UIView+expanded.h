

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void (^BtnCallBlock)(UIView* view);
@interface UIView(Addition)



@property (nonatomic, assign) CGFloat frameX;
@property (nonatomic, assign) CGFloat frameY;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat frameWidth;
@property (nonatomic, assign) CGFloat frameHeight;
@property (nonatomic, assign) CGSize frameSize;
@property (nonatomic, assign) CGPoint frameOrigin;

/**
 view 最右边的x坐标
 */
@property(nonatomic,assign)CGFloat frameXW;

/**
 view 最下边的Y坐标
 */
@property(nonatomic,assign)CGFloat frameYH;
/**
 view 最右边距离父控件右边框的距离
 */
@property(nonatomic,assign)CGFloat frameRX;
/**
 view 最下边距离父控件底部的距离
 */
@property(nonatomic,assign)CGFloat frameBY;
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

#pragma mark  - 运行时添加属性
/**
 获取控件所在的控制器
 
 @return 控件当前页面的控制器
 */
- (UIViewController*)supViewController;

/**
 动态为view添加属性
 
 @param someThing 所添加对象
 @param key 关键字
 */
- (void)setViewValue:(id)someThing forKey:(NSString *)key;


/**
 获取为view添加的对象
 
 @param key 关键字
 @return 获取对象
 */
- (id)getViewValueForKey:(NSString *)key;


/**
 移除对象
 
 @param key 关键字
 */
- (void)removeViewValueForkey:(NSString *)key;


/**
 点击事件回调block
 */
@property(nonatomic,copy)BtnCallBlock btnCallBlock;

-(void)addViewClickBlock:(BtnCallBlock)block;



#pragma mark  - 动画
/// 动画(缩放) 用于点赞等-----选中
-(void)showAnimationSelected;
///动画(缩放) 用于点赞等-----取消
-(void)showAnimationCancelSelected;


#pragma mark  - 圆角或椭圆
///圆角
-(void)viewLayerRoundBorderWidth:(float)width borderColor:(UIColor *)color;
///圆角或椭圆
-(void)viewLayerRoundBorderWidth:(float)width cornerRadius:(float)radius borderColor:(UIColor *)color;


///view 上添加线条
-(void)addLineLayerWhitframe:(CGRect)_frame whitColor:(UIColor *)_color;




@end
