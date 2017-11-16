//
//  WSSizeButton.m
//  HairDressing
//
//  Created by 55like on 22/03/2017.
//  Copyright © 2017 55like. All rights reserved.
//

#import "WSSizeButton.h"



@interface WSSizeButton ()



-(void)setImageviewsize:(ButtonSize)imageviewsize;

-(void)setLableviewSize:(ButtonSize)lableviewSize;


@end

@implementation WSSizeButton

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
//    return [super titleRectForContentRect:contentRect];
 
    if (_lableviewSize!=nil) {
        return _lableviewSize(self);
    }else{
        
        return [super titleRectForContentRect:contentRect];
    }
    
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    
    if (_imageviewsize!=nil) {
        return _imageviewsize(self);
    }else{
        
        return [super imageRectForContentRect:contentRect];
    }
}



-(void)setImageviewColor:(UIColor *)color forState:(UIControlState)state{

    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    [self setImage:theImage forState:state];
    
//    return theImage;


}
-(void)setBackGroundImageviewColor:(UIColor *)color forState:(UIControlState)state{

    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self setBackgroundImage:theImage forState:state];

}

-(void)setBtnLableFrame:(CGRect)btnLableFrame{
    _btnLableFrame=btnLableFrame;

    
    [ self setLableviewSize:^CGRect(WSSizeButton *btn) {
        return btnLableFrame;
    }];
    [self layoutSubviews];

}


-(void)setBtnImageViewFrame:(CGRect)btnImageViewFrame{
    _btnImageViewFrame=btnImageViewFrame;
    
    [self setImageviewsize:^CGRect(WSSizeButton *btn) {
        
        return btnImageViewFrame;
        
    }];
    [self layoutSubviews];

}



@end
