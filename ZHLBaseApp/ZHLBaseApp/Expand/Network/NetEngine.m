
//

#import "NetEngine.h"
#import "Foundation.h"
#import "Utility.h"
#import "SDDataCache.h"
#import "NSString+QTool.h"
#import <SVProgressHUD.h>
#import "Foundation_defines.h"
#import <DDXML.h>
@implementation NetEngine


+(id)ShareFixed
{
    static NetEngine *_NetEngineinstance=nil;
    static dispatch_once_t netEngine;
    dispatch_once(&netEngine, ^ {
        _NetEngineinstance = [[NetEngine alloc] initWithHostName:baseDomainFixed apiPath:basePathFixed customHeaderFields:nil];
        _NetEngineinstance.portNumber=[basePortFixed intValue];
        [_NetEngineinstance useCache];
    });
    return _NetEngineinstance;
}
+(id)Share
{
    static NetEngine *_NetEngineinstance=nil;
    static dispatch_once_t netEngine;
    dispatch_once(&netEngine, ^ {
        _NetEngineinstance = [[NetEngine alloc] initWithHostName:baseDomain apiPath:basePath customHeaderFields:nil];
        _NetEngineinstance.portNumber=[basePort intValue];
        [_NetEngineinstance useCache];
    });
    if (![_NetEngineinstance.readonlyHostName isEqualToString:baseDomain] || ![_NetEngineinstance.apiPath isEqualToString:basePath] ) {
        _NetEngineinstance = [[NetEngine alloc] initWithHostName:baseDomain apiPath:basePath customHeaderFields:nil];
        _NetEngineinstance.portNumber=[basePort intValue];
        [_NetEngineinstance useCache];
    }
    
    return _NetEngineinstance;
}
+(id)soapShare
{
    static NetEngine *_soapinstance=nil;
    static dispatch_once_t twice;
    dispatch_once(&twice, ^ {
        _soapinstance = [[NetEngine alloc] initWithHostName:soapDomain apiPath:soapPath customHeaderFields:nil];
        _soapinstance.portNumber=[soapPort intValue];
        [_soapinstance useCache];
    });
    if (![_soapinstance.readonlyHostName isEqualToString:soapDomain]) {
        _soapinstance = [[NetEngine alloc] initWithHostName:soapDomain apiPath:soapPath customHeaderFields:nil];
        _soapinstance.portNumber=[soapPort intValue];
        [_soapinstance useCache];
    }
    return _soapinstance;
}
+(void)cancel
{
    [SVProgressHUD dismiss];
    //[[NetEngine Share] cancelAllOperations];
}

