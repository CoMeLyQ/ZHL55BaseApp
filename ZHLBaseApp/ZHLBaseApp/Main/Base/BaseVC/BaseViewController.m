
#import "BaseViewController.h"



//Category声明：
@interface UIControl (Additions)
- (void)removeAllTargets;
@end
//Category实现：
@implementation UIControl (Additions)
- (void)removeAllTargets {
    for (id target in [self allTargets]) {
        [self removeTarget:target action:NULL forControlEvents:UIControlEventAllEvents];
    }
}
@end

@interface BaseViewController ()

@end


@implementation BaseViewController

- (id)initWithNavStyle:(NSInteger)style
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    if (kVersion7) {
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
  
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (kVersion7) {
        
        self.automaticallyAdjustsScrollViewInsets=NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navigationController.navigationBarHidden = YES;
   // self.hidesBottomBarWhenPushed=YES;
    [self.view setClipsToBounds:YES];
    [self.view setBackgroundColor:[UIColor whiteColor]];

}

- (UIView*)navbarTitle:(NSString*)title
{
 
    if(!self.navView)
    {
        self.navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kVersion7?64:44)];
        UIView * huiview = [[UIView alloc]initWithFrame:CGRectMake(0, 63, kScreenWidth, 1)];
        huiview.backgroundColor =[RGBColor colorWithHexString:@"#DCDCDC"];
        [self.navView addSubview:huiview];
        [self.navView setBackgroundColor:mainColor];
        self.navView.clipsToBounds = NO;
        if (title.length) {
            UIView *nV=[[UIView alloc]initWithFrame:CGRectMake(60, kVersion7?20:0, kScreenWidth-120, 44)];
            nV.backgroundColor=[UIColor clearColor];
            nV.clipsToBounds=YES;
            nV.tag=102;
            
            CAGradientLayer* gradientMask = [CAGradientLayer layer];
            gradientMask.bounds = nV.layer.bounds;
            gradientMask.position = CGPointMake([nV bounds].size.width / 2, [nV bounds].size.height / 2);
            NSObject *transparent = (NSObject*) [[UIColor clearColor] CGColor];
            NSObject *opaque = (NSObject*) [[UIColor blackColor] CGColor];
            gradientMask.startPoint = CGPointMake(0.0, CGRectGetMidY(nV.frame));
            gradientMask.endPoint = CGPointMake(1.0, CGRectGetMidY(nV.frame));
            float fadePoint = (float)10/nV.frame.size.width;
            [gradientMask setColors: [NSArray arrayWithObjects: transparent, opaque, opaque, transparent, nil]];
            [gradientMask setLocations: [NSArray arrayWithObjects:
                                         [NSNumber numberWithFloat: 0.0],
                                         [NSNumber numberWithFloat: fadePoint],
                                         [NSNumber numberWithFloat: 1 - fadePoint],
                                         [NSNumber numberWithFloat: 1.0],
                                         nil]];
            nV.layer.mask = gradientMask;
            
            
           
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-140, 44)];
            label.backgroundColor = [UIColor clearColor];
            label.font = Font(17);
            label.textColor  = [UIColor whiteColor];
            label.shadowOffset = CGSizeMake(0, 0);
            label.text = title;
            label.tag = 101;
            label.textAlignment = NSTextAlignmentCenter;
            [nV addSubview:label];
            [self.navView addSubview:nV];
        }
        
        [self.view addSubview:self.navView];
    }
    
    return self.navView;
    
}



- (UIButton*)leftButton:(NSString*)title image:(NSString*)image sel:(SEL)sel
{
    if (!self.navleftButton) {
        self.navleftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, kVersion7?20:0, 100, 44)];
    }
    if(image)[self.navleftButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    if(title){
        [self.navleftButton setTitle:title forState:UIControlStateNormal];
        [self.navleftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.navleftButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -47, 0, 0)];
        [self.navleftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -47, 0, 0)];
        
        self.navleftButton.titleLabel.font = Font(15);
    }
    [self.navleftButton removeAllTargets];
    if(sel)[self.navleftButton addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:self.navleftButton];
    return self.navleftButton;
}

- (UIButton*)rightButton:(NSString*)title image:(NSString*)image sel:(SEL)sel
{
    if (!self.navrightButton) {
        self.navrightButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-110,kVersion7?20:0, 100, 44)];
    }
    if(image){
        [self.navrightButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [self.navrightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)];
    }
    if(title){
        [self.navrightButton setTitle:title forState:UIControlStateNormal];
        [self.navrightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.navleftButton.titleLabel.textAlignment = NSTextAlignmentRight;
        if (image) {
            [self.navrightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
            [self.navrightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
        }else{
            [self.navrightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
        }
        self.navrightButton.titleLabel.font = Font(15);
        
    }
    [self.navrightButton removeAllTargets];
    self.navrightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    if(sel)[self.navrightButton addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:self.navrightButton];
    return self.navrightButton;
}







- (BaseViewController*)pushController:(Class)controller withInfo:(id)info withTitle:(NSString*)title withOther:(id)other animated:(BOOL)ifanimated
{
    
    BaseViewController *base = [[controller alloc] init];
    
    if ([(NSObject*)base respondsToSelector:@selector(setUserInfo:)]) {
        base.userInfo = info;
        base.otherInfo = other;
    }
//    base.hidesBottomBarWhenPushed=abool;
    base.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:base animated:ifanimated];
    if ([(NSObject*)base respondsToSelector:@selector(setUserInfo:)]) {
        //如果次级controller自定义了title优先展示
      
        [base navbarTitle:title];
        if (base.navleftButton) {
            [base.navView addSubview:base.navleftButton];
        }else{
            
            [base leftButton:@"" image:@"icon_导航栏返回键" sel:@selector(returnVC)];
            
        }
        if (base.navrightButton) {
            [base.navView addSubview:base.navrightButton];
        }
        
        
        
        
    }
    return base;
}

-(void)returnVC{
    
    
    [self.navigationController popViewControllerAnimated:YES];
   
    
}


//不需要Base来配置头部
- (BaseViewController*)pushController:(Class)controller withOnlyInfo:(id)info withOther:(id)other animated:(BOOL)ifanimated
{
  
    BaseViewController *base = [[controller alloc] init];
    if ([(NSObject*)base respondsToSelector:@selector(setUserInfo:)]) {
        base.userInfo = info;
        base.otherInfo = other;
    }
    base.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:base animated:ifanimated];
    return base;
}




- (void)lj_popController:(id)controller
{
    //Class cls = NSClassFromString(controller);
    if ([controller isKindOfClass:[UIViewController class]]) {
        [self.navigationController popToViewController:controller animated:YES];
    }else{
      
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)popController:(NSString*)controllerstr withSel:(SEL)sel withObj:(id)info
{
    
    for (id controller in self.navigationController.viewControllers) {
        if ([NSStringFromClass([controller class]) isEqualToString:controllerstr]) {
            if ([(NSObject*)controller respondsToSelector:sel]) {
                [controller performSelector:sel withObject:info afterDelay:0.01];
            }
            [self lj_popController:controller];
            break;
        }
    }
}

- (void)popController:(NSString*)controller
{
    Class cls = NSClassFromString(controller);
    if ([cls isSubclassOfClass:[UIViewController class]]) {
        [self.navigationController popToViewController:(UIViewController*)cls animated:YES];
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -Notify
-(void) reachabilityChanged:(NSNotification*) notification
{
    if ([(Reachability*)[notification object] currentReachabilityStatus] == ReachableViaWiFi) {
        NSLog(@"baseview  net changes.");
        //do some refresh
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

