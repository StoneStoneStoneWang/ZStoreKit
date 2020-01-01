//
//  ZOrderViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/11/4.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZOrderViewController.h"
#include <stdlib.h>



@interface ZOrderViewController ()

@property (nonatomic ,strong) NSString *aTag;
@end

@implementation ZOrderViewController

+ (instancetype)createOrder:(NSString *)tag {
    
    return [[self alloc] initWithATag:tag];
}
- (instancetype)initWithATag:(NSString *)tag {
    
    if (self = [super init]) {
        
        self.aTag = tag;
    }
    return self;
}
- (void)configOwnProperties {
    
    self.view.backgroundColor = [UIColor colorWithRed: arc4random() % 255 / 255.0f green:arc4random() % 255 / 255.0f blue:arc4random() % 255 / 255.0f alpha:1];
}

@end
