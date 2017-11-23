

#import <Foundation/Foundation.h>
#import <SVProgressHUD.h>//
#import "CustomTabBar.h"
//#import <AVFoundation/AVFoundation.h>
#import "KNPhotoBrower.h"

#define default_userpwd @"default_userpwd"
#define default_userAccount @"default_userAccount"
#define default_userlongitude @"default_userlongitude"
#define default_userlatitude @"default_userlatitude"
#define default_userAppSetServer @"default_userAppSetServer"
#define default_userID @"default_userID"
#define default_userToken @"default_userToken"

#define default_setDefaultStartVibrate @"default_setDefaultStartVibrate"
#define default_setDefaultplaySystemSound @"default_setDefaultplaySystemSound"

#define default_APPStartPageAD @"default_APPStartPageAD"




typedef void (^CleakImage)();

#define UTILITY [Utility ShareUility]


@class BaseViewController;

//#import "AlixLibService.h"//支付宝

//1成功 0失败 2未知错误（验证登录是否过期）
typedef void (^validationLoginSuc)(NSInteger NoLogin);
//1成功 0失败 2未知错误
typedef void (^LoginSuc)(NSInteger NoLogin);
//1成功 0失败 2未知错误
typedef void (^ShareActionSuc)(NSInteger NoSuc);

//1成功 0失败 2未知错误
typedef void (^AlipaySuc)(int isPay);

typedef void (^LocationUserDataBlock)(BOOL isSuccess);//获取用户位置


@interface Utility : NSObject
//启用缓存
@property (nonatomic,assign) BOOL offline;

+(id)Share;
+(Utility*)ShareUility;
- (BOOL) validateEmail: (NSString *) candidate ;
- (BOOL) validateTel: (NSString *) candidate ;
- (BOOL) validateUrl: (NSString *) candidate ;
///验证字母
-(BOOL)validateLetter:(NSString *)str;
- (void) makeCall:(NSString *)phoneNumber;

///保存本地相关
+ (BOOL)removeForArrayObj:(id)obj forKey:(NSString*)key;
+ (void)saveToDefaults:(id)obj forKey:(NSString*)key;
+ (void)saveToArrayDefaults:(id)obj forKey:(NSString*)key;
+ (void)saveToArrayDefaults:(id)obj replace:(id)oldobj forKey:(NSString*)key;

+ (id)defaultsForKey:(NSString*)key;
+ (void)removeForKey:(NSString*)key;




///是否开启振动
@property (nonatomic, assign) BOOL isDefaultNOStartSystemShake;
@property (nonatomic, assign) BOOL isNOStartVibrate;
///是否开启声音
@property (nonatomic, assign) BOOL isDefaultNOplaySystemSound;
@property (nonatomic, assign) BOOL isNOplaySystemSound;

//用户相关
@property (nonatomic, strong) NSString *userAccount;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userPwd;
@property (nonatomic, strong) NSString *userToken;
@property (nonatomic, strong) NSDictionary *userData;

@property (nonatomic, strong) NSString *userlongitude;
@property (nonatomic, strong) NSString *userlatitude;

//////////作品标签
@property (nonatomic, strong) NSDictionary *userWorksCateData;




//
//////////////////////////////////Socket相关/////////////////////////////////////////
//@property(nonatomic,strong)SRWebSocket *srWebSocket;
//////发送消息计数
//@property (nonatomic, assign) NSInteger indexSocket;
//@property (nonatomic, strong) NSString *usercompany_id;
/////登录时间
//@property (nonatomic, strong) NSString *zkLoginDate;
/////修改密码时间
//@property (nonatomic, strong) NSString *zkUpdatePwdDate;
/////修改密码Type
//@property (nonatomic, strong) NSString *zkUpdatePwdType;
//



////版本更新相关
@property (nonatomic, strong) NSString *APPpackPath;
@property (nonatomic, strong) NSString *APPnewAppVersion;



///订单支付ID
@property (nonatomic, strong) NSString *userPayOrderId;

///是否登录
@property (nonatomic, assign) BOOL isUserLogin;
///是否是推送消息进入
@property (nonatomic, assign) BOOL isPushMessage;
///推送数据
@property (nonatomic, strong) NSDictionary * userPushData;


///配置信息
///服务器配置信息
@property (nonatomic, strong) NSDictionary *userAppSetServer;
///聊天IP
@property (nonatomic, strong) NSString *userAppIp;
///聊天端口
@property (nonatomic, strong) NSString *userAppsocketport;
///APP请求域名
@property (nonatomic, strong) NSString *userAppdomain;
///wap站域名
@property (nonatomic, strong) NSString *userAppwapdomain;
///总站域名
@property (nonatomic, strong) NSString *userPrimaryDomain;
///总站接口version
@property (nonatomic, strong) NSString *userInterfaceVersion;
///是否加密 https userAppUseSSL
@property (nonatomic, assign) BOOL userAppUseSSL;
///yes.可以发布   no.不能发布（用于控制APP所有发布、编辑按钮按钮显隐）
@property (nonatomic, assign) BOOL userAppcan_post;



@property (nonatomic, assign) BOOL boolAnimationHidden;




@property (nonatomic, strong) validationLoginSuc vloginSuc;
@property (nonatomic, strong) LoginSuc loginSuc;
@property (nonatomic, strong) LocationUserDataBlock loactionUserData;
@property (nonatomic, strong) AlipaySuc alipaySuc;


