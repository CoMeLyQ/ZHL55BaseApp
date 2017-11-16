//
//  QBaseData.m
//  55likeLibDemo
//
//  Created by 55like on 2017/9/28.
//  Copyright © 2017年 55like lj. All rights reserved.
//

#import "QBaseData.h"

@implementation QBaseData


static QBaseData *_qBaseData=nil;
static dispatch_once_t qBaseData;

+(id)Share
{
    dispatch_once(&qBaseData, ^ {
        _qBaseData = [[QBaseData alloc] init];
    });
    return _qBaseData;
}


@end
