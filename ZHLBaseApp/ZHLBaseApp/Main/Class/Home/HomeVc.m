//
//  HomeVc.m
//  ZHLBaseApp
//
//  Created by zzz on 2017/5/15.
//  Copyright © 2017年 zzz. All rights reserved.
//

#import "HomeVc.h"
#import "homemodel.h"
#import "NSString+QTool.h"
#import "AppDelegate.h"
#import "BaseTableView.h"
#import "OneTableViewCell.h"
#import "MLSelectPhotoPickerViewController.h"
#import "MLSelectPhotoAssets.h"
#import "KNPhotoBrower.h"


@interface HomeVc ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *mainTableView;
@property (nonatomic,strong)NSMutableDictionary * cellid;

@end

@implementation HomeVc

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    UILabel * label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 0, 100, 20);
    label.center = self.view.center;
    label.text = @"hello world";
//    [self.view addSubview:label];
    
    homemodel  * model = [homemodel modelWithDictionary:self.diction];
//     = model.num;
    NSString * str = [NSString stringWithFormat:@"%d",model.num];
    NSLog(@"-------%@",str);
    label.text = [NSString stringWithFormat:@"%d",model.num];
    label.text = @"识别图中的二维码";
    label.backgroundColor = rgbColor(@"00aeef");
    label.font = Font(13);
    
    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(80, 60, 90, 90)];
    [self.view addSubview:imageview];
    imageview.image = [UIImage imageNamed:@"QQ20170516-181104"];
    [imageview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(show:)]];
    imageview.userInteractionEnabled = YES;
   
    [self bcke:^(NSString *str, NSString *po) {
        
        
        
        
        
        
    }];
    
    UITextField * textField = [[UITextField alloc]initWithFrame:CGRectMake(50,100 , 200, 30)];
    textField.placeholder = @"呵呵哈哈哈";
    textField.center = self.view.center;
    textField.font = Font(14);
    textField.backgroundColor = [UIColor redColor];
    [self.view addSubview:textField];
    
    
    PLTextView * textview = [[PLTextView alloc]initWithFrame:CGRectMake(10, 200, 200, 200)];
    textview.Placeholder = @"哈哈哈哈";
    [self.view addSubview:textview];
    
    [UTILITY showLoginAlert:YES];
//    [self.view addSubview:table];
    
//    [self.mainTableView reloadData];
}

-(void)show:(UITapGestureRecognizer *)tgr{
    
    UIImageView * image = (UIImageView *)tgr.view;
    
    UIImage * imageve = image.image;
    
    [imageve HaveQRCode];
    
    
//    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
//    
//    
//    image.image = [appDelegate.window screenshot];
    
    
}
#pragma mark ---- UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    
    return 1;
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 3;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return 100;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    
    
    return 10;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    EMWeakSelf(weakSelf);
    
    
//    TwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TwoTableViewCellID" forIndexPath:indexPath];
    homemodel  * model = [homemodel modelWithDictionary:self.diction];
    
    
    
    NSString *identifier = [_cellid objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    
    if (identifier == nil) {
        
        identifier = [NSString stringWithFormat:@"TwoTableViewCell%@ID",indexPath];
        [_cellid setValue:identifier forKey:[NSString stringWithFormat:@"%@",indexPath]];
        // 注册Cell
        [tableView registerClass:[TwoTableViewCell class] forCellReuseIdentifier:identifier];
        
        
    }
    
    TwoTableViewCell * cell = [TwoTableViewCell initWithNoRepeatModel:model tableview:tableView cellID:identifier indexPath:indexPath];
    
  
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    EMWeakSelf(weakSelf);
    
    
    
}

-(NSDictionary *)diction{
    
    
    
    return @{@"str":@[@"小白"],@"num":@8,@"title":@"小明"};
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)openLibrary{
    
    MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
    //        pickerVc.delegate = self;
    // Default Push CameraRoll
    pickerVc.status = PickerViewShowStatusCameraRoll;
    // Limit Count.
    pickerVc.maxCount = 9;
    // Push
    [pickerVc showPickerVc:self];
    EMWeakSelf(weakSelf);
    // 选择完毕回调方法
    pickerVc.callBack = ^(NSArray *assets){
        
        
        for (id timg in assets) {
            MLSelectPhotoAssets *aset = timg;
            //将照片压缩并添加至数组，
            UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
            image.image = aset.originImage;
            [self.view addSubview:image];
            
        }
        
        
        
        
        
    };
    
}
//判断
-(void) validateUrl: (NSURL *) candidate {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:candidate];
    [request setHTTPMethod:@"HEAD"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"error %@",error);
        if (!request && error) {
            NSLog(@"不可用");
        }else{
            NSLog(@"可用%@",request);
        }
    }];
    [task resume];
}

- (NSURL *)smartURLForString:(NSString *)str {
    NSURL *     result;
    NSString *  trimmedStr;
    NSRange     schemeMarkerRange;
    NSString *  scheme;
    assert(str != nil);
    result = nil;
    trimmedStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ( (trimmedStr != nil) && (trimmedStr.length != 0) ) {
        schemeMarkerRange = [trimmedStr rangeOfString:@"://"];
        if (schemeMarkerRange.location == NSNotFound) {
            result = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", trimmedStr]];
        } else {
            scheme = [trimmedStr substringWithRange:NSMakeRange(0, schemeMarkerRange.location)];
            assert(scheme != nil);
            if ( ([scheme compare:@"http"  options:NSCaseInsensitiveSearch] == NSOrderedSame)
                || ([scheme compare:@"https" options:NSCaseInsensitiveSearch] == NSOrderedSame) ) {
                result = [NSURL URLWithString:trimmedStr];
            } else {
                // 格式不符合
            }
        }
    }
    
    return result;
}

-(void)bcke:(void (^)(NSString * str,NSString * po))block{
    
    
   
    
    
    
}
@end
