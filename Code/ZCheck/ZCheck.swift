//
//  ZCheck.swift
//  ZCheck
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseResult
import WLToolsKit

public func checkUsernameAndPassword(_ username: String ,password: String) -> WLBaseResult {
    
    if username.isEmpty || username.wl_isEmpty {
        
        return WLBaseResult.failed("请输入手机号")
    }
    
    if !String.validPhone(phone: username) {
        return WLBaseResult.failed("请输入11位手机号")
    }
    
    if password.isEmpty || password.wl_isEmpty {
        
        return WLBaseResult.failed("请输入6-18密码")
    }
    
    if password.length < 6 {
        
        return WLBaseResult.failed("请输入6-18密码")
    }
    
    return WLBaseResult.ok("验证成功")
}
