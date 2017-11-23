//
//  TEXT.h
//  ZHLBaseApp
//
//  Created by sh-lx on 2017/11/23.
//  Copyright © 2017年 zzz. All rights reserved.
//

#ifndef TEXT_h
#define TEXT_h






/**
 //tableview常用创建
@property (nonatomic,strong)UITableView * zhltableView;

static NSString * CRMListTableViewCellID  = @"CRMListTableViewCellID";
static NSString * CRMMenuTableViewCellID  = @"CRMMenuTableViewCellID";

-(UITableView *)zhltableView{
    
    if (!_zhltableView) {
        
        UITableView * zhltableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        zhltableView.delegate = self;
        zhltableView.dataSource = self;
        //分割线
        zhltableView.separatorInset=UIEdgeInsetsMake(0,0, 0, 0);
        zhltableView.backgroundColor = rgbGray;
        zhltableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        zhltableView.showsVerticalScrollIndicator = NO;
        zhltableView.showsHorizontalScrollIndicator = NO;
        //ios 11 后添加
        zhltableView.sectionHeaderHeight = 0;
        zhltableView.sectionFooterHeight = 0;
        [self.view addSubview:zhltableView];
        [zhltableView registerClass:[CRMListTableViewCell class] forCellReuseIdentifier:CRMListTableViewCellID];
        
        _zhltableView = zhltableView;
    }
    _zhltableView.tableHeaderView = self.tableivewHeaderView;
    _zhltableView.tableHeaderView = self.tableivewFooterView;
    
    
    
    return _zhltableView;
}
-(UIView *)tableivewHeaderView{
    
    
    UIView * tableivewHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    
    
    return tableivewHeaderView;
}
-(UIView *)tableivewFooterView{
    
    
    UIView * tableivewFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    
    
    return tableivewFooterView;
}
#pragma mark -  tableview代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 2 ;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 10;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section    {
    
    
    
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    return headerView;
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    return footerView;
    
    
}
#pragma mark  cell处理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CRMListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CRMListTableViewCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
    
}
#pragma mark  选中cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"%@",indexPath);
    
    
    
    
    
}

 
*/

/**
 //textField常用协议


//是否可以开始编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    //实时监听输入框的内容
    //    [textField addTarget:self action:@selector(passConTextChange:)  forControlEvents:UIControlEventEditingChanged];
    
    
    return YES;
    
}

//已经开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    
}
//是否可以结束编辑
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    
    return YES;
    
}
//已经结束编辑
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    
    
}
//编辑时候调用
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    
    return YES;
    
}


//返回一个BOOL值指明是否允许根据用户请求清除内容
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    
    
    return YES;
    
}
//按return键调用
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //收件盘
    [textField resignFirstResponder];
    
    return YES;
    
}  
 
 */

/**
#pragma mark - UITextViewDelegate协议中的方法
//将要进入编辑模式
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    
    return YES;
}
//已经进入编辑模式
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    
}
//将要结束/退出编辑模式
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    
    return YES;
}
//已经结束/退出编辑模式
- (void)textViewDidEndEditing:(UITextView *)textView{
    
}
//当textView的内容发生改变的时候调用
- (void)textViewDidChange:(UITextView *)textView{
    
}
//选中textView 或者输入内容的时候调用
- (void)textViewDidChangeSelection:(UITextView *)textView{
    
}
//从键盘上将要输入到textView 的时候调用
//rangge  光标的位置
//text  将要输入的内容
//返回YES 可以输入到textView中  NO不能
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    
    return YES;
    
    
}
*/


#endif /* TEXT_h */
