

#import "RHMethods.h"
@implementation RHMethods


+ (UITextField *)textFieldlWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor placeholder:(NSString *)aplaceholder text:(NSString*)atext{
    if (acolor==nil) {
        acolor=RGBCOLOR(51,51,51);
    }
    
   UITextField *baseTextField=[[UITextField alloc]initWithFrame:aframe];
    [baseTextField setKeyboardType:UIKeyboardTypeDefault];
    [baseTextField setBorderStyle:UITextBorderStyleNone];
    [baseTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [baseTextField setTextColor:acolor];
    baseTextField.placeholder=aplaceholder;
    baseTextField.font=afont;
    [baseTextField setSecureTextEntry:NO];
    [baseTextField setReturnKeyType:UIReturnKeyDone];
    [baseTextField setText:atext];
    baseTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    return baseTextField;
}


/**
 *	根据aframe返回相应高度的label（默认透明背景色，白色高亮文字）
 *
 *	@param	aframe	预期框架 若height=0则计算高度  若width=0则计算宽度
 *	@param	afont	字体
 *	@param	acolor	颜色
 *	@param	atext	内容
 *
 *	@return	UILabel
 */
+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext
{
    return [self labelWithFrame:aframe font:afont color:acolor text:atext textAlignment:NSTextAlignmentLeft];// autorelease];
}

/**
 *	根据aframe返回相应高度的label（默认透明背景色，白色高亮文字）
 *
 *	@param	aframe	预期框架 若height=0则计算高度  若width=0则计算宽度
 *	@param	afont	字体
 *	@param	acolor	颜色
 *	@param	atext	内容
 *  @param  aalignment   位置
 *  @param  afloat   行距(文本不能为空)
 *
 *	@return	UILabel
 */
+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext textAlignment:(NSTextAlignment)aalignment setLineSpacing:(float)afloat
{
    UILabel *lblTemp=[self labelWithFrame:aframe font:afont color:acolor text:atext textAlignment:aalignment];
    if (!aframe.size.height && [atext notEmptyOrNull]) {
        lblTemp.numberOfLines=0;
        
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:lblTemp.text];
        NSMutableParagraphStyle *paragraphStyleT = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyleT setLineSpacing:afloat];//调整行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyleT range:NSMakeRange(0, [atext length])];
        lblTemp.attributedText = attributedString;
        
        CGSize size = [lblTemp sizeThatFits:CGSizeMake(aframe.size.width, MAXFLOAT)];
        aframe.size.height = size.height;
        lblTemp.frame=aframe;
        
    }
    return lblTemp;
}

+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext textAlignment:(NSTextAlignment)aalignment
{
    UILabel *baseLabel=[[UILabel alloc] initWithFrame:aframe];
    if(afont)baseLabel.font=afont;
    if(acolor)baseLabel.textColor=acolor;
//     baseLabel.lineBreakMode=UILineBreakModeCharacterWrap;
    baseLabel.text=atext;
    baseLabel.textAlignment=aalignment;
    baseLabel.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
    [baseLabel setLineBreakMode:NSLineBreakByTruncatingTail|NSLineBreakByWordWrapping];
    
    
    if(aframe.size.height>20){
        baseLabel.numberOfLines=0;
    }
    if (!aframe.size.height) {
        baseLabel.numberOfLines=0;
        CGSize size = [baseLabel sizeThatFits:CGSizeMake(aframe.size.width, MAXFLOAT)];
        aframe.size.height = size.height;
        baseLabel.frame = aframe;
    }else if (!aframe.size.width) {
        CGSize size = [baseLabel sizeThatFits:CGSizeMake(MAXFLOAT, 20)];
        aframe.size.width = size.width;
        baseLabel.frame = aframe;
    }
    //    baseLabel.adjustsFontSizeToFitWidth=YES
    baseLabel.backgroundColor=[UIColor clearColor];
    baseLabel.highlightedTextColor=acolor;//kVersion7?[UIColor whiteColor]:
    return baseLabel;// autorelease];
}


