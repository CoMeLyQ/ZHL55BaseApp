//
//  QBaseView.m
//  55likeLibDemo
//
//  Created by 55like on 2017/9/13.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import "QBaseView.h"
#import "AppDelegate.h"

@implementation QBaseView






#pragma mark 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        UIWindow *window=((AppDelegate*)[[UIApplication sharedApplication] delegate]).window;
        self.frame =window.bounds;
        [window addSubview:self];
    }
    return self;
}
//初始化
-(void)setterUI{
    
    self.backgroundView.frame = self.bounds;
    if (self.topHide == YES) {
        
        self.backgroundView.userInteractionEnabled = YES;
        
        
    }else{
        
        self.backgroundView.userInteractionEnabled = NO;
        
    }
    self.mainView.frameY = QA_SCREEN_H;
    self.headerview.frame = CGRectMake(0, 0, self.mainView.frame.size.width, QA_Header_H);
    [self.cancelBtn setTitle:self.lefttitle forState:UIControlStateNormal];
    [self.okBtn setTitle:self.rightTitle forState:UIControlStateNormal];
    CGFloat lbw = [self widthWithFont:16 text:self.cancelBtn.titleLabel.text];
    CGFloat rbw = [self widthWithFont:16 text:self.okBtn.titleLabel.text];
    self.cancelBtn.frame = CGRectMake(0, 0, QA_button_x*2+lbw, self.headerview.frame.size.height);
    self.okBtn.frame = CGRectMake(self.headerview.frame.size.width - QA_button_x*2-30, 0, QA_button_x*2+rbw, self.headerview.frame.size.height);
    self.titleLabel.frame = CGRectMake(0, 0, self.headerview.frame.size.width, self.headerview.frame.size.height);
    self.titleLabel.text = self.title;
}

#pragma mark UI事件
//确定
- (void)okAction{
    

    [self hide];
}
//隐藏
- (void)hide{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.mainView.frameY = QA_SCREEN_H;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
}
//显示
-(void)show{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.mainView.frameY = QA_SCREEN_H - QA_Row_H - QA_Header_H;
        
    } completion:^(BOOL finished) {
        
        
    }];
    
    
}
//背景点击
- (void)tapBack:(UITapGestureRecognizer *)sender{
    [self hide];
}
#pragma mark 数据处理方法
//算文字宽度
-(CGFloat)widthWithFont:(CGFloat )font text:(NSString *)text
{
    UIFont*zmfont=[UIFont systemFontOfSize:font];
    NSDictionary *attrs = @{NSFontAttributeName : zmfont};
    CGSize maxsize=CGSizeMake(MAXFLOAT, font);
    return [text boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
}


#pragma mark 懒加载UI
- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:QA_LeftButton_title_color forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        [self.mainView addSubview:btn];
        _cancelBtn = btn;
    }
    return _cancelBtn;
}
- (UIView *)backgroundView{
    if (!_backgroundView) {
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBack:)]];
        [self addSubview:bgView];
        _backgroundView = bgView;
    }
    return _backgroundView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = QA_TitleLabel_title_color;
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 1;
        [self.mainView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}
- (UIButton *)okBtn{
    if (!_okBtn) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:QA_RightButton_title_color forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitle:@"确认" forState:UIControlStateNormal];
        [self.mainView addSubview:btn];
        _okBtn = btn;
    }
    return _okBtn;
}
- (UIView *)mainView{
    if (!_mainView) {
        UIView *mainView = [[UIView alloc]init];
        //        mainView.tintColor = mBlueColor;
        mainView.backgroundColor = [UIColor whiteColor];
        mainView.alpha = 1.f;
        mainView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, QA_Row_H + QA_Header_H);
        [self addSubview:mainView];
        
        
        _mainView = mainView;
    }
    return _mainView;
}
-(UIView *)headerview{
    
    if (!_headerview) {
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = QA_Header_BGcolor;
        [self.mainView addSubview:view];
        _headerview = view;
    }
    return _headerview;
}
-(NSString *)rightTitle{
    if (!_rightTitle || _rightTitle.length == 0) {
        _rightTitle = @"确定";
    }
    return _rightTitle;
}
-(NSString *)title{
    
    if (!_title || _title.length == 0) {
        
        _title = @"请选择";
    }
    
    return _title;
}
-(NSString *)lefttitle{
    if (!_lefttitle || _lefttitle.length == 0) {
        _lefttitle = @"取消";
    }
    return _lefttitle;
}
-(void)dealloc{
    
    NSLog(@"8888888");
    
    
}
@end
