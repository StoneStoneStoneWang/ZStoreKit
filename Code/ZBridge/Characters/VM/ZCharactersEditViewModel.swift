//
//  ZCharactersEditViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2020/3/5.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import WLBaseViewModel
import WLBaseResult
import ZBean
import WLToolsKit
import ZRealReq
import ZApi
import WLReqKit

@objc (ZCharactersEditType)
public enum ZCharactersEditType: Int {
    
    case character
    
    case name
    
    case equip
    
    case sex
    
    case space
}

extension ZCharactersEditType {
    
    static var types: [ZCharactersEditType] {
        
        return [.space ,.character ,.name ,.space ,.sex ,.equip ]
    }
    
    var title: String {
        
        switch self {
            
        case .character: return "角色"
            
        case .name: return "角色名称"
            
        case .sex: return "性别"
            
        case .equip: return "装备信息"
            
        case .space: return ""
            
        }
    }
    
    var placeholder: String {
        
        switch self {
            
        case .character: return "请选择角色信息"
            
        case .name: return "请输入角色昵称"
            
        case .sex: return "请选择角色性别信息"
            
        case .equip: return "请选择角色装备信息"
            
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

@objc public final class ZCharactersEditBean: NSObject {
    
    @objc public var type: ZCharactersEditType = .character
    
    @objc public var subtitle: String = ""
    
    @objc public var title: String {
        
        return type.title;
    }
    
    @objc public var placeholder: String {
        
        return type.placeholder;
    }
    
    static var types: [ZCharactersEditBean] {
        
        let space = ZCharactersEditBean()
        
        space.type = .space
        
        let character = ZCharactersEditBean()
        
        character.type = .character
        
        let name = ZCharactersEditBean()
        
        name.type = .name
        
        let sex = ZCharactersEditBean()
        
        sex.type = .sex
        
        let equip = ZCharactersEditBean()
        
        equip.type = .equip
        
        return [space ,character ,name ,space ,sex ,equip]
    }
}
public struct ZCharactersEditViewModel: WLBaseViewModel {
    
    public var input: WLInput
    
    public var output: WLOutput
    
    public struct WLInput {
        
        let modelSelect: ControlEvent<ZCharactersEditBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let completeTaps: Signal<Void>
        
        let isEdit: Bool
        
        let title: Driver<String>
        
        let sex: Driver<String>
        
        let equips: Driver<String>
        
        let name: Driver<String>
        
        let encode: String
    }
    public struct WLOutput {
        
        let zip: Observable<(ZCharactersEditBean,IndexPath)>
        
        let tableData: BehaviorRelay<[ZCharactersEditBean]> = BehaviorRelay<[ZCharactersEditBean]>(value: ZCharactersEditBean.types)
        
        /* 完成 序列*/
        let completing: Driver<Void>
        /* 完成结果 */
        let completed: Driver<WLBaseResult>
    }
    public init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let completing = input.completeTaps.flatMap { Driver.just($0) }
        
        let uap = Driver.combineLatest(input.title, input.sex,input.equips,input.name)
        
        let completed: Driver<WLBaseResult> = input
            .completeTaps
            .withLatestFrom(uap)
            .flatMapLatest {
                
                if $0.0 == "" {
                    
                    return Driver<WLBaseResult>.just(WLBaseResult.failed("请选择角色信息"))
                }
                if $0.1 == "" {
                    
                    return Driver<WLBaseResult>.just(WLBaseResult.failed("请选择角色性别信息"))
                }
                if $0.2 == "" {
                    
                    return Driver<WLBaseResult>.just(WLBaseResult.failed("请选择角色装备信息"))
                }
                if $0.3 == "" {
                    
                    return Driver<WLBaseResult>.just(WLBaseResult.failed("请输入角色姓名"))
                }
                
                let title = ZKeyValueBean()
                
                title.type = "title"
                
                title.value = $0.0
                
                var result = [title]
                
                let name = ZKeyValueBean(JSON: ["type":"txt","value":"cName=\($0.3)"])!
                
                let sex = ZKeyValueBean(JSON: ["type":"txt","value":"sex=\($0.1)"])!
                
                let equips = ZKeyValueBean(JSON: ["type":"txt","value":$0.2])!
                
                result += [name,sex,equips]
                
                let content = WLJsonCast.cast(argu: result.toJSON())
                
                return onUserDictResp(input.isEdit ? ZUserApi.updateCircle("角色信息", content: content,encode: input.encode) : ZUserApi.publish("角色信息", content: content))
                    .mapObject(type: ZCircleBean.self)
                    .map({ WLBaseResult.operation($0) })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
        }
        
        let output = WLOutput(zip: zip, completing: completing, completed: completed)
        
        self.output = output
    }
}
