//
//  BaseTableView.h
//  ZHLBaseApp
//
//  Created by zzz on 2017/5/16.
//  Copyright © 2017年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableView : UITableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style delegate:(id)adddelegate separatorStyle:(UITableViewCellSeparatorStyle)stype backColor:(NSString *)colorstr cellIDArray:(NSArray *)cellids;


@end
