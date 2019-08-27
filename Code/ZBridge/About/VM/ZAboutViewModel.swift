//
//  ZAboutViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift

@objc public final class ZAboutBean: NSObject {
    
    var type: ZAboutType = .space
    
    var title: String = ""
    
    var subTitle: String = ""
    
    @objc public static func createAbout(_ type: ZAboutType ,title: String ,subTitle: String) -> ZAboutBean {
        
        let about = ZAboutBean()
        
        about.type = type
        
        about.title = title
        
        about.subTitle = subTitle
        
        return about
    }
    private override init() { }
}

@objc (ZAboutType)
public enum ZAboutType: Int {
    
    case version
    
    case email
    
    case wechat
    
    case space
}

extension ZAboutType {
    
    static var types: [ZAboutType] {
        
        return [.space,.version,.email,.wechat]
    }
    
    var cellHeight: CGFloat {
        switch self {
        case .space: return 10
            
        default: return 55
            
        }
    }
    
    var title: String {
        
        switch self {
            
        case .version: return "版本号"
            
        case .email: return "官方邮箱"
            
        case .wechat: return "客服微信"
            
        case .space: return ""
        }
    }
    
    var subtitle: String {
        
        switch self {
            
        case .version: return "当前版本: \(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String)"
            
        case .email:
            
            guard let info = Bundle.main.infoDictionary else { return "" }
            
            return (info["CFBundleDisplayName"] as? String ?? "").transformToPinYin() + "@163.com"
            
        case .wechat:
            
            guard let info = Bundle.main.infoDictionary else { return "" }
            
            return info["CFBundleDisplayName"] as? String ?? ""
            
        case .space: return ""
        }
    }
}

struct ZAboutViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<ZAboutType>
        
        let itemSelect: ControlEvent<IndexPath>
    }
    struct WLOutput {
        
        let zip: Observable<(ZAboutType,IndexPath)>
        
        let tableData: BehaviorRelay<[ZAboutType]> = BehaviorRelay<[ZAboutType]>(value: ZAboutType.types)
    }
    init(_ input: WLInput) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        self.output = WLOutput(zip: zip)
    }
}
