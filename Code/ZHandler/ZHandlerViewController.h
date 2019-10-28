//
//  ZHandlerViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2019/10/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import <ZCollection/ZCollection.h>
@import CoreLocation;

NS_ASSUME_NONNULL_BEGIN

@interface ZHandlerViewController : ZCollectionNoLoadingViewController

+ (instancetype)createHandlerWithLocation:(CLLocation *)location andAddress:(NSString *)address;

@end

NS_ASSUME_NONNULL_END
