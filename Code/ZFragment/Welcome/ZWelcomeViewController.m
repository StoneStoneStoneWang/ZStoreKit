//
//  ZWelcomeViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZWelcomeViewController.h"
@import ZSubBridge;
@interface ZWelcomeViewController ()

@property (nonatomic ,strong) UIButton *skipItem;

@property (nonatomic ,strong) UIPageControl *pageControl;

@end

@implementation ZWelcomeViewController

- (UIButton *)skipItem {
    
    if (!_skipItem) {
        
        _skipItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _skipItem.tag = 101;
        
    }
    return _skipItem;
}
- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        
        _pageControl.tag = 102;
        
    }
    return _pageControl;
}

- (void)addOwnSubViews {
    [super addOwnSubViews];
    
    [self.view addSubview:self.skipItem];
    
    [self.view addSubview:self.pageControl];
}
- (void)configOwnSubViews {
    
    
}
- (void)configViewModel {
    
    ZWelcomeBridge *bridge = [ZWelcomeBridge new];
    
    [bridge configViewModel:self welcomeImgs:@[@"",@""] isPageHidden:true];
}


@end
