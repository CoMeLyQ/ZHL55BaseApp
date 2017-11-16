//
//  BaseTableView.m
//  ZHLBaseApp
//
//  Created by zzz on 2017/5/16.
//  Copyright © 2017年 zzz. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style delegate:(id)adddelegate separatorStyle:(UITableViewCellSeparatorStyle)stype backColor:(NSString *)colorstr cellIDArray:(NSArray *)cellids{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.delegate = adddelegate;
        self.dataSource = adddelegate;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = stype;
        self.backgroundColor = rgbColor(colorstr);
        
        for (NSString * cellid in cellids) {
            
           Class cell = NSClassFromString(cellid);
            
            [self registerClass:cell forCellReuseIdentifier:[NSString stringWithFormat:@"%@ID",cellid]];
            
        }
        
    }
    
    return self;
}


@end
