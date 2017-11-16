//
//  BaseCollectionViewCell.h
//  ZHLBaseApp
//
//  Created by zzz on 2017/5/16.
//  Copyright © 2017年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseModel;


@interface BaseCollectionViewCell : UICollectionViewCell



// 在父类中申明出一个BaseModel对象，在其子类里重写set方法，在set方法内部去做赋值操作
@property (nonatomic, strong) BaseModel *baseModel;

+ (instancetype)initWithModel:(BaseModel *)model cellID:(NSString *)cellid;



@end