- (void)cancelAllOperations
{
    //[super performSelector:@selector(cancelAllOperations)];
}
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
                           onError:(MKNKErrorBlock)errorBlock{
    
    DLog(@"\n__________\n%@:\n%@\n___________\n",(netype==NETypeDownFile||netype==NETypeHttpGet)?@"GET":@"POST",urlInfo);
    NSString *storeKey=[urlInfo md5];
    if (usecache&&storeKey) {
        id storedata=[[SDDataCache sharedDataCache] dataFromKey:storeKey fromDisk:YES];
        NSString *datastring=[[NSString alloc] initWithData:storedata encoding:NSUTF8StringEncoding];
        completionBlock([datastring objectFromJSONString],YES);
    }
    //    if ([[Utility Share] offline]) {
    //        if (errorBlock) {
    //            errorBlock(nil);
    //        }else{
    //            if(mask)[SVProgressHUD showErrorWithStatus:@"您已经处于离线"];
    //        }
    //        return nil;
    //    }else{//SVProgressHUDMaskTypeNone
    if(mask!=SVProgressHUDMaskTypeNil){[SVProgressHUD showWithMaskType:mask];}
    MKNetworkOperation *op = nil;
    //这里实现get方法下载文件，断点续传
    if (netype==NETypeDownFile&&[urlInfo rangeOfString:@"http://"].location==0) {
        // 获得临时文件的路径
        NSString *tempFilePath = [docDataPath stringByAppendingPathComponent:urlInfo.lastPathComponent];
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSMutableDictionary *newHeadersDict = [[NSMutableDictionary alloc] init];
        NSString *userAgentString = [NSString stringWithFormat:@"%@/%@",
                                     [[[NSBundle mainBundle] infoDictionary]
                                      objectForKey:(NSString *)kCFBundleNameKey],
                                     [[[NSBundle mainBundle] infoDictionary]
                                      objectForKey:(NSString *)kCFBundleVersionKey]];
        [newHeadersDict setObject:userAgentString forKey:@"User-Agent"];
        
        // 判断之前是否下载过 如果有下载重新构造Header
        if ([fileManager fileExistsAtPath:tempFilePath]) {
            NSError *error = nil;
            unsigned long long fileSize = [[fileManager attributesOfItemAtPath:tempFilePath
                                                                         error:&error]
                                           fileSize];
            if (error) {
                NSLog(@"get %@ fileSize failed!\nError:%@", tempFilePath, error);
            }
            NSString *headerRange = [NSString stringWithFormat:@"bytes=%llu-", fileSize];
            [newHeadersDict setObject:headerRange forKey:@"Range"];
        }
        
        op = [self operationWithURLString:urlInfo params:params httpMethod:@"GET"];
        [op addDownloadStream:[NSOutputStream outputStreamToFileAtPath:tempFilePath append:YES]];
        [op addHeaders:newHeadersDict];
        
    }else if(netype != NETypeSoap){
        if ([urlInfo hasPrefix:@"http"]) {
            op = [self operationWithURLString:[urlInfo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] params:params httpMethod:(netype==NETypeDownFile||netype==NETypeHttpGet)?@"GET":@"POST"];
        }else{
            op = [self operationWithPath:urlInfo params:params httpMethod:(netype==NETypeDownFile||netype==NETypeHttpGet)?@"GET":@"POST" ssl:baseUseSSL];
        }
        
        if(netype == NETypeUploadFile){
            for (NSString *path in filePaths) {
                [op addFile:path forKey:@"photo"];//file
            }
        }
    }else if (netype == NETypeSoap) {
        op = [self operationWithPath:@"" params:nil httpMethod:@"POST" ssl:baseUseSSL];
        [op setCustomPostDataEncodingHandler:^NSString *(NSDictionary *postDataDict) {return urlInfo;}forType:@"text/xml"];
    }
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        
        if(completedOperation.isCachedResponse)
            return;
        if(mask!=SVProgressHUDMaskTypeNil)[SVProgressHUD dismiss];
        if (netype == NETypeDownFile) {
            completionBlock(completedOperation.responseData,completedOperation.isCachedResponse);
        }else if (netype == NETypeSoap){
            NSString *responseString=completedOperation.responseString;
            if([completedOperation isCachedResponse]) {
                DLog(@"Data from cache");
            }
            else {
                DLog(@"Data from server:%@",responseString);
            }
            DDXMLDocument *doc = [[DDXMLDocument alloc] initWithXMLString:responseString options:0 error:nil];
            /////解析
            NSString *jsonString=nil;
            NSArray *items = [doc nodesForXPath:@"//soap:Body" error:nil];
            for (DDXMLElement *obj in items) {//循环查询的每条记录
                for(DDXMLNode *node in obj.children){//取得每个字段的值
                    for (DDXMLNode *item in node.children) {
                        jsonString=item.stringValue;
                        break;
                    }
                }
            }
            if (!doc || !items) {
                //[SVProgressHUD dismissWithError:@"数据有误"];
                errorBlock?errorBlock(nil):nil;
            }else{
                DLog(@"%@",[jsonString objectFromJSONString]);
                if(mask!=SVProgressHUDMaskTypeNil)[SVProgressHUD dismiss];
                completionBlock([jsonString objectFromJSONString],NO);
                if (usecache && storeKey) {
                    if (!jsonString){
                        [[SDDataCache sharedDataCache] removeDataForKey:storeKey];
                    }else{
                        [[SDDataCache sharedDataCache] storeData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] forKey:storeKey toDisk:YES];
                    }
                }
            }
        }else{
            NSString *responseString=completedOperation.responseString;
#ifdef DEBUG
            NSMutableString*logstr=[NSMutableString new];
            [logstr appendFormat:@"\n\n\n\n\n\n\n返回数据：\n%@",responseString.tojsonDictionary.jsonStrSYS];
            [logstr appendFormat:@"\n\n请求地址：   \nhttp://%@/%@/%@%@",baseDomain,basePath,urlInfo,[params wgetParamStr]];
            NSLog(@"%@",logstr);
#else
            //do sth.
#endif
            NSDictionary *ddd=[responseString objectFromJSONString];
            if ([[ddd valueForJSONKey:@"status"] isEqualToString:@"502"]) {
                [[Utility Share] clearUserInfoInDefault];
                [SVProgressHUD showImage:nil status:[ddd valueForJSONKey:@"info"] ];
                [self performSelector:@selector(backLogin) withObject:nil afterDelay:1.0];
                //                    completionBlock(nil,completedOperation.isCachedResponse);
            }else{
                
                //数据为空，清除缓存KEY
                if (!responseString.length) {
                    if(storeKey)[[SDDataCache sharedDataCache] removeDataForKey:storeKey];
                    errorBlock?errorBlock(nil):nil;
                }else{
                    completionBlock([responseString objectFromJSONString],completedOperation.isCachedResponse);
                    if (usecache && storeKey) {
                        [[SDDataCache sharedDataCache] storeData:[responseString dataUsingEncoding:NSUTF8StringEncoding] forKey:storeKey toDisk:YES];
                    }
                }
            }
            
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        DLog(@"\n__________\nerror:%@:\nurlinfo:%@\n___________\n",error,urlInfo);
        if(mask!=SVProgressHUDMaskTypeNil)[SVProgressHUD dismiss];
        if (errorBlock) {
            errorBlock(error);
        }else{
            if(mask && mask!=SVProgressHUDMaskTypeNil)[SVProgressHUD showErrorWithStatus:alertErrorTxt];//@"暂无数据"
        }
    }];
    [self enqueueOperation:op forceReload:!usecache];
    return op;
    //  }
}
#pragma  data - DataActions
/**
 @method
 @abstract soap 下载
 @discussion soap
 @param msg xml请求串
 @result xml的json字符串
 */
