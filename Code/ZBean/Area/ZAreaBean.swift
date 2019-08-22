//
//  ZAreaBean.swift
//  DAddressDemo
//
//  Created by three stone 王 on 2019/7/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources

@objc (ZAreaBean)
public class ZAreaBean: NSObject,Mappable ,IdentifiableType {

    public var identity: String = NSUUID().uuidString
    
    public typealias Identity = String
    
    public var id: Int = 0
    
    public var aid: String = ""
    
    public var pid: Int = 0
    
    public var name: String = ""
    
    public var alif: String = ""
    
    public var areacode: String = ""
    
    public var arealevel: Int = 0
    
    public var typename: String = ""
    
    public var addrList: [ZAreaBean] = []
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        
        id <- map["id"]
        
        aid <- map["aid"]
        
        pid <- map["pid"]
        
        name <- map["name"]
        
        alif <- map["alif"]
        
        areacode <- map["areacode"]
        
        arealevel <- map["arealevel"]
        
        typename <- map["typename"]
        
        addrList <- map["addrList"]
    }
    
    public var isSelected: Bool = false
    
    public override init() { }
}
