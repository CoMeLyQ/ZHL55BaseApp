


#import <Foundation/Foundation.h>
#import "Foundation.h"
#import "WSSizeButton.h"
@interface RHMethods : NSObject
+ (UITextField *)textFieldlWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor placeholder:(NSString *)aplaceholder text:(NSString*)atext;
+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext;
+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext textAlignment:(NSTextAlignment)aalignment;
+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext textAlignment:(NSTextAlignment)aalignment setLineSpacing:(float)afloat;
+(UIButton*)buttonWithFrame:(CGRect)_frame title:(NSString*)_title  image:(NSString*)_image bgimage:(NSString*)_bgimage;
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image;
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image contentMode:(UIViewContentMode )cmode;
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image stretchW:(NSInteger)_w stretchH:(NSInteger)_h;

/**
 *  快速创建一个带默认文字的TextView 实现下面的代理方法即可
 *
 -(void)textViewDidChange:(UITextView *)textView
 {
     UIView *la = (UILabel *)[textView.superview viewWithTag:100];
    if (textView.text.length) {
        la.hidden = YES;
     }else{
        la.hidden = NO;
     }
 }
 */
+(UIView *)setTextViewWithFrame:(CGRect)frame leftRightEdge:(float )fLEdge topBottomEdge:(float)fTEdge font:(UIFont*)afont color:(UIColor*)acolor placeholder:(NSString *)placeholder delegate:(id<UITextViewDelegate>)delegate;

///分割线
+(UIView *)lineViewWithFrame:(CGRect)_frame;



//////////////带supview
+ (UITextField *)textFieldlWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor placeholder:(NSString *)aplaceholder text:(NSString*)atext supView:(UIView *)sView;
+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext supView:(UIView *)sView;
+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext textAlignment:(NSTextAlignment)aalignment supView:(UIView *)sView;
+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext textAlignment:(NSTextAlignment)aalignment setLineSpacing:(float)afloat supView:(UIView *)sView;
+(UIButton*)buttonWithFrame:(CGRect)_frame title:(NSString*)_title  image:(NSString*)_image bgimage:(NSString*)_bgimage supView:(UIView *)sView;
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image supView:(UIView *)sView;
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image contentMode:(UIViewContentMode )cmode supView:(UIView *)sView;
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image stretchW:(NSInteger)_w stretchH:(NSInteger)_h supView:(UIView *)sView;


#pragma mark  新增创建方法





+(UIView*)viewWithFrame:(CGRect)aframe backgroundcolor:(UIColor*)color superView:(UIView*)view;

/**
 创建普通lable 从左边排列
 
 @param X x位置
 @param Y y位置
 @param Width 宽度 数值（如果为0自动排列）
 @param Height 高度数值（如果为0自动排列）
 @param font 字体大小 float
 @param superview 父控件
 @param text lable的显示文字
 @return 返回创建成功的lable实例
 */
+(UILabel*)lableX:(CGFloat)X Y:(CGFloat )Y W:(CGFloat)Width Height:(CGFloat)Height  font:(CGFloat)font  superview:(UIView*)superview withColor:coler text:(NSString*)text;

/**
 创建lable 从右边开始排列
 
 @param RX 距离父控件右边的位置
 @param Y y 位置
 @param Width 宽度（如果为0自动排列）
 @param Height 高度（如果为0自动排列）
 @param font 字体大小 float
 @param superview 父控件
 @param text lable的显示文字
 @return 返回创建成功的lable实例
 */
+(UILabel*)RlableRX:(CGFloat)RX Y:(CGFloat )Y W:(CGFloat)Width Height:(CGFloat)Height  font:(CGFloat)font  superview:(UIView*)superview withColor:coler text:(NSString*)text;


/**
 创建lable 居中排列的lable
 
 @param Y y位置
 @param Width 宽度（如果为0自动排列）
 @param Height 高度（如果为0自动排列）
 @param font 字体大小 float
 @param superview 父控件
 @param text lable显示的文字
 @return 返回创建成功的lable实例
 */
+(UILabel*)ClableY:(CGFloat )Y W:(CGFloat)Width Height:(CGFloat)Height  font:(CGFloat)font  superview:(UIView*)superview withColor:coler text:(NSString*)text;


+(WSSizeButton*)buttonWithframe:(CGRect)frame backgroundColor:(UIColor*)coler text:(NSString*)text font:(float)font textColor:(UIColor*)textcoler radius:(float)radius superview:(UIView*)superview;
@end
