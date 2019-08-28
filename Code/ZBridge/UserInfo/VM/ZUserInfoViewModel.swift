//
//  ZUserInfoViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLReqKit
import WLBaseResult
import ZCache
import ZApi
import ZRealReq
import ZBean

@objc public final class ZUserInfoBean: NSObject {
    
    @objc public var type: ZUserInfoType = .header
    
    @objc public var img: UIImage!
    
    @objc public var subtitle: String = ""
    
    @objc public var title: String {
        
        return type.title;
    }
    
    static var types: [ZUserInfoBean] {
        
        let space = ZUserInfoBean()
        
        space.type = .space
        
        let header = ZUserInfoBean()
        
        header.type = .header
        
        let name = ZUserInfoBean()
        
        name.type = .name
        
        let phone = ZUserInfoBean()
        
        phone.type = .phone
        
        let sex = ZUserInfoBean()
        
        sex.type = .sex
        
        let birth = ZUserInfoBean()
        
        birth.type = .birth
        
        let signature = ZUserInfoBean()
        
        signature.type = .signature
        
        return [space ,header ,name ,phone ,space ,sex ,birth ,signature]
    }
}

@objc (ZUserInfoType)
public enum ZUserInfoType: Int {
    
    case header
    
    case name
    
    case phone
    
    case sex
    
    case signature
    
    case birth
    
    case space
}


extension ZUserInfoType {
    
    static var types: [ZUserInfoType] {
        
        return [.space ,.header ,.name ,.phone ,.space ,.sex ,.birth ,.signature]
    }
    
    var title: String {
        
        switch self {
            
        case .header: return "头像"
            
        case .name: return "昵称"
            
        case .phone: return "手机号"
            
        case .sex: return "性别"
            
        case .signature: return "个性签名"
            
        case .birth: return "生日"
            
        case .space: return ""
            
        }
    }
    
    var cellHeight: CGFloat {
        switch self {
        case .space: return 10
            
        case .header: return 80
            
        default: return 55
            
        }
    }
    
    var updateKey: String {
        
        switch self {
        case .name: return "users.nickname"
            
        case .birth: return "users.birthday"
            
        case .signature: return "users.signature"
            
        case .sex: return "users.sex"
            
        case .header: return "users.headImg"
        default: return ""
            
        }
    }
}

public struct ZUserInfoViewModel: WLBaseViewModel {
    
    public var input: WLInput
    
    public var output: WLOutput
    
    public struct WLInput {
        
        let modelSelect: ControlEvent<ZUserInfoBean>
        
        let itemSelect: ControlEvent<IndexPath>
    }
    public struct WLOutput {
        
        let zip: Observable<(ZUserInfoBean,IndexPath)>
        
        let tableData: BehaviorRelay<[ZUserInfoBean]> = BehaviorRelay<[ZUserInfoBean]>(value: ZUserInfoBean.types)
    }
    public init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let output = WLOutput(zip: zip)
        
        ZUserInfoCache.default
            .rx
            .observe(ZUserBean.self, "userBean")
            .subscribe(onNext: { (user) in
                
                if let user = user {
                    
                    output.tableData.value[1].subtitle = user.headImg
                    
                    output.tableData.value[2].subtitle = user.nickname
                    
                    output.tableData.value[3].subtitle = user.phone
                    
                    output.tableData.value[5].subtitle = user.gender.gender
                    
                    output.tableData.value[6].subtitle = user.birthday
                    
                    output.tableData.value[7].subtitle = user.signature
                }
            })
            .disposed(by: disposed)
        
        self.output = output
    }
    
    public static func updateUserInfo(type: ZUserInfoType,value: String) -> Driver<WLBaseResult>{
        
        return onUserDictResp(ZUserApi.updateUserInfo(type.updateKey, value: value))
            .mapObject(type: ZUserBean.self)
            .map({ ZUserInfoCache.default.saveUser(data: $0) })
            .map { _ in WLBaseResult.ok("")}
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
    
    public static func fetchAliToken() -> Driver<WLBaseResult> {
        
        return onAliDictResp(ZUserApi.aliToken)
            .map { WLBaseResult.fetchSomeObject($0 as AnyObject)}
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
}
