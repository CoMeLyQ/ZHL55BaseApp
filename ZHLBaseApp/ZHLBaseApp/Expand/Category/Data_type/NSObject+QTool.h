//
//  NSObject+QTool.h
//  NongKa
//
//  Created by 衷宏磊 on 16/6/12.
//  Copyright © 2016年 衷宏磊. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSObject (QTool)


-(NSString *)JSONString_l;
//一切转为字符串
-(NSString *)js_str;

#pragma mark - 获取最新一张图片
+ (void)GetlatestImageForTakeScreenshot:(BOOL)isTakeScreenshot finished:(void (^)(UIImage *image))finished;
#pragma mark - 获取相簿所有图片
+(void)GetAllImagesInPhotoAlbumFinished:(void (^)(NSMutableArray *images))Finished;
//打印数据
-(NSString*)jsonStrSYS;

@end
