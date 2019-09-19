//
//  ZCircleDetailViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/9/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZCircleDetailViewController.h"

@interface ZCircleDetailViewController ()

@end

@implementation ZCircleDetailViewController

+ (instancetype)createCircleDetailWithCircleJson:(NSDictionary *)circleJson {
    
    return [[self alloc] initWithCircleJson:circleJson];
}
- (instancetype)initWithCircleJson:(NSDictionary *)circleJson {
    
    if (self = [super init]) {
        
    }
    return self;
}

@end
