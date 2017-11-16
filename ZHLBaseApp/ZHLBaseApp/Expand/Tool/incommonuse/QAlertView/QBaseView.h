//
//  QBaseView.h
//  55likeLibDemo
//
//  Created by 55like on 2017/9/13.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import <UIKit/UIKit.h>




#define QA_SCREEN_W [UIScreen mainScreen].bounds.size.width
#define QA_SCREEN_H [UIScreen mainScreen].bounds.size.height
#define QA_Row_H 216
#define QA_Header_H 50
#define QA_button_x 15
#define QA_iPhonePlus_OR_Later   (QA_SCREEN_H >= 736)
#define QA_iOS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define QA_Font(x) [UIFont systemFontOfSize:(NSInteger)(QA_iPhonePlus_OR_Later?1.1*x:x)]
#define QA_RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define QA_MainView_H (QA_SCREEN_W*0.8)

#define UIColorFromHex(s)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]


#define QA_Header_BGcolor [UIColor redColor]
#define QA_RightButton_title_color [UIColor redColor]
#define QA_LeftButton_title_color [UIColor redColor]
#define QA_TitleLabel_title_color [UIColor darkGrayColor]



@interface QBaseView : UIView



//ui方便修改属性
@property (nonatomic, weak)UILabel *titleLabel;
@property (nonatomic, weak)UIButton *okBtn;
@property (nonatomic, weak)UIButton *cancelBtn;
@property (nonatomic, weak)UIView *backgroundView;
@property (nonatomic, weak)UIView *mainView;
@property (nonatomic, weak)UIView * headerview;
//传入数据
@property (nonatomic,assign)BOOL topHide;
@property (nonatomic,strong)NSString * title;
@property (nonatomic,strong)NSString * lefttitle;
@property (nonatomic,strong)NSString * rightTitle;


/** 初始化子视图 */
-(void)setterUI;
/** 确定按钮的点击事件 */
- (void)okAction;
/** 取消按钮的点击事件 */
- (void)hide;
//显示
-(void)show;
/** 点击背景遮罩图层事件 */
- (void)tapBack:(UITapGestureRecognizer *)sender;

@end