+(MKNetworkOperation*) createSoapAction:(NSString*) msg
                           onCompletion:(ResponseBlock) completion
{
    return [[NetEngine Share] createAction:NETypeSoap withUrl:msg withParams:nil withFile:nil withCache:YES withMask:SVProgressHUDMaskTypeClear onCompletion:completion onError:nil];
}

+(MKNetworkOperation*) createSoapAction:(NSString*) msg
                           onCompletion:(ResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock
                               useCache:(BOOL)usecache
                                useMask:(SVProgressHUDMaskType)mask
{
    return [[NetEngine Share] createAction:NETypeSoap withUrl:msg withParams:nil withFile:nil withCache:usecache withMask:mask onCompletion:completionBlock onError:errorBlock];
}
/**
 @method
 @abstract 上传文件和post参数
 @discussion
 @param fileInfo 文件信息 @{@"data":@"key"}
 @result json字符串
 */
+(MKNetworkOperation*) createUploadFileAction:(NSString*) url
                                     withFile:(id)filePaths
                                   withParams:(NSDictionary*)params
                                 onCompletion:(ResponseBlock) completionBlock{
    return [[NetEngine Share] createAction:NETypeUploadFile withUrl:url withParams:nil withFile:filePaths withCache:NO withMask:SVProgressHUDMaskTypeClear onCompletion:completionBlock onError:nil];
}

/**
 @method
 @abstract 下载文件和获取get返回值
 @discussion
 @param url 全路径包含http
 @result json字符串
 */
+(MKNetworkOperation*) createGetActionAllURL:(NSString*) url
                                onCompletion:(ResponseBlock) completion
{
    return [[NetEngine Share] createGetActionAllURL:url onCompletion:completion onError:nil withMask:SVProgressHUDMaskTypeClear];
}

-(MKNetworkOperation*) createGetActionAllURL:(NSString*) url
                                onCompletion:(CurrencyResponseBlock) completionBlock
                                     onError:(MKNKErrorBlock) errorBlock
                                    withMask:(SVProgressHUDMaskType)mask
{
    DLog(@"%@",url);
    
    if ([[Utility Share] offline]) {
        [SVProgressHUD dismiss];
        errorBlock?errorBlock(nil):nil;
        return nil;
    }
    if(mask!=SVProgressHUDMaskTypeNone)
        [SVProgressHUD showWithStatus:@"请稍候..." maskType:mask];//showWithMaskType:mask
    
    MKNetworkOperation *op = [self operationWithURLString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if(completedOperation.isCachedResponse){
            return;
        }
        [SVProgressHUD dismiss];
        
        NSString *responseString=completedOperation.responseString;
        NSDictionary *ddd=[responseString objectFromJSONString];
        if (!ddd) {
            [SVProgressHUD showErrorWithStatus:@"Data Error"];
            errorBlock?errorBlock(nil):nil;
        }else{
            if(mask!=SVProgressHUDMaskTypeNone)
                [SVProgressHUD dismiss];
            completionBlock(ddd,NO);
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"网络超时"];
        DLog(@"errorHandler网络超时:%@",url);
        errorBlock?errorBlock(nil):nil;
    }];
    
    [self enqueueOperation:op forceReload:YES];
    return op;
}
/**
 @method
 @abstract 下载文件和获取get返回值
 @discussion
 @param url 包含url?param=1&param=2
 @result json字符串
 */
