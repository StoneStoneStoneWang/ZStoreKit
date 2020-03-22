//
//  ZOrderViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/12/23.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift

@objc public enum ZOrderHeaderType: Int {
    
    case unPay
    
    case unReceive
    
    case unEnvaluate
    
    case complete
}

@objc public class ZOrderHeaderBean: NSObject {
    
    @objc public var isSeleced: Bool = false
    
    @objc public var title: String = ""
    
    @objc public var type: ZOrderHeaderType = .unPay
    
    @objc public static func createOrderHeader(_ isSeleced: Bool ,_ title: String,_ type: ZOrderHeaderType) -> ZOrderHeaderBean {
        
        let header = ZOrderHeaderBean()
        
        header.isSeleced = isSeleced
        
        header.title = title
        
        header.type = type
        
        return header
    }
    
}
extension ZOrderHeaderBean {
    
    public static var types: [ZOrderHeaderBean] {
        
        let unPay = ZOrderHeaderBean.createOrderHeader(true, "待付款", .unPay)
        
        let unReceive = ZOrderHeaderBean.createOrderHeader(false, "待收货", .unReceive)
        
        let unEnvaluate = ZOrderHeaderBean.createOrderHeader(false, "待评价", .unEnvaluate)
        
        let complete = ZOrderHeaderBean.createOrderHeader(false, "已完成", .complete)
        
        return [unPay,unReceive,unEnvaluate,complete]
    }
}

struct ZOrderHeaderViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<ZOrderHeaderBean>
        
        let itemSelect: ControlEvent<IndexPath>
    }
    
    struct WLOutput {
        
        let tableData: BehaviorRelay<[ZOrderHeaderBean]> = BehaviorRelay<[ZOrderHeaderBean]>(value: ZOrderHeaderBean.types)
        
        let zip: Observable<(ZOrderHeaderBean,IndexPath)>
    }
    
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let output = WLOutput(zip: zip)
        
        self.output = output
        
    }
}
