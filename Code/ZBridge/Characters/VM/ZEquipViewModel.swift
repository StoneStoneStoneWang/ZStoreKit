//
//  ZEquipViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2020/3/4.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLBaseResult

@objc public final class ZEquipBean: NSObject {
    
    @objc public var type: ZEquipType = .head
    
    @objc public var subtitle: String = ""
    
    @objc public var level: ZEquipLevel = .none
    
    @objc public var title: String {
        
        return type.title
    }
    
    @objc public var subTitle: String {
        
        return level.title
    }
    @objc public var placeholder: String {
        
        return type.errorInfo
    }
    
    
    static var types: [ZEquipBean] {
        
        let space = ZEquipBean()
        
        space.type = .space
        
        let head = ZEquipBean()
        
        head.type = .head
        
        let shoulder = ZEquipBean()
        
        shoulder.type = .shoulder
        
        let breastplate = ZEquipBean()
        
        breastplate.type = .breastplate
        
        let artifice = ZEquipBean()
        
        artifice.type = .artifice
        
        let hand = ZEquipBean()
        
        hand.type = .hand
        
        let waistband = ZEquipBean()
        
        waistband.type = .waistband
        
        let pants = ZEquipBean()
        
        pants.type = .pants
        
        let foot = ZEquipBean()
        
        foot.type = .foot
        
        return [space ,head ,shoulder ,breastplate ,artifice ,hand ,waistband,pants,foot]
    }
}


@objc (ZEquipLevel)
public enum ZEquipLevel: Int {
    
    case none
    
    case zero
    
    case one
    
    case two
}


extension ZEquipLevel {
    
    var title: String {
        
        switch self {
        case .zero: return "T0"
            
        case .one: return "T1"
            
        case .two: return "T2"
            
        default: return "请选择装备等级"
            
        }
    }
    
    init(_ temp: String) {
        
        switch temp {
        case "T0": self = .zero
        case "T1": self = .one
        case "T2": self = .two
        default: self = .none
            
        }
    }
}

@objc (ZEquipType)
public enum ZEquipType: Int {
    
    case head
    
    case shoulder
    
    case breastplate
    
    case artifice
    
    case hand
    
    case waistband
    
    case pants
    
    case foot
    
    case space
    
}


extension ZEquipType {
    
    static var types: [ZEquipType] {
        
        return [.space ,.head ,.shoulder ,.breastplate ,.artifice ,.hand ,.waistband ,.pants,.foot]
    }
    
    var title: String {
        
        switch self {
            
        case .head: return "头盔"
            
        case .shoulder: return "肩甲"
            
        case .breastplate: return "胸甲"
            
        case .artifice: return "护腕"
            
        case .hand: return "手部"
            
        case .waistband: return "腰带"
            
        case .pants: return "腿甲"
            
        case .foot: return "鞋"
            
        case .space: return ""
            
        }
    }
    
    init(_ temp: String) {
        
        switch temp {
        case "head":
            self = .head
        case "shoulder":
            self = .shoulder
        case "breastplate":
            self = .breastplate
        case "artifice":
            self = .artifice
        case "hand":
            self = .hand
        case "foot":
            self = .foot
        case "waistband":
            self = .waistband
        case "pants":
            self = .pants
            
        default:
            self = .space
        }
        
    }
    
    var errorInfo: String {
        
        switch self {
            
        case .head: return "请选择头盔装备等级"
            
        case .shoulder: return "请选择肩甲装备等级"
            
        case .breastplate: return "请选择胸甲装备等级"
            
        case .artifice: return "请选择护腕装备等级"
            
        case .hand: return "请选择手部装备等级"
            
        case .waistband: return "请选择腰带装备等级"
            
        case .pants: return "请选择腿甲装备等级"
            
        case .foot: return "请选择鞋装备等级"
            
        case .space: return ""
            
        }
    }
    
    var cellHeight: CGFloat {
        switch self {
        case .space: return 10
            
        default: return 55
            
        }
    }
    
}

public struct ZEquipViewModel: WLBaseViewModel {
    
    public var input: WLInput
    
    public var output: WLOutput
    
    public struct WLInput {
        
        let modelSelect: ControlEvent<ZEquipBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
    }
    public struct WLOutput {
        
        let zip: Observable<(ZEquipBean,IndexPath)>
        
        let tableData: BehaviorRelay<[ZEquipBean]> = BehaviorRelay<[ZEquipBean]>(value: ZEquipBean.types)
    }
    public init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let output = WLOutput(zip: zip)
        
        self.output = output
    }
}