+(MKNetworkOperation*) createGetAction:(NSString*) url
                          onCompletion:(ResponseBlock) completion
{
    return [[NetEngine Share] createAction:NETypeHttpGet withUrl:url withParams:nil withFile:nil withCache:NO withMask:SVProgressHUDMaskTypeClear onCompletion:completion onError:nil];
}

+(MKNetworkOperation*) createGetAction_LJ:(NSString*) url
                             onCompletion:(ResponseBlock) completion
{
    return [[NetEngine Share] createAction:NETypeHttpGet withUrl:url withParams:nil withFile:nil withCache:NO withMask:SVProgressHUDMaskTypeNil onCompletion:completion onError:nil];
}

+(MKNetworkOperation*) createGetAction_LJ_two:(NSString*) url
                                 onCompletion:(ResponseBlock) completion
                                      onError:(MKNKErrorBlock) errorBlock
{
    return [[NetEngine Share] createAction:NETypeHttpGet withUrl:url withParams:nil withFile:nil withCache:NO withMask:SVProgressHUDMaskTypeNil onCompletion:completion onError:errorBlock];
}



+(MKNetworkOperation*) createPostAction:(NSString*) url
                             withParams:(NSDictionary*)params
                           onCompletion:(ResponseBlock) completion
                                onError:(MKNKErrorBlock) errorBlock{
    return [[NetEngine Share] createAction:NETypeHttpPost withUrl:url withParams:params withFile:nil withCache:NO withMask:SVProgressHUDMaskTypeClear onCompletion:completion onError:errorBlock];
}
/**
 @method
 @abstract 获取post返回值
 @discussion
 @param url 请求链接  params post参数
 @result json字符串
 */
+(MKNetworkOperation*) createPostAction:(NSString*) url
                             withParams:(NSDictionary*)params
                           onCompletion:(ResponseBlock) completion{
    return [[NetEngine Share] createAction:NETypeHttpPost withUrl:url withParams:params withFile:nil withCache:NO withMask:SVProgressHUDMaskTypeClear onCompletion:completion onError:nil];
}

////固定域名（用于登录、找回密码）
+(MKNetworkOperation*) createHttpActionFixed:(NSString*) url
                                   withCache:(BOOL)usecache
                                  withParams:(NSDictionary*)params
                                    withMask:(SVProgressHUDMaskType)mask
                                onCompletion:(ResponseBlock) completionBlock
                                     onError:(MKNKErrorBlock) errorBlock{
    return [[NetEngine ShareFixed] createAction:params?NETypeHttpPost:NETypeDownFile withUrl:url withParams:params withFile:nil withCache:usecache withMask:mask onCompletion:completionBlock onError:errorBlock];
}
/**
 @method
 @abstract 带缓存、下载提示控制的 get和post请求
 @discussion
 @param url 包含url?param=1&param=2的get请求 或 含params的post请求
 @result json字符串
 */
