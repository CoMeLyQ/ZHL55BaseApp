//
//  NSString+QTool.h
//  teacher
//
//  Created by 衷宏磊 on 16/5/9.
//  Copyright © 2016年 xiayp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (QTool)
/**
 *  返回字符串需要所占的空间
 *
 *  @param font    字符串字号
 *  @param maxSize 最大的范围
 *
 *  @return 返回范围
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

- (NSString *)md5Str;
- (NSString *)md5_32;
//- (NSString*) sha1Str;

+ (NSString *)getTimeBySeparator:(NSString *)sep;
+ (NSString *)getTimeMinBySeparator:(NSString *)sep;
+ (NSString *)getTimeByDate:(NSDate *)date Separator:(NSString *)sep;
- (NSDate *)changeToDateWithSeparator:(NSString *)sep;
/**
 *  返回xx小时/天前
 *
 *  @param compareDate 需要和现在比较的时间
 *
 *  @return xx小时/天前
 */
+ (NSString *) compareCurrentTime:(NSString *) compareDate;
- (BOOL)isSameDay:(NSString *)dateStr;

+ (NSString *)getYearByDate:(NSDate *)date;
+ (NSString *)getMonthByDate:(NSDate *)date;
+ (NSString *)getDateByDate:(NSDate *)date;
+ (NSString *)getYearMonthByDate:(NSDate *)date;
+ (NSString *)getTimeByDate:(NSDate *)date;


+ (NSString *)getMinSecStringByDate:(NSDate *)date;
+ (NSDate *)getMinSecDateByString:(NSString *)str;

/**
 *  为字符串格式的ininteger数字设置增量
 *
 *  @param increment 增量
 *
 *  @return +了增量后的字符串格式数字
 */
- (NSString *)setIncrement:(NSInteger)increment;
- (NSDate *)getDate;



+ (NSString *)trimWhitespace:(NSString *)val;//去掉前后空格
+ (NSString *)trimNewline:(NSString *)val;//去掉前后回车符
+ (NSString *)trimWhitespaceAndNewline:(NSString *)val;//去掉前后空格和回车符

/**
 *  返回字符串需要所占的空间
 *
 *  @param font    字符串字号
 *  @param maxWidth 宽度
 *
 *  @return 返回高度
 */
- (CGFloat)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

//返回labl宽度
- (CGFloat)sizeWithWidthFont:(UIFont *)font text:(NSString *)str labH:(CGFloat)H;

- (BOOL)notEmptyOrNull;





/*
 给金额字符串添加分割标示，例：33，345，434.98
 */
+(NSString *)ResetAmount:(NSString *)Amount_str segmentation_index:(int)segmentation_index segmentation_str:(NSString *)segmentation_str;
/*
 根据当前语言国际化
 */
+(NSString *)LanguageInternationalizationCH:(NSString *)Chinese EN:(NSString *)English;
/**
 *  @brief  掉头反转字符串
 */
- (NSString *)StringReverse;
//编码反编码
-(NSString *)EncodingString;
-(NSString *)RemovingEncoding;

#pragma mark - string of size
- (CGSize)sizeWithFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font andMaxW:(CGFloat)maxW;
#pragma mark - nil NULL "space"
+(BOOL)isNULL:(id)string;
#pragma md5
- (NSString *)MD5string;
/*
 把JSON格式的字符串转换成字典
 */
- (NSDictionary *)StringOfJsonConversionDictionary;
/**
 *  字符串添加图片
 */
-(NSMutableAttributedString *)insertImg:(UIImage *)Img atIndex:(NSInteger )index IMGrect:(CGRect )IMGrect;
/**
 *  不同颜色不同字体大小字符串
 */
-(NSMutableAttributedString *)setOtherColor:(UIColor *)Color font:(CGFloat)font forStr:(NSString *)forStr;
/*
 在文字上添加删除线（例如过去的价格）
 */
-(NSAttributedString *)AddRemoveLineOnStringRange:(NSRange )range lineWidth:(NSInteger )lineWidth;

- (BOOL)isChinese;
- (NSString *)pinyin;
- (NSString *)pinyinInitial;

- (BOOL)isEmail;
- (BOOL)isPhoneNumber;
- (BOOL)isDigit;
- (BOOL)isNumeric;
- (BOOL)isUrl;
- (BOOL)isMinLength:(NSUInteger)length;
- (BOOL)isMaxLength:(NSUInteger)length;
- (BOOL)isMinLength:(NSUInteger)min andMaxLength:(NSUInteger)max;
- (BOOL)isEmpty;

/////将NSString转化为NSArray或者NSDictionary
-(id)JSONValue;
/////将NSString转化为NSArray或者NSDictionary
-(id)objectFromJSONString;
//解析网络数据
-(NSDictionary*)tojsonDictionary;

@end
