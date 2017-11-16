
#import "UIView+expanded.h"
#import <QuartzCore/QuartzCore.h>
#import "SDDataCache.h"
#import "NSString+expanded.h"
#import "UIImage+expanded.h"
#import "objc/runtime.h"

static char somethingAdd;
static char btnBlock;
#define showProgressIndicator_width 250




@implementation UIView(Addition)

#pragma mark  - 布局
- (void)setFrameX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (void)setFrameY:(CGFloat)y
{
    CGRect frame = self.frame;
    
    if ([self isKindOfClass:[UILabel class]]&&[self getViewValueForKey:@"lable"]) {
        y=y-2;
    }
    
    
    frame.origin.y = y;
    
    
    self.frame = frame;
}
- (CGFloat)frameX
{
    return self.frame.origin.x;
}
- (CGFloat)frameY
{
    
    if ([self isKindOfClass:[UILabel class]]&&[self getViewValueForKey:@"lable"]) {
        return self.frame.origin.y+2;
    }
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
- (void)setFrameWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)setFrameHeight:(CGFloat)frameHeight
{
    CGRect frame = self.frame;
    frame.size.height = frameHeight;
    self.frame = frame;
}
- (CGFloat)frameHeight
{
    
    if ([self isKindOfClass:[UILabel class]]&&[self getViewValueForKey:@"lable"]) {
        return self.frame.size.height+4;
    }
    
    return self.frame.size.height;
}
- (CGFloat)frameWidth
{
    return self.frame.size.width;
}
- (void)setFrameSize:(CGSize)frameSize
{
    CGRect frame = self.frame;
    frame.size = frameSize;
    self.frame = frame;
}
- (CGSize)frameSize
{
    return self.frame.size;
}
- (void)setFrameOrigin:(CGPoint)frameOrigin
{
    CGRect frame = self.frame;
    frame.origin = frameOrigin;
    self.frame = frame;
}
- (CGPoint)frameOrigin
{
    return self.frame.origin;
}
-(void)setFrameXW:(CGFloat)frameXW{
    
    CGRect frame = self.frame;
    
    frame.origin.x = frameXW-frame.size.width;
    self.frame = frame;
}
-(CGFloat)frameXW{
    
    return self.frame.origin.x+self.frame.size.width;
}
-(void)setFrameYH:(CGFloat)frameYH{
    CGRect frame = self.frame;
    
    
    
    if ([self isKindOfClass:[UILabel class]]&&[self getViewValueForKey:@"lable"]) {
        frameYH=frameYH+2;
    }
    
    frame.origin.y = frameYH-frame.size.height;
    self.frame = frame;
    
}
-(CGFloat)frameYH{
    
    if ([self isKindOfClass:[UILabel class]]&&[self getViewValueForKey:@"lable"]) {
        return  self.frame.origin.y+self.frame.size.height-2;
    }
    
    return self.frame.origin.y+self.frame.size.height;
}

-(void)setFrameBY:(CGFloat)frameBY{
    UIView *view=self.superview;
    if (view==nil) {
        return;
    }
    self.frame=CGRectMake(self.frame.origin.x, view.frameHeight-frameBY-self.frameSize.height, self.frame.size.width, self.frame.size.height);
    
}
-(CGFloat)frameBY{
    UIView *view=self.superview;
    if (view==nil) {
        return 0;
    }
    return view.frameHeight-self.frameSize.height-self.frameOrigin.y;
    
}
-(void)setFrameRX:(CGFloat)frameRX{
    
    UIView *view=self.superview;
    if (view==nil) {
        return;
    }
    self.frame=CGRectMake(view.frame.size.width-frameRX-self.frameSize.width, self.frameOrigin.y, self.frame.size.width, self.frame.size.height);
    
    
}
-(CGFloat)frameRX{
    UIView *view=self.superview;
    if (view==nil) {
        return 0;
    }
    
    
    return view.frameWidth-self.frameOrigin.x-self.frameSize.width;
    
}
////////////////------------------------
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
    //    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=self.frameHeight*0.5;
}

