//
//  BaseTableViewCell.m
//  ZHLBaseApp
//
//  Created by zzz on 2017/5/16.
//  Copyright © 2017年 zzz. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

+ (instancetype)initWithModel:(BaseModel *)model tableview:(UITableView *)tableview cellID:(NSString *)cellid indexPath:(NSIndexPath *)indexPath
{

    NSString *cellName = [cellid stringByAppendingString:@"ID"];
    BaseTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
    if (model) {
       cell.baseModel = model;
    }
    
    
    return cell;
    
}

+ (instancetype)initWithNoRepeatModel:(BaseModel *)model tableview:(UITableView *)tableview cellID:(NSString *)cellid indexPath:(NSIndexPath *)indexPath
{
    
    BaseTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    if (model) {
        cell.baseModel = model;
    }
    
    return cell;
    
}


@end
