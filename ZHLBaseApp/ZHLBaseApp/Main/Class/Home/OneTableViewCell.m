//
//  OneTableViewCell.m
//  ZHLBaseApp
//
//  Created by zzz on 2017/5/16.
//  Copyright © 2017年 zzz. All rights reserved.
//

#import "OneTableViewCell.h"

@implementation OneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation TwoTableViewCell


-(void)setBaseModel:(BaseModel *)baseModel{
    
    homemodel * model = (homemodel *)baseModel;
    
    self.lab = [[UILabel alloc]init];
    self.lab.frame = CGRectMake(0, 0, 100, 20);
    self.lab.text = [model.title js_str];
    [self addSubview:self.lab];
    
    
}


@end

@implementation ThreeTableViewCell
@end