#pragma mark   - 事件
/**
 获取控件所在的控制器
 
 @return 控件当前页面的控制器
 */
- (UIViewController*)supViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}



-(void)addViewClickBlock:(BtnCallBlock)block{
    
    self.btnCallBlock=block;
    
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton*btn=(UIButton*)self;
        //        self.
        [btn addTarget:self action:@selector(btnCallBlockClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return;
    }else{
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        
        self.userInteractionEnabled=YES;
        // 连续敲击2次,手势才能识别成功
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        
        // 2.添加手势识别器对象到对应的view
        [self addGestureRecognizer:tap];
        
        // 3.添加监听方法(识别到了对应的手势,就会调用监听方法)
        [tap addTarget:self action:@selector(btnCallBlockClick:)];
    }
    
    
    
    
}
-(void)btnCallBlockClick:(id)btn{
    
    if (self.btnCallBlock) {
        self.btnCallBlock(self);
    }
}
#pragma mark  - 运行时添加属性
-(void)setBtnCallBlock:(BtnCallBlock)btnCallBlock{
    
    objc_setAssociatedObject(self, &btnBlock, btnCallBlock, OBJC_ASSOCIATION_COPY);
    
    
    
    
}
-(BtnCallBlock)btnCallBlock{
    return objc_getAssociatedObject(self, &btnBlock);
}
-(void)setViewValue:(id)someThing forKey:(NSString *)key{
    
    
    
    NSMutableDictionary *operations = objc_getAssociatedObject(self, &somethingAdd);
    if (operations) {
        //        return operations;
    }else{
        operations = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &somethingAdd, operations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        //        return operations;
    }
    
    [operations setObject:someThing forKey:key];
}
-(id)getViewValueForKey:(NSString *)key{
    
    NSMutableDictionary *operations = objc_getAssociatedObject(self, &somethingAdd);
    
    if (operations==nil) {
        return nil;
    }
    
    return [operations objectForKey:key];
}
-(void)removeViewValueForkey:(NSString *)key{
    
    
    NSMutableDictionary *operations = objc_getAssociatedObject(self, &somethingAdd);
    
    if (operations==nil) {
        return ;
    }
    
    [operations removeObjectForKey:key];
    
}
/// 动画(缩放) 用于点赞等-----选中
-(void)showAnimationSelected{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@0.6,@1.5 ,@0.8, @1.0,@1.2,@1.0];
    animation.duration = 0.5;
    animation.calculationMode = kCAAnimationCubic;
    [self.layer addAnimation:animation forKey:@"transform.scale"];
}
///动画(缩放) 用于点赞等-----取消
-(void)showAnimationCancelSelected{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@0.8, @1.1,@1.0];
    animation.duration = 0.3;
    animation.calculationMode = kCAAnimationCubic;
    [self.layer addAnimation:animation forKey:@"transform.scale"];
}

///圆角
-(void)viewLayerRoundBorderWidth:(float)width borderColor:(UIColor *)color{
    [self viewLayerRoundBorderWidth:width cornerRadius:H(self)/ 2.0 borderColor:color];
}
///圆角或椭圆
-(void)viewLayerRoundBorderWidth:(float)width cornerRadius:(float)radius borderColor:(UIColor *)color{
    // 必須加上這一行，這樣圓角才會加在圖片的「外側」
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius =radius;
    //边框
    self.layer.borderWidth=width;
    self.layer.borderColor =[color CGColor];
}

///view 上添加线条
-(void)addLineLayerWhitframe:(CGRect)_frame whitColor:(UIColor *)_color{
    CALayer *TopBorder = [CALayer layer];
    TopBorder.frame = _frame;
    TopBorder.backgroundColor = _color.CGColor;
    [self.layer addSublayer:TopBorder];
}


@end