+(UIButton*)buttonWithFrame:(CGRect)_frame title:(NSString*)_title image:(NSString*)_image bgimage:(NSString*)_bgimage
{
    UIButton *baseButton=[UIButton buttonWithType:UIButtonTypeCustom];//[[UIButton alloc] initWithFrame:_frame];
    baseButton.frame=_frame;
    baseButton.titleLabel.font=Font(16);
    if (_title) {
        [baseButton setTitle:_title forState:UIControlStateNormal];
        [baseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if (_image) {
        [baseButton setImage:[UIImage imageNamed:_image] forState:UIControlStateNormal];
    }
    if (_bgimage) {
        UIImage *bg = [UIImage imageNamed:_bgimage];
        [baseButton setBackgroundImage:bg forState:UIControlStateNormal];
        if (_frame.size.height<0.00001) {
            _frame.size.height = bg.size.height*_frame.size.width/bg.size.width;
            [baseButton setFrame:_frame];
        }else if(_frame.size.width<0.00001) {
            _frame.size.width = bg.size.width*_frame.size.height/bg.size.height;
            _frame.origin.x = (kScreenWidth-_frame.size.width)/2.0;
            [baseButton setFrame:_frame];
        }
    }
    
    return baseButton;// autorelease];
}
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image
{
    return [self imageviewWithFrame:_frame defaultimage:_image stretchW:0 stretchH:0];// autorelease];
}
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image contentMode:(UIViewContentMode )cmode{
    UIImageView *imageT=[self imageviewWithFrame:_frame defaultimage:_image stretchW:0 stretchH:0];
    [imageT setContentMode:cmode];
    return imageT;
}
//-1 if want stretch half of image.size
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image stretchW:(NSInteger)_w stretchH:(NSInteger)_h
{
    UIImageView *imageview = nil;
    if(_image){
        if (_w&&_h) {
            UIImage *image = [UIImage imageNamed:_image];
            if (_w==-1) {
                _w = image.size.width/2;
            }
            if(_h==-1){
                _h = image.size.height/2;
            }
            imageview = [[UIImageView alloc] initWithImage:
                         [image stretchableImageWithLeftCapWidth:_w topCapHeight:_h]];
            imageview.contentMode=UIViewContentModeScaleToFill;
        }else{
            imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_image]];
            imageview.contentMode=UIViewContentModeScaleAspectFill;
        }
    }
    if (CGRectIsEmpty(_frame)) {
        [imageview setFrame:CGRectMake(_frame.origin.x,_frame.origin.y, imageview.image.size.width, imageview.image.size.height)];
    }else{
        [imageview setFrame:_frame];
    }
    imageview.clipsToBounds=YES;
    return  imageview;// autorelease];
}



