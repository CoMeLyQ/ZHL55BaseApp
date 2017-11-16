
#import <UIKit/UIKit.h>



@interface BaseViewController : UIViewController
@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) id  userInfo;
@property (nonatomic,strong) id  otherInfo;
@property (nonatomic,strong) UIButton *navleftButton;
@property (nonatomic,strong) UIButton *navrightButton;

//需要Base来配置头部
- (BaseViewController*)pushController:(Class)controller withInfo:(id)info withTitle:(NSString*)title withOther:(id)other animated:(BOOL)ifanimated;
//不需要Base来配置头部
- (BaseViewController*)pushController:(Class)controller withOnlyInfo:(id)info withOther:(id)other animated:(BOOL)ifanimated;
//配置头部
- (UIView*)navbarTitle:(NSString*)title;
- (UIButton*)leftButton:(NSString*)title image:(NSString*)image sel:(SEL)sel;
- (UIButton*)rightButton:(NSString*)title image:(NSString*)image sel:(SEL)sel;
//返回到指定页面
- (void)popController:(NSString*)controllerstr withSel:(SEL)sel withObj:(id)info;
//返回上一页面
-(void)returnVC;
@end