+(MKNetworkOperation*) createHttpAction:(NSString*) url
                              withCache:(BOOL)usecache
                             withParams:(NSDictionary*)params
                               withMask:(SVProgressHUDMaskType)mask
                           onCompletion:(ResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock{
    return [[NetEngine Share] createAction:params?NETypeHttpPost:NETypeDownFile withUrl:url withParams:params withFile:nil withCache:usecache withMask:mask onCompletion:completionBlock onError:errorBlock];
}


#pragma  mark - ImageAction
+ (MKNetworkOperation*)imageAtURL:(NSString *)url size:(CGSize) size onCompletion:(MKNKImageBlock) imageFetchedBlock errorHandler:(MKNKResponseErrorBlock)errorBlock
{
    if (url) {
        //[NSURL URLWithString:@"http://www.baidu.com/img/baidu_sylogo1.gif"]
        //[NSString stringWithFormat:@"http://%@/%@",basePicPath,url]
        NSString *picPath =[url hasPrefix:@"http"]?url:[NSString stringWithFormat:@"http://%@%@",basePicPath,url];
        return [[NetEngine Share] imageAtURL:[NSURL URLWithString:picPath] size:size completionHandler:imageFetchedBlock errorHandler:errorBlock];// [[NetEngine Share] imageAtURL:[NSURL URLWithString:picPath] size:size onCompletion:imageFetchedBlock];
    }
    return nil;
}

+ (MKNetworkOperation*)imageAtURL:(NSString *)url onCompletion:(MKNKImageBlock) imageFetchedBlock
{
    if (url) {
        //[NSURL URLWithString:@"http://www.baidu.com/img/baidu_sylogo1.gif"]
        //[NSString stringWithFormat:@"http://%@/%@",basePicPath,url]
        //        if ([url rangeOfString:@"http://"].length) {
        //
        //        }else{
        //            url = [NSString stringWithFormat:@"http://%@%@",basePicPath,url];
        //        }
        NSString *picPath =[url hasPrefix:@"http"]?url:[NSString stringWithFormat:@"http://%@%@",basePicPath,url];
        //        DLog(@"imageurl:%@",picPath);
        
        return [[NetEngine Share] imageAtURL:[NSURL URLWithString:picPath] onCompletion:imageFetchedBlock];
    }
    return nil;
}

+ (MKNetworkOperation*)imageAtURL:(NSString *)url onCompletion:(MKNKImageBlock) imageFetchedBlock errorHandler:(MKNKResponseErrorBlock) errorBlock
{
    if (url) {
        NSString *picPath =[url hasPrefix:@"http"]?url:[NSString stringWithFormat:@"http://%@%@",basePicPath,url];
        return [[NetEngine Share] imageAtURL:[NSURL URLWithString:picPath] completionHandler:imageFetchedBlock errorHandler:errorBlock];
    }
    return nil;
}


#pragma mark - fileAction
+(MKNetworkOperation*) createFileAction:(NSString*) url
                           onCompletion:(CurrencyResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock
                               withMask:(SVProgressHUDMaskType)mask
{
    return [[NetEngine soapShare] createFileAction:url onCompletion:completionBlock onError:errorBlock withMask:mask];
}
-(MKNetworkOperation*) createFileAction:(NSString*) url
                           onCompletion:(CurrencyResponseBlock) completionBlock
                                onError:(MKNKErrorBlock) errorBlock
                               withMask:(SVProgressHUDMaskType)mask
{
    DLog(@"file:%@",url);
    
    if ([[Utility Share] offline]) {
        [SVProgressHUD dismiss];
        errorBlock?errorBlock(nil):nil;
        return nil;
    }
    if(mask!=SVProgressHUDMaskTypeNone)
        [SVProgressHUD showWithStatus:@"数据初始化,请稍候..." maskType:mask];//showWithMaskType:mask
    
    MKNetworkOperation *op = [self operationWithPath:url params:nil httpMethod:@"GET" ssl:baseUseSSL];
    //[op setCustomPostDataEncodingHandler:^NSString *(NSDictionary *postDataDict) {return msg;}forType:@"text/xml"];
    
    //    [op.request setTimeoutInterval:[[Utility Share] ACDate]];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        //[[Utility Share] setACDate:30];
        
        NSData *responseData=[completedOperation responseData];
        DLog(@"%@",completedOperation.readonlyResponse.allHeaderFields);
        if (!responseData) {
            [SVProgressHUD showErrorWithStatus:@"Data Error"];
            errorBlock?errorBlock(nil):nil;
        }else{
            if(mask!=SVProgressHUDMaskTypeNone)
                [SVProgressHUD dismiss];
            completionBlock(responseData,NO);
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        //  [[Utility Share] setACDate:30];
        
        [SVProgressHUD showErrorWithStatus:@"网络超时"];
        DLog(@"errorHandler网络超时:%@",url);
        errorBlock?errorBlock(nil):nil;
    }];
    
    [self enqueueOperation:op forceReload:YES];
    return op;
}


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
                                  withMask:(SVProgressHUDMaskType)mask{
    return [[NetEngine Share]uploadAllFileAction:url withParams:params fileArray:fileArray onCompletion:completionBlock onError:errorBlock withMask:mask];
}

-(MKNetworkOperation*) uploadAllFileAction:(NSString*) url
                                withParams:(NSDictionary*)params
                                 fileArray:(NSMutableArray *)fileArray
                              onCompletion:(CurrencyResponseBlock)completionBlock
                                   onError:(MKNKErrorBlock)errorBlock
                                  withMask:(SVProgressHUDMaskType)mask{
    if ([[Utility Share] offline]) {
        [SVProgressHUD dismiss];
        errorBlock?errorBlock(nil):nil;
        return nil;
    }
    if(mask!=SVProgressHUDMaskTypeNone){
        [SVProgressHUD showWithMaskType:mask];
    }
    MKNetworkOperation *op = [self operationWithPath:url params:params httpMethod:@"POST" ssl:baseUseSSL];
    
    for (NSDictionary *dd in fileArray) {
        if ([[dd valueForJSONStrKey:@"fileType"] isEqualToString:@"image"]) {
            [op addData:[dd objectForKey:@"fileData"] forKey:[dd valueForJSONStrKey:@"fileKey"] mimeType:@"image/jpeg" fileName:[dd valueForJSONStrKey:@"fileName"]];
        }else{
            [op addFile:[dd objectForKey:@"fileUrl"] forKey:[dd valueForJSONStrKey:@"fileKey"]];
        }
    }
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        ///////////// 修改
        NSString *responseData=[completedOperation responseString];
        DLog(@"responseData:%@",responseData);
        if (!responseData) {
            //   [SVProgressHUD dismissWithError:@"数据有误"];
            errorBlock?errorBlock(nil):nil;
        }else{
            if(mask!=SVProgressHUDMaskTypeNone){
                [SVProgressHUD dismiss];
            }
            //
            NSDictionary *ddd=[responseData objectFromJSONString];
            if ([[ddd valueForJSONKey:@"status"] isEqualToString:@"502"]) {
                [[Utility Share] clearUserInfoInDefault];
                [SVProgressHUD showImage:nil status:[ddd valueForJSONKey:@"msg"] ];
                [self performSelector:@selector(backLogin) withObject:nil afterDelay:1.0];
                //                completionBlock(nil,completedOperation.isCachedResponse);
            }else{
                completionBlock([responseData objectFromJSONString],NO);
            }
            
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络超时"];
        DLog(@"errorHandler网络超时:%@",error);
        errorBlock?errorBlock(nil):nil;
    }];
    
    [self enqueueOperation:op forceReload:YES];
    return op;
    
}



#pragma mark zkSeletor

-(void)backLogin{
    [[Utility Share] clearUserInfoInDefault];
    [[Utility Share] showLoginAlert:YES];
    
}


//-(NSString*) cacheDirectoryName {
//
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = paths[0];
//    NSString *cacheDirectoryName = [documentsDirectory stringByAppendingPathComponent:@"cscImages"];
//    return cacheDirectoryName;
//}
@end