+(UIView *)setTextViewWithFrame:(CGRect)frame leftRightEdge:(float)fLEdge topBottomEdge:(float)fTEdge font:(UIFont *)afont color:(UIColor *)acolor placeholder:(NSString *)placeholder delegate:(id<UITextViewDelegate>)delegate
{
    UIView *row = [[UIView alloc]init];
    row.frame = frame;
    row.userInteractionEnabled=YES;
    row.clipsToBounds = YES;
    
    UILabel *desc = [RHMethods labelWithFrame:CGRectMake(fLEdge+8, fTEdge+8, W(row)-2*fLEdge -16, 0) font:afont color:RGBACOLOR(200, 200, 200, 1) text:placeholder];
    desc.tag = 100;
    [row addSubview:desc];
    
    
    UITextView *content = [[UITextView alloc]initWithFrame:CGRectMake(fLEdge, fTEdge, W(row)-2*fLEdge, H(row)-2*fTEdge)];
    [row addSubview:content];
    content.tag = 200;
    content.backgroundColor=[UIColor clearColor];
    content.font = afont;
    content.textColor=acolor;
    content.delegate = delegate;
    [content setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
//    
//    desc.frame=CGRectMake(X(content)+8, Y(content)+8, W(desc),H(desc));
    
    return row;
}


+(UIView *)lineViewWithFrame:(CGRect)_frame
{
    UIView *viewLine=[[UIView alloc] initWithFrame:_frame];
    viewLine.backgroundColor=RGBACOLOR(80, 80, 80, 0.2);
    return viewLine;// autorelease];
}



+ (UITextField *)textFieldlWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor placeholder:(NSString *)aplaceholder text:(NSString*)atext supView:(UIView *)sView{
    UITextField *baseTextField=[[UITextField alloc]initWithFrame:aframe];
    [baseTextField setKeyboardType:UIKeyboardTypeDefault];
    [baseTextField setBorderStyle:UITextBorderStyleNone];
    [baseTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [baseTextField setTextColor:acolor];
    baseTextField.placeholder=aplaceholder;
    baseTextField.font=afont;
    [baseTextField setSecureTextEntry:NO];
    [baseTextField setReturnKeyType:UIReturnKeyDone];
    [baseTextField setText:atext];
    baseTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    if (sView) {
        [sView addSubview:baseTextField];
    }
    
    return baseTextField;
}


/**
 *	根据aframe返回相应高度的label（默认透明背景色，白色高亮文字）
 *
 *	@param	aframe	预期框架 若height=0则计算高度  若width=0则计算宽度
 *	@param	afont	字体
 *	@param	acolor	颜色
 *	@param	atext	内容
 *
 *	@return	UILabel
 */
+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext supView:(UIView *)sView
{
    return [self labelWithFrame:aframe font:afont color:acolor text:atext textAlignment:NSTextAlignmentLeft supView:sView];// autorelease];
}

/**
 *	根据aframe返回相应高度的label（默认透明背景色，白色高亮文字）
 *
 *	@param	aframe	预期框架 若height=0则计算高度  若width=0则计算宽度
 *	@param	afont	字体
 *	@param	acolor	颜色
 *	@param	atext	内容
 *  @param  aalignment   位置
 *  @param  afloat   行距(文本不能为空)
 *
 *	@return	UILabel
 */
+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext textAlignment:(NSTextAlignment)aalignment setLineSpacing:(float)afloat supView:(UIView *)sView
{
    UILabel *lblTemp=[self labelWithFrame:aframe font:afont color:acolor text:atext textAlignment:aalignment supView:sView];
    if (!aframe.size.height && [atext notEmptyOrNull]) {
        lblTemp.numberOfLines=0;
        
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:lblTemp.text];
        NSMutableParagraphStyle *paragraphStyleT = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyleT setLineSpacing:afloat];//调整行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyleT range:NSMakeRange(0, [atext length])];
        lblTemp.attributedText = attributedString;
        
        CGSize size = [lblTemp sizeThatFits:CGSizeMake(aframe.size.width, MAXFLOAT)];
        aframe.size.height = size.height;
        lblTemp.frame=aframe;
        
    }
    return lblTemp;
}

+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext textAlignment:(NSTextAlignment)aalignment supView:(UIView *)sView
{
    UILabel *baseLabel=[[UILabel alloc] initWithFrame:aframe];
    if(afont)baseLabel.font=afont;
    if(acolor)baseLabel.textColor=acolor;
    //     baseLabel.lineBreakMode=UILineBreakModeCharacterWrap;
    baseLabel.text=atext;
    baseLabel.textAlignment=aalignment;
    baseLabel.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
    [baseLabel setLineBreakMode:NSLineBreakByTruncatingTail|NSLineBreakByWordWrapping];
    
    
    if(aframe.size.height>20){
        baseLabel.numberOfLines=0;
    }
    if (!aframe.size.height) {
        baseLabel.numberOfLines=0;
        CGSize size = [baseLabel sizeThatFits:CGSizeMake(aframe.size.width, MAXFLOAT)];
        aframe.size.height = size.height;
        baseLabel.frame = aframe;
    }else if (!aframe.size.width) {
        CGSize size = [baseLabel sizeThatFits:CGSizeMake(MAXFLOAT, 20)];
        aframe.size.width = size.width;
        baseLabel.frame = aframe;
    }
    //    baseLabel.adjustsFontSizeToFitWidth=YES
    baseLabel.backgroundColor=[UIColor clearColor];
    baseLabel.highlightedTextColor=acolor;//kVersion7?[UIColor whiteColor]:
    if (sView) {
        [sView addSubview:baseLabel];
    }
    
    return baseLabel;// autorelease];
}


