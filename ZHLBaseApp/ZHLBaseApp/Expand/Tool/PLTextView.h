//
//  PLTextView.h
//  
//
//  Created by 55like on 15/10/29.
//带Placeholder的UITextView
//

#import <UIKit/UIKit.h>
#pragma mark zxhalwaysuse 常用 带Placeholder的UITextView
/**
 带Placeholder的UITextView
 */
@interface PLTextView : UITextView

/**
 placeholder 文字
 */
@property(nonatomic,copy) NSString *Placeholder;  //文字

/**
 placeholder文字颜色
 */
@property(nonatomic,strong) UIColor *PlaceholderColor; //文字颜色
@end
