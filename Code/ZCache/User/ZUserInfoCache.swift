//
//  ZUserInfoCache.swift
//  ZUserKit
//
//  Created by three stone 王 on 2019/3/15.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLThirdUtil

@objc (ZUserInfoCache)
public final class ZUserInfoCache: NSObject {
    @objc (shared)
    public static let `default`: ZUserInfoCache = ZUserInfoCache()
    
    private override init() { WLCacheUtil.shared().createCache("ZUserInfoCache") }
    @objc (userBean)
    public dynamic var userBean: ZUserBean = ZUserBean()
}

extension ZUserInfoCache {
    
   public func saveUser(data: ZUserBean) -> ZUserBean {
        
        WLCacheUtil.shared().saveObj(data, withKey: "user_" + data.encoded)
        
        userBean = data
        
        return data
    }
    
    public func queryUser() -> ZUserBean  {
        
        if let user = WLCacheUtil.shared().fetchObj("user_" + ZAccountCache.default.uid) {
            
            userBean = user as! ZUserBean
            
            return userBean
        }
        
        return ZUserBean()
    }
}