+(UIButton*)buttonWithFrame:(CGRect)_frame title:(NSString*)_title image:(NSString*)_image bgimage:(NSString*)_bgimage supView:(UIView *)sView
{
    UIButton *baseButton=[UIButton buttonWithType:UIButtonTypeCustom];//[[UIButton alloc] initWithFrame:_frame];
    baseButton.frame=_frame;
    baseButton.titleLabel.font=fontTitle;
    if (_title) {
        [baseButton setTitle:_title forState:UIControlStateNormal];
        [baseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if (_image) {
        [baseButton setImage:[UIImage imageNamed:_image] forState:UIControlStateNormal];
    }
    if (_bgimage) {
        UIImage *bg = [UIImage imageNamed:_bgimage];
        [baseButton setBackgroundImage:bg forState:UIControlStateNormal];
        if (_frame.size.height<0.00001) {
            _frame.size.height = bg.size.height*_frame.size.width/bg.size.width;
            [baseButton setFrame:_frame];
        }else if(_frame.size.width<0.00001) {
            _frame.size.width = bg.size.width*_frame.size.height/bg.size.height;
            _frame.origin.x = (kScreenWidth-_frame.size.width)/2.0;
            [baseButton setFrame:_frame];
        }
    }
    if (sView) {
        [sView addSubview:baseButton];
    }
    
    return baseButton;// autorelease];
}
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image supView:(UIView *)sView
{
    return [self imageviewWithFrame:_frame defaultimage:_image stretchW:0 stretchH:0 supView:sView];// autorelease];
}
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image contentMode:(UIViewContentMode )cmode supView:(UIView *)sView{
    UIImageView *imageT=[self imageviewWithFrame:_frame defaultimage:_image stretchW:0 stretchH:0 supView:sView];
    [imageT setContentMode:cmode];
    return imageT;
}
//-1 if want stretch half of image.size
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image stretchW:(NSInteger)_w stretchH:(NSInteger)_h supView:(UIView *)sView
{
    UIImageView *imageview = nil;
    if(_image){
        if (_w&&_h) {
            UIImage *image = [UIImage imageNamed:_image];
            if (_w==-1) {
                _w = image.size.width/2;
            }
            if(_h==-1){
                _h = image.size.height/2;
            }
            imageview = [[UIImageView alloc] initWithImage:
                         [image stretchableImageWithLeftCapWidth:_w topCapHeight:_h]];
            imageview.contentMode=UIViewContentModeScaleToFill;
        }else{
            imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_image]];
            imageview.contentMode=UIViewContentModeScaleAspectFill;
        }
    }
    if (CGRectIsEmpty(_frame)) {
        [imageview setFrame:CGRectMake(_frame.origin.x,_frame.origin.y, imageview.image.size.width, imageview.image.size.height)];
    }else{
        [imageview setFrame:_frame];
    }
    imageview.clipsToBounds=YES;
    if (sView) {
        [sView addSubview:imageview];
    }
    
    return  imageview;// autorelease];
}




+(UIView*)viewWithFrame:(CGRect)aframe backgroundcolor:(UIColor*)color superView:(UIView*)view{
    
    UIView*lineView=[UIView new];
    lineView.frame=aframe;
    lineView.backgroundColor=color;
    [view addSubview:lineView];
    return lineView;
    
    
}