@property (nonatomic,strong)CustomTabBar *CustomTabBar_zk;





+(NSString *)Utuid;
+(NSString *)Uttoken;
-(void)isLogin:(validationLoginSuc)aLoginSuc;
-(void)ShowMessage:(NSString *)title msg:(NSString *)msg;
//-(void)isLoginAccount:(NSString *)account pwd:(NSString *)password code:(NSString *)chkcode aLogin:(LoginSuc)aLoginSuc;
-(void)loginWithAccount:(NSString *)account pwd:(NSString *)password code:(NSString *)chkcode;

//登陆注册
- (void)showLoginAlert:(BOOL)abool;
- (void)hiddenLoginAlert;
- (void)hiddenLoginAlert:(BOOL)abool;

//用户本地数据
-(void)saveUserInfoToDefault;
-(void)readUserInfoFromDefault;
-(void)clearUserInfoInDefault;


///改变时间格式yyyy-MM-dd HH:mm
- (NSString*)time_ChangeTheFormat:(NSString*)theDate;
///计算时间差
-(NSInteger)ACtimeToNow:(NSString*)theDate;
/////data-固定格式时间yyyy.MM.dd
-(NSString *)timeToFormatConversion:(NSString *)aDate;
//时间转换
- (NSString*)timeToNow:(NSString*)theDate needYear:(BOOL)needYear;
///时间戳yyyy-MM-dd HH:mm
-(NSString *)timeToTimestamp:(NSString *)timestamp;
- (NSString*)timeToNow_zk:(NSString*)theDate;//时间
///data-固定格式时间 录音使用
-(NSString *)timeToFormatAudio:(NSString *)aDate;




///判断是否为整形：
- (BOOL)isPureInt:(NSString*)string;
///判断是否为浮点形：
- (BOOL)isPureFloat:(NSString*)string;

//类似qq聊天窗口的抖动效果
-(void)viewAnimations:(UIView *)aV;

//view 左右抖动
-(void)leftRightAnimations:(UIView *)view;

///处理图片大小
-(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
//通过颜色来生成一个纯色图片
- (UIImage *)imageFromColor:(UIColor *)color rect:(CGSize )aSize;



//获取当前app版本
-(NSString *)VersionSelectString;
-(NSString *)VersionSelect;
//-(void)versionUpdate:(BOOL)abool;

//////////////数据格式化
//格式化电话号码
-(NSString *)ACFormatPhone:(NSString *)str;
//格式化手机号
-(NSString *)ACFormatMobile:(NSString *)str;
//格式化身份证号
-(NSString *)ACFormatIDC:(NSString *)str;
//格式化组织机构代码证
-(NSString *)ACFormatOCC:(NSString *)str;
//格式化车牌号
-(NSString *)ACFormatPlate:(NSString *)str;
//格式化vin
-(NSString *)ACFormatVin:(NSString *)str;
//------数字格式化----------------
-(NSString*)ACFormatNumStr:(NSString*)nf;
-(NSString *)ZKFromatNumStr:(NSString *)nf;


//格式化身份证号2
-(NSString *)ACFormatIDC_DH:(NSString *)str;
//格式化vin2
-(NSString *)ACFormatVin_DH:(NSString *)str;





////定位
-(void)loadUserLocation:(LocationUserDataBlock)isSuccess;

////////////////////////////////Socket相关/////////////////////////////////////////
//
//-(void)WebSocketConnectServer;
//-(void)WebSocketsend:(NSString *)strJson;
//-(void)websocketClose;
//- (void)WebSocketLogin;
//////忘记密码-（发送）
//-(void)WebSocketLoginAndSend:(NSDictionary *)dic;
/////检测连接
//-(void)webSocketDetection;

//z振动
-(void)StartSystemShake;
//播放提示音
-(void)playSystemSound;


///启动过渡图片
-(void)showStartTransitionView;
///是否停止倒计时
-(void)hiddenStartTransitionView:(BOOL)stopCountDown;
///引导页
-(void)showStartGuideTransitionView;




////用户权限获取
-(void)showAccessPermissionsAlertViewMessage:(NSString *)str;
///生成二维码
-(UIImage *)generatedCode:(NSString *)str withSize:(CGFloat )fw;


/*
 {
 "src": "/upload/tumour/1/1478856592.jpg",
 "title": "出现肿瘤别慌",
 "descr": "出现肿瘤别慌",
 "url": "http://www.jiusheng.com/wappage/news_detail?id=1"
 }
 
 */

/// Get IP Address  ipv4
- (NSString *)getIPAddress;
/// Get IP Address  ipv6
- (NSString *)getIPAddressIpv6;

/**
 *  写入本地相册
 */
- (void)saveImageLocalAlbum:(UIImage *)imageS;

#pragma mark - 框架相关

/**
 当前app正在显示的控制器
 */
@property(nonatomic,weak)BaseViewController*currentViewController;
//当前控制器的信息
@property(nonatomic,strong)NSMutableString*ControllerInfor;

//万能控制器
+ (UIViewController *)getCurrentVC;


//查看大图
//type 0 data为url数组
//type 1 data为image数组
//type 2 data为imageview数组
+(KNPhotoBrower *)showBigImage:(id)data clickIndex:(NSInteger)index viewContent:(BaseViewController *)base type:(NSString *)type;

//清除图片缓存
+(void)ClearTheCache:(CleakImage)block;

@end
