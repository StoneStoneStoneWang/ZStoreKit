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

@objc public final class ZSettingBean: NSObject {
    
    @objc public var type: ZSettingType = .space
    
    @objc public var title: String = ""
    
    @objc public static func createSetting(_ type: ZSettingType ,title: String) -> ZSettingBean {
        
        let setting = ZSettingBean()
        
        setting.type = type
        
        setting.title = title
        
        return setting
    }
    private override init() {
        
    }
}

@objc (ZSettingType)
public enum ZSettingType: Int {
    
    case pwd  = 0 // 未登录
    
    case password = 1// 已登录
    
    case logout = 2
    
    case clear = 3
    
    case push = 4
    
    case space = 5
    
    case black = 6
}

extension ZSettingType {
    
    static var types: [ZSettingType] {
        
        if ZAccountCache.default.isLogin() {
            
            if ZConfigure.fetchPType() == .circle {
                
                return [.space,.password,.black,.space,.clear,.push,.space,.logout]
            } else if ZConfigure.fetchPType() == .store {
                
                return [.space,.password,.space,.clear,.push,.space,.logout]
            } else {
                
                return [.space,.password,.black,.space,.clear,.push,.space,.logout]
            }
        } else {
            
            return [.space,.pwd,.space,.clear,.push]
        }
    }
    
    public var title: String {
        
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
        
        let modelSelect: ControlEvent<ZSettingType>
        
        let itemSelect: ControlEvent<IndexPath>
    }
    public struct WLOutput {
        
        let zip: Observable<(ZSettingType,IndexPath)>
        
        let tableData: BehaviorRelay<[ZSettingType]> = BehaviorRelay<[ZSettingType]>(value: ZSettingType.types)
    }
    
    init(_ input: WLInput) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        self.output = WLOutput(zip: zip)
    }
}

