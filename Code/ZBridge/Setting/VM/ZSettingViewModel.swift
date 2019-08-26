//
//  ZSettingViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import ZCache
import ZSign

public enum WLSettingType {
    
    case pwd // 未登录
    
    case password // 已登录
    
    case logout
    
    case clear
    
    case push
    
    case space
    
    case black
}

extension WLSettingType {
    
    static var types: [WLSettingType] {
        
        if ZAccountCache.default.isLogin() {
            
            if ZConfigure.fetchPType() == .circle {
                
                return [.space,.password,.black,.space,.clear,.push,.space,.logout]
            } else if ZConfigure.fetchPType() == .store {
                
                return [.space,.password,.space,.clear,.push,.space,.logout]
            } else {
                
                return [.space,.password,.space,.clear,.push,.space,.logout]
            }
        } else {
            
            return [.space,.pwd,.space,.clear,.push]
        }
    }
    
    var title: String {
        
        switch self {
            
        case .pwd: return "忘记密码"
            
        case .password: return "修改密码"
            
        case .logout: return "退出登录"
            
        case .clear: return "清理缓存"
            
        case .push: return "推送设置"
            
        case .black: return "黑名单"
            
        default: return ""
            
        }
    }
    
    var cellHeight: CGFloat {
        
        switch self {
        case .space: return 10
            
        default: return 55
        }
    }
}

public struct ZSettingViewModel: WLBaseViewModel {
    
    public var input: WLInput
    
    public var output: WLOutput
    
    public struct WLInput {
        
        let modelSelect: ControlEvent<WLSettingType>
        
        let itemSelect: ControlEvent<IndexPath>
    }
    public struct WLOutput {
        
        let zip: Observable<(WLSettingType,IndexPath)>
        
        let tableData: BehaviorRelay<[WLSettingType]> = BehaviorRelay<[WLSettingType]>(value: WLSettingType.types)
    }
    
    init(_ input: WLInput) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        self.output = WLOutput(zip: zip)
    }
}

