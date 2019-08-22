//
//  ZAddressBean.swift
//  DStoreDemo
//
//  Created by three stone 王 on 2019/7/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources

@objc (ZAddressBean)
public class ZAddressBean: NSObject,Mappable,IdentifiableType {
    public var identity: String = ""
    
    public typealias Identity = String
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        
        id <- map["id"]
        
        identity <- map["encoded"]
        
        encoded <- map["encoded"]
        
        intime <- map["intime"]
        
        isdel <- map["isdel"]
        
        phone <- map["phone"]
        
        plcl <- map["plcl"]
        
        plclne <- map["plclne"]
        
        city <- map["city"]
        
        cityne <- map["cityne"]
        
        region <- map["region"]
        
        name <- map["name"]
        
        addr <- map["addr"]
        
        cityne <- map["cityne"]
        
        regionne <- map["regionne"]
        
    }
    
    public var id: Int = 0
    
    public var intime: Int = Int.max
    
    public var isdel: Bool = false
    
    public var phone: String = ""
    
    public var plcl: Int = 0
    
    public var plclne: String = ""
    
    public var city: Int = 0
    
    public var cityne: String = ""
    
    public var region: Int = 0
    
    public var regionne: String = ""
    
    public var encoded: String = ""
    
    public var name: String = ""
    
    public var addr: String = ""
    
    public override init() { }
}
