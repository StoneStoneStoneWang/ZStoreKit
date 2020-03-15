//
//  ZEnrollViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2020/3/11.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLReqKit
import WLBaseResult
import ZBean
import ZRealReq
import ZApi
import WLToolsKit

fileprivate let cTag: String = "活动报名"

@objc (ZEnrollType)
public enum ZEnrollType: Int {
    
    case character
    
    case team
}

extension ZEnrollType {
    
    var title: String {
        
        switch self {
        case .character: return "角色"
            
        case .team: return "团队"
            
        default: return ""
            
        }
    }
    
    var placeholder: String {
        
        switch self {
        case .character: return "请选择角色"
            
        case .team: return "请选择报名团队"
            
        default: return ""
            
        }
    }
    
    var cellHeight: CGFloat {
        
        switch self {
            
        default: return 55
            
        }
    }
}
@objc public final class ZEnrollBean: NSObject {
    
    @objc public var type: ZEnrollType = .character
    
    @objc public var subtitle: String = ""
    
    @objc public var title: String {
        
        return type.title;
    }
    
    @objc public var placeholder: String {
        
        return type.placeholder;
    }
    
    static var types: [ZEnrollBean] {
        
        let character = ZEnrollBean()
        
        character.type = .character
        
        let team = ZEnrollBean()
        
        team.type = .team
        
        return [character ,team ]
    }
}
struct ZEnrollViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<ZEnrollBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let enrollItemTapped: Signal<Void>
        
        let charater: Driver<ZCircleBean?>
        
        let team: Driver<String>
        
        let tag: String
    }
    
    struct WLOutput {
        
        let zip: Observable<(ZEnrollBean,IndexPath)>
        
        let tableData: BehaviorRelay<[ZEnrollBean]> = BehaviorRelay<[ZEnrollBean]>(value: ZEnrollBean.types)
        
        let enrolling: Driver<Void>
        
        let enrolled: Driver<WLBaseResult>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let enrolling: Driver<Void> = input.enrollItemTapped.flatMap { Driver.just($0) }
        
        let uap = Driver.combineLatest(input.charater,input.team)
        
        let enrolled: Driver<WLBaseResult> = input
            .enrollItemTapped
            .withLatestFrom(uap)
            .flatMapLatest {
                
                if $0.0 == nil {
                    
                    return Driver<WLBaseResult>.just(WLBaseResult.failed("请选择角色信息"))
                }
                
                if $0.1 == "" {
                    
                    return Driver<WLBaseResult>.just(WLBaseResult.failed("请选择报名团队"))
                }
                
                var result = $0.0!.contentMap
                
                let team = ZKeyValueBean(JSON: ["type":"txt","value":"team=\($0.1)"])!
                //
                result += [team]
                
                let content = WLJsonCast.cast(argu: result.toJSON())
                
                return onUserDictResp(ZUserApi.publish("\(cTag)-\(input.tag)", content: content))
                    .mapObject(type: ZCircleBean.self)
                    .map({ WLBaseResult.operation($0) })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
                
        }
        
        let output = WLOutput(zip: zip,enrolling: enrolling,enrolled: enrolled)
        
        self.output = output
    }
    
}