+(UILabel*)lableX:(CGFloat)X Y:(CGFloat )Y W:(CGFloat)Width Height:(CGFloat)Height  font:(CGFloat)font  superview:(UIView*)superview withColor:coler text:(NSString*)text{
    
    
    if (coler==nil) {
        coler=RGBACOLOR(0x33, 0x33, 0x33, 1);
    }
    
    
    
    
    UILabel*lb=[RHMethods labelWithFrame:CGRectMake(X, Y, Width, Height) font:Font(font) color:RGBACOLOR(0x33, 0x33, 0x33, 1) text:text];
    
    if (Height==font&&Height!=0) {
        [lb setViewValue:@"1" forKey:@"lable"];
        
        //        lb.backgroundColor=BLUEZT;
        
        lb.frame=CGRectMake(X, Y-2, lb.frameWidth, Height+4);
    }
    //    lb.backgroundColor=BLUEZT;
    
    lb.textColor=coler;
    [superview addSubview:lb];
    
    return lb;
    
    
    
    
}
+(UILabel*)RlableRX:(CGFloat)RX Y:(CGFloat )Y W:(CGFloat)Width Height:(CGFloat)Height  font:(CGFloat)font  superview:(UIView*)superview withColor:coler text:(NSString*)text{
    if (coler==nil) {
        coler=RGBACOLOR(0x33, 0x33, 0x33, 1);
    }
    
    UILabel*lb=[RHMethods labelWithFrame:CGRectMake(RX, Y, Width, Height) font:Font(font) color:RGBACOLOR(0x33, 0x33, 0x33, 1) text:text];
    
    if (Height==font&&Height!=0) {
        [lb setViewValue:@"1" forKey:@"lable"];
        
        //        lb.backgroundColor=REDColor;
        lb.frame=CGRectMake(RX, Y-2,  lb.frameWidth, Height+4);
    }
    //     lb.backgroundColor=REDColor;
    
    lb.frameXW =superview.frameWidth-RX;
    lb.textAlignment=NSTextAlignmentRight;
    lb.textColor=coler;
    [superview addSubview:lb];
    return lb;
    
    
}
+(UILabel*)ClableY:(CGFloat )Y W:(CGFloat)Width Height:(CGFloat)Height  font:(CGFloat)font  superview:(UIView*)superview withColor:coler text:(NSString*)text{
    if (coler==nil) {
        coler=RGBACOLOR(0x33, 0x33, 0x33, 1);
    }
    
    
    UILabel*lb=[RHMethods labelWithFrame:CGRectMake(0, Y,Width, Height) font:Font(font) color:RGBACOLOR(0x33, 0x33, 0x33, 1) text:text];
    
    if (Height==font&&Height!=0) {
        [lb setViewValue:@"1" forKey:@"lable"];
        
        //        lb.backgroundColor=[UIColor greenColor];
        lb.frame=CGRectMake(0, Y-2,  lb.frameWidth, Height+4);
    }
    //      lb.backgroundColor=[UIColor greenColor];
    lb.centerX  =superview.frameWidth*0.5;
    lb.textAlignment=NSTextAlignmentCenter;
    lb.textColor=coler;
    [superview addSubview:lb];
    return lb;
    
    
    
}


+(WSSizeButton*)buttonWithframe:(CGRect)frame backgroundColor:(UIColor*)coler text:(NSString*)text font:(float)font textColor:(UIColor*)textcoler radius:(float)radius superview:(UIView*)superview{
    
    if (textcoler==nil) {
        textcoler=rgbTitleColor;
    }
    
    WSSizeButton*btn=[[WSSizeButton alloc]initWithFrame:frame];
    [btn setBackgroundColor:coler];
    [btn setTitle:text forState:UIControlStateNormal];
    
    [btn setTitleColor:textcoler forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:font];
    
    btn.layer.cornerRadius=radius;
    btn.layer.masksToBounds=YES;
    
    [superview addSubview:btn];
    
    return btn;
    
    
    
}

@end
