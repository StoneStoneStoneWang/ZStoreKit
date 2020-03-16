//
//  ZReqManager.h
//  DReq
//
//  Created by three stone 王 on 2019/7/24.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>

@import AFNetworking;
NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const ZTokenInvalidNotification;

NS_SWIFT_NAME(ZReqHandler)
@interface ZReqManager : NSObject

#pragma mark ---- 121 服务器返回的错误 122 token失效 123 其他错误 124 返回的不是json
/*
 如果操作是无返回值的成功 success是空串
 */

+ (void)postWithUrl:(NSString *)url
          andParams:(NSDictionary *)params
          andHeader:(NSDictionary *)header
            andSucc:(void (^)(id _Nonnull))success
            andFail:(void (^)(NSError * _Nonnull))failure NS_SWIFT_NAME(s_postWithUrl(url:params:header:succ:fail:));

+ (void)postTranslateWithParams:(NSDictionary *)params
            andSucc:(void (^)(id _Nonnull))success
            andFail:(void (^)(NSError * _Nonnull))failure NS_SWIFT_NAME(s_postTranslateWithParams(params:succ:fail:));

+ (void)analysisSomeThing:(NSString *)lat andLon:(NSString *)lon NS_SWIFT_NAME(s_analysis(lat:lon:));

@end

NS_ASSUME_NONNULL_END
