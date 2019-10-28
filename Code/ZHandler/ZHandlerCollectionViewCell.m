//
//  ZHandlerCollectionViewCell.m
//  ZFragment
//
//  Created by three stone 王 on 2019/10/23.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZHandlerCollectionViewCell.h"
@import ZTextField;
@import Masonry;

@interface ZHandlerCollectionViewCell() <UITextFieldDelegate>

@property (nonatomic ,strong) WLLeftTitleTextField *textField;

@end

@implementation ZHandlerCollectionViewCell

- (WLLeftTitleTextField *)textField {
    
    if (!_textField) {
        
        _textField = [[WLLeftTitleTextField  alloc] initWithFrame:CGRectZero] ;
    }
    return _textField;
}
- (void)setKeyValue:(ZKeyValueBean *)keyValue {
    _keyValue = keyValue;
    
    self.textField.userInteractionEnabled = true;
    
    [self.textField set_editType: WLTextFiledEditTypeDefault];
    
    [self.textField set_maxLength:999];
    
    self.textField.delegate = self;
    
    if ([keyValue.place containsString:@"选择"]) {
        
        self.textField.userInteractionEnabled = false;
    } else {
        
        if ([keyValue.type containsString:@"电话"]) {
            
            [self.textField set_editType: WLTextFiledEditTypePhone];
            
            [self.textField set_maxLength:11];
        }
    }
    
    self.textField.leftTitle = keyValue.type;
    
    self.textField.placeholder = keyValue.place;
    
    self.textField.text = keyValue.value;
    
    UILabel *leftLabel = (UILabel *)self.textField.leftView;
    
    leftLabel.text = keyValue.type;
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self commitInit];
        
    }
    return self;
}
- (void)commitInit {

    [self.contentView addSubview:self.textField];
    
    self.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    
    [self.textField set_textChanged:^(WLBaseTextField * _Nonnull tf) {
        
        weakSelf.keyValue.value = tf.text;
        
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.bottom.equalTo(self);
    }];
}
@end
