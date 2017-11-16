//
//  NSObject+QTool.m
//  NongKa
//
//  Created by 衷宏磊 on 16/6/12.
//  Copyright © 2016年 衷宏磊. All rights reserved.
//

#import "NSObject+QTool.h"
#import <objc/runtime.h>
#import <PhotosUI/PhotosUI.h>

@implementation NSObject (QTool)
//+ (void)showHudTipStr:(NSString *)tipStr{
//    if (tipStr && tipStr.length > 0) {
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:qKeyWindow animated:YES];
//        hud.mode = MBProgressHUDModeText;
//        hud.detailsLabelFont = [UIFont boldSystemFontOfSize:15.0];
//        hud.detailsLabelText = tipStr;
//        hud.margin = 10.f;
//        hud.removeFromSuperViewOnHide = YES;
//        [hud hide:YES afterDelay:1.0];
//    }
//}
+ (void)showStatusBarQueryStr:(NSString *)tipStr{
//    [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
//    [JDStatusBarNotification showWithStatus:tipStr dismissAfter:1.0 styleName:JDStatusBarStyleSuccess];
}
///将NSArray或者NSDictionary转化为NSString
-(NSString *)JSONString_l
{
    NSError* error = nil;
    id data = [NSJSONSerialization dataWithJSONObject:self
                                              options:kNilOptions
                                                error:&error];
    if (error != nil){
       
        return nil ;
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];;
}
-(NSString *)js_str{
    
    NSString * str = [NSString stringWithFormat:@"%@",self];
    
    return str;
}




#pragma mark - 获取最新一张图片
+ (void)GetlatestImageForTakeScreenshot:(BOOL)isTakeScreenshot finished:(void (^)(UIImage *image))finished {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((isTakeScreenshot ? 1 : 0) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
        PHAsset *asset = [assetsFetchResults firstObject];
        PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
        [imageManager requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            if (imageData) {
                finished([UIImage imageWithData:imageData]);
            }
        }];
    });
}
#pragma mark - 获取相册所有图片
+(void)GetAllImagesInPhotoAlbumFinished:(void (^)(NSMutableArray *images))Finished
{
    __block NSMutableArray *arrayOfimages = [NSMutableArray array];
    [self GetImageInPhotoAlbumOneByOne:^(UIImage *currentImage, NSUInteger count) {
        [arrayOfimages addObject:currentImage];
        if (arrayOfimages.count == count) {
            
            Finished(arrayOfimages);
        }
    }];
}
+ (void)GetImageInPhotoAlbumOneByOne:(void (^)(UIImage *currentImage, NSUInteger count))finishing{
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    [assetsFetchResults enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        PHAsset *asset = obj;
        if (asset.mediaType == PHAssetMediaTypeImage) {
            
            PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
            [imageManager requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                if (imageData) {
                    finishing([UIImage imageWithData:imageData],[assetsFetchResults countOfAssetsWithMediaType:PHAssetMediaTypeImage]);
                }
            }];
        }
    }];
}
//打印数据
-(NSString *)jsonStrSYS{
    NSError *parseError = nil;
    NSDictionary*dic=[self getpuredic];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
#pragma mark  wd 打印字符串注释
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    return [[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
}

-(NSDictionary*)getpuredic{
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary*msdic=[NSMutableDictionary new];
        //    [mstr appendString:@"{\n"];
        NSArray*keyArry=[(NSDictionary*)self allKeys];
        for (NSString *keyname in keyArry) {
            NSObject*obj=[(NSDictionary*)self objectForJSONKey:keyname];
            obj= [(NSDictionary*)obj getpuredic];
            if (obj) {
                
                [msdic setValue:obj forKey:keyname];
            }
            
        }
        return msdic;
    }
    if ([self isKindOfClass:[NSString class]]) {
        return (NSDictionary*)self;
    }
    if ([self isKindOfClass:[NSNumber class]]) {
        return (NSDictionary*)self;
    }
    if ([self isKindOfClass:[NSArray class]]) {
        
        NSMutableArray*array=[NSMutableArray new];
        for (NSDictionary*dic in (NSArray*)self) {
            [array addObject:[dic getpuredic]];
        }
        return (NSDictionary*)array;
    }
    
    //    return self.wkeyValues;
    return [NSDictionary new];
    
}



@end
