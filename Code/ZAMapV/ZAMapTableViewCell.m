//
//  ZAMapTableViewCell.m
//  ZFragment
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

#import "ZAMapTableViewCell.h"
@import ZTextField;
@import Masonry;

@interface ZAMapTableViewCell () <UITextFieldDelegate>

@property (nonatomic ,strong) WLLeftTitleTextField *textField;

@end

@implementation ZAMapTableViewCell

- (WLLeftTitleTextField *)textField {
    
    if (!_textField) {
        
        _textField = [[WLLeftTitleTextField  alloc] initWithFrame:CGRectZero] ;
    }
    return _textField;
}
- (void)setKeyValue:(ZKeyValueBean *)keyValue {
//    _keyValue = keyValue;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.textField.userInteractionEnabled = true;
    
    [self.textField set_editType: WLTextFiledEditTypeDefault];
    
    [self.textField set_maxLength:999];
    
    self.textField.delegate = self;
    
    if ([keyValue.type containsString:@"时间"]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        self.textField.userInteractionEnabled = false;
        
    } else if ([keyValue.type containsString:@"手机号"]) {
        
        [self.textField set_editType: WLTextFiledEditTypePhone];
        
        [self.textField set_maxLength:11];
    }
    
    self.textField.leftTitle = keyValue.type;
    
    self.textField.placeholder = keyValue.place;
    
    self.textField.text = keyValue.value;
    
    UILabel *leftLabel = (UILabel *)self.textField.leftView;
    
    leftLabel.text = keyValue.type;
}

- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.textField];
    
    __weak typeof(self) weakSelf = self;
    
    [self.textField set_textChanged:^(WLBaseTextField * _Nonnull tf) {
        
        weakSelf.keyValue.value = tf.text;
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return true;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.bottom.equalTo(self);
    }];
}

@end
