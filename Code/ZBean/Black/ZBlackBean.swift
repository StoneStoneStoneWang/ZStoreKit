//
//  ZBlackBean.swift
//  HZTC
//
//  Created by three stone 王 on 2019/3/21.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources

@objc (ZBlackBean)
public class ZBlackBean: NSObject,Mappable,IdentifiableType {
    public var identity: String = ""
    
    public typealias Identity = String
    
    var intime: Int = Int.max
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        
        identity <- map["encoded"]
        
        encoded <- map["encoded"]
        
        intime <- map["intime"]
        
        users <- map["users"]
        
        tableName <- map["tableName"]
        
        oUsEncoded <- map["oUsEncoded"]
        
        targetEncoded <- map["targetEncoded"]
        
        usEncoded <- map["usEncoded"]
        
        content <- map["content"]
    }
    var users: ZUserBean!
    
    var tableName: String = ""
    
    var oUsEncoded: String = ""
    
    var targetEncoded: String = ""
    
    var usEncoded: String = ""
    
    var content: String = ""
    
    var encoded: String = ""
}
