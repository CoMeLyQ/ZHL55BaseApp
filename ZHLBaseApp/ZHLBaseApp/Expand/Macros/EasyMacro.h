//
//  EasyMacro.h
//  ZHLBaseApp
//
//  Created by zzz on 2017/5/15.
//  Copyright © 2017年 zzz. All rights reserved.
//

#ifndef EasyMacro_h
#define EasyMacro_h


//用户资料
#define default_pwd @"default_pwd"
#define default_userName @"default_userName"
#define default_userLogo @"default_userLogo"
#define default_userId @"default_userId"
#define default_userToken @"default_userToken"
#define default_userPhone @"default_userPhone"


//路径
#define userDacData [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/userDacData.plist"]


#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//标题栏高度//状态栏
#define Status_H 20
#define Nav_H 64
#define TabBar_H 50
#define Row_H (EMSCREEN_W>320?48:44)
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define W(obj)   (!obj?0:(obj).frame.size.width)
#define H(obj)   (!obj?0:(obj).frame.size.height)
#define X(obj)   (!obj?0:(obj).frame.origin.x)
#define Y(obj)   (!obj?0:(obj).frame.origin.y)
#define XW(obj) (X(obj)+W(obj))
#define YH(obj) (Y(obj)+H(obj))
#define BoldFont(x) [UIFont boldSystemFontOfSize:x]
#define Font(x) [UIFont systemFontOfSize:x]
#define EM_Camera_Auth  @"应用没有相机权限，请前往“设置>隐私相机”中开启相机权限。"
#define EM_Photos_Auth  @"应用没有相册权限，请前往“设置>隐私>相册”中开启相册权限。"
#define EM_Contact_Auth @"应用没有通讯录权限，请前往“设置>隐私>相册”中开启相册权限。"
#define kVersion7 ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)


/** 输出*/
#ifdef DEBUG
#define EMLog(...) NSLog(__VA_ARGS__)
#else
#define EMLog(...)
#endif

/** 适配*/
#define EMiOS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define EMiOS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define EMiOS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define EMiOS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define EMiOS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define EMiOS_10_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)

/** 弱指针*/
#define EMWeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;





// 消息通知
#define RegisterNotify(_name, _selector)                    \
[[NSNotificationCenter defaultCenter] addObserver:self  \
selector:_selector name:_name object:nil];

#define RemoveNofify            \
[[NSNotificationCenter defaultCenter] removeObserver:self];

#define SendNotify(_name, _object)  \
[[NSNotificationCenter defaultCenter] postNotificationName:_name object:_object];


#endif /* EasyMacro_h */
