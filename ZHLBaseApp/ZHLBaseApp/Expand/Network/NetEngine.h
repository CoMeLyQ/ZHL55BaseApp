
#import "MKNetworkEngine.h"
#import "SVProgressHUD.h"
#import "Foundation.h"
#import "NSString+expanded.h"
#import "UIView+expanded.h"
#import "NSDictionary+expanded.h"

typedef enum {
    NETypeHttpGet = 1,//return JSON   get
    NETypeDownFile, //return DATA     get
    NETypeHttpPost,//return JSON      post
    NETypeUploadFile, //return JSON   post
    NETypeSoap // return XML          post
}NEType;

@interface NetEngine : MKNetworkEngine
typedef void (^CurrencyResponseBlock)(id resData,BOOL isCache);

typedef void (^ResponseBlock)(id resData,BOOL isCache);


+(id)Share;
+(id)soapShare;
+(void)cancel;

+(MKNetworkOperation*) createSoapAction:(NSString*) msg
                           onCompletion:(ResponseBlock) completion;

+(MKNetworkOperation*) createSoapAction:(NSString*) msg
                           onCompletion:(ResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock
                               useCache:(BOOL)usecache
                                useMask:(SVProgressHUDMaskType)mask;

+(MKNetworkOperation*) createUploadFileAction:(NSString*) url
                                     withFile:(id)fileInfo
                                   withParams:(NSDictionary*)params
                                 onCompletion:(ResponseBlock) completionBlock;

+(MKNetworkOperation*) createGetActionAllURL:(NSString*) url
                                onCompletion:(ResponseBlock) completion;
+(MKNetworkOperation*) createGetAction:(NSString*) url
                          onCompletion:(ResponseBlock) completion;
+(MKNetworkOperation*) createGetAction_LJ:(NSString*) url
                             onCompletion:(ResponseBlock) completion;
+(MKNetworkOperation*) createGetAction_LJ_two:(NSString*) url
                                 onCompletion:(ResponseBlock) completion
                                      onError:(MKNKErrorBlock) errorBlock;

////固定域名（用于登录、找回密码）
+(MKNetworkOperation*) createHttpActionFixed:(NSString*) url
                                   withCache:(BOOL)usecache
                                  withParams:(NSDictionary*)params
                                    withMask:(SVProgressHUDMaskType)mask
                                onCompletion:(ResponseBlock) completionBlock
                                     onError:(MKNKErrorBlock) errorBlock;


+(MKNetworkOperation*) createPostAction:(NSString*) url
                             withParams:(NSDictionary*)params
                           onCompletion:(ResponseBlock) completion
                                onError:(MKNKErrorBlock) errorBlock;
+(MKNetworkOperation*) createPostAction:(NSString*) url
                             withParams:(NSDictionary*)params
                           onCompletion:(ResponseBlock) completion;

+(MKNetworkOperation*) createHttpAction:(NSString*) url
                              withCache:(BOOL)usecache
                             withParams:(NSDictionary*)params
                               withMask:(SVProgressHUDMaskType)mask
                           onCompletion:(ResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock;





+ (MKNetworkOperation*)imageAtURL:(NSString *)url size:(CGSize) size onCompletion:(MKNKImageBlock) imageFetchedBlock errorHandler:(MKNKResponseErrorBlock) errorBlock;
+ (MKNetworkOperation*)imageAtURL:(NSString *)url onCompletion:(MKNKImageBlock) imageFetchedBlock;
+ (MKNetworkOperation*)imageAtURL:(NSString *)url onCompletion:(MKNKImageBlock) imageFetchedBlock errorHandler:(MKNKResponseErrorBlock) errorBlock;

///下载文件
+(MKNetworkOperation*) createFileAction:(NSString*) url
                           onCompletion:(CurrencyResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock
                               withMask:(SVProgressHUDMaskType)mask;



/**
 @method
 @abstract 网络请求总方法
 @discussion 包括GET POST SOAP DownFile UploadFile
 @param netype 网络请求类型  urlInfo 链接后缀 params {key:value...} fileinfo {uploadkey:data}  usecache 缓存标示
 @result JSon
 */
-(MKNetworkOperation*)createAction:(NEType)netype
                           withUrl:(NSString*)urlInfo
                        withParams:(NSDictionary*)params
                          withFile:(NSArray*)filePaths
                         withCache:(BOOL)usecache
                          withMask:(SVProgressHUDMaskType)mask
                      onCompletion:(ResponseBlock)completionBlock
                           onError:(MKNKErrorBlock)errorBlock;



#pragma mark - uplaodFileAction
//多张图片/文件（图片、语音、视频等等）
/**
 *上传文件 多个文件
 (NSMutableArray *) fileArray
 
 (nsstirng *)fileType-----文件类型（image:图片，other:其他）必传字段
 
 //fileType==image
 
 (NSData*) fileData
 (NSString *)fileKey
 (NSString *)fileName
 
 //fileType==...
 
 (NSString *)fileUrl
 (NSString *)fileKey
 
 */
+(MKNetworkOperation*) uploadAllFileAction:(NSString*) url
                                withParams:(NSDictionary*)params
                                 fileArray:(NSMutableArray *)fileArray
                              onCompletion:(CurrencyResponseBlock)completionBlock
                                   onError:(MKNKErrorBlock)errorBlock
                                  withMask:(SVProgressHUDMaskType)mask;





@end
