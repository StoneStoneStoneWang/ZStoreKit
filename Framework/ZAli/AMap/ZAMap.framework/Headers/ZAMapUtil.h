//
//  WLMapUtil.h
//  WLThirdUtilDemo
//
//  Created by three stone 王 on 2019/5/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AMapFoundationKit;
NS_ASSUME_NONNULL_BEGIN

@interface ZAMapUtil : NSObject

+ (instancetype)shared;

- (void)registerApiKey:(NSString *)apiKey;

@end

NS_ASSUME_NONNULL_END
