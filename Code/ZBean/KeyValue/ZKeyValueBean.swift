//
//  ZKeyValueBean.swift
//  WLUserKitDemo
//
//  Created by three stone 王 on 2019/4/30.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources

@objc (ZKeyValueBean)
public class ZKeyValueBean: NSObject,Mappable ,IdentifiableType {
    
    public var identity: String = NSUUID().uuidString
    
    public typealias Identity = String
    
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        
        type <- map["type"]
        
        value <- map["value"]
    }
    
    public override init() { }
    
    var type:String = ""
    
    var value: String = ""
    
    var img: UIImage?
}
