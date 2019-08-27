//
//  ZProfileViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import ZNoti
import ZBean
import ZSign
import ZApi
import ZRealReq
import ZCache

@objc public final class ZProfileBean: NSObject {
    
    var type: ZProfileType = .space
    
    var title: String = ""
    
    @objc public static func createProfile(_ type: ZProfileType ,title: String) -> ZProfileBean {
        
        let profile = ZProfileBean()
        
        profile.type = type
        
        profile.title = title
        
        return profile
    }
    private override init() {
        
    }
}

@objc (ZProfileType)
public enum ZProfileType : Int{
    
    case about
    
    case userInfo
    
    case setting
    
    case contactUS
    
    case pravicy
    
    case focus
    
    case space
    
    case myCircle
    
    case order
    
    case address
}

extension ZProfileType {
    
    static var types: [ZProfileType] {
        
        if ZConfigure.fetchPType() == .store {
            
            return [.space,userInfo,.order,.address,.space,.contactUS,.pravicy,.about,.space,.setting]
        } else {
            
            if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
                
                if version > "1.1.0" {
                    
                    return [.space,userInfo,.myCircle,.focus,.space,.contactUS,.pravicy,.about,.space,.setting]
                }
            }
            
            return [.space,userInfo,.space,.contactUS,.pravicy,.about,.space,.setting]
        }
    }
    
    var cellHeight: CGFloat {
        
        switch self {
        case .space: return 10
            
        default: return 55
        }
    }
    
    var title: String {
        
        switch self {
            
        case .about: return "关于我们"
            
        case .contactUS: return "联系我们"
            
        case .userInfo: return "用户资料"
            
        case .setting: return "设置"
            
        case .pravicy: return "隐私政策"
            
        case .focus: return "我的关注"
            
        case .myCircle: return "我的发布"
            
        case .address: return "我的地址"
            
        case .order: return "我的订单"
            
        default: return ""
            
        }
    }
    
    public var notificationName: Notification.Name {
        
        var result: String = ""
        
        switch self {
            
        case .myCircle: result = ZNotiMyCircle
            
        case .order: result = ZNotiMyOrder
            
        case .about: result = ZNotiAboutUs
            
        case .address: result = ZNotiMyAddress
            
        case .focus: result = ZNotiFocus
            
        case .pravicy: result = ZNotiPrivacy
            
        case .setting: result = ZNotiSetting
            
        case .userInfo: result = ZNotiUserInfo
            
        default: break
            
        }
        
        return Notification.Name(rawValue: result)
    }
}


struct ZProfileViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<ZProfileType>
        
        let itemSelect: ControlEvent<IndexPath>
    }
    
    struct WLOutput {
        
        let zip: Observable<(ZProfileType,IndexPath)>
        
        let tableData: BehaviorRelay<[ZProfileType]> = BehaviorRelay<[ZProfileType]>(value: ZProfileType.types)
        
        let userInfo: Observable<ZUserBean?>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let userInfo: Observable<ZUserBean?> = ZUserInfoCache.default.rx.observe(ZUserBean.self, "userBean")
        
        ZUserInfoCache.default.userBean = ZUserInfoCache.default.queryUser()
        
        onUserDictResp(ZUserApi.fetchProfile)
            .mapObject(type: ZUserBean.self)
            .map({ ZUserInfoCache.default.saveUser(data: $0) })
            .subscribe(onNext: { (_) in })
            .disposed(by: disposed)
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        self.output = WLOutput(zip: zip, userInfo: userInfo)
    }
}

