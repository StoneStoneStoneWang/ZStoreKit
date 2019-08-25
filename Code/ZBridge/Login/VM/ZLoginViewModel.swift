//
//  ZLoginViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxSwift
import RxCocoa
import WLReqKit
import ObjectMapper
import WLBaseResult
import ZApi
import ZReq
import ZRealReq
import ZBean
import ZCheck
import ZCache

public struct ZLoginViewModel: WLBaseViewModel {
    
    public var input: WLInput
    
    public var output: WLOutput
    
    public struct WLInput {
        
        /* 用户名 序列*/
        let username: Driver<String>
        /* 密码 序列*/
        let password: Driver<String>
        /* 登录按钮点击 序列*/
        let loginTaps: Signal<Void>
        
        let swiftLoginTaps: Signal<Void>
        
        let forgetTaps: Signal<Void>
        
        let passwordItemSelected: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
        
        let passwordItemTaps: Signal<Void>
    }
    public struct WLOutput {
        
        /* 登录中... 序列*/
        let logining: Driver<Void>
        /* 登录结果... 序列*/
        let logined: Driver<WLBaseResult>
        // 忘记密码点击回掉
        let swiftLogined: Driver<Void>
        
        let forgeted: Driver<Void>
        
        let passwordItemed: Driver<Bool>
        
        let passwordEntryed: Driver<Bool>
    }
    
    init(_ input: WLInput) {
        
        self.input = input
        // 用户名 密码合并
        let uap = Driver.combineLatest(input.username, input.password)
        
        let logining = input.loginTaps.flatMap { Driver.just($0) }
        
        let logined: Driver<WLBaseResult> = input
            .loginTaps
            .withLatestFrom(uap)
            .flatMapLatest {
                
                switch checkUsernameAndPassword($0.0, password: $0.1) {
                case .ok:
                    
                    return onUserDictResp(ZUserApi.login($0.0,password: $0.1))
                        .mapObject(type: ZAccountBean.self)
                        .map({ ZAccountCache.default.saveAccount(acc: $0) }) // 存储account
                        .map({ $0.toJSON()})
                        .mapObject(type: ZUserBean.self)
                        .map({ ZUserInfoCache.default.saveUser(data: $0) })
                        .map({ _ in WLBaseResult.logined })
                        .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
                    
                case let .failed(msg): return Driver<WLBaseResult>.just(WLBaseResult.failed(msg))
                    
                default: return Driver<WLBaseResult>.empty()
                }
        }
        
        let swiftLogined = input.swiftLoginTaps.flatMapLatest { Driver.just($0) }
        
        let forgeted = input.forgetTaps.flatMapLatest { Driver.just($0) }
        
        let passwordEntryed = input.passwordItemTaps.flatMapLatest { _ -> SharedSequence<DriverSharingStrategy, Bool> in return Driver.just(!input.passwordItemSelected.value) }
        
        let passwordItemed = input.passwordItemTaps.flatMapLatest { _ -> SharedSequence<DriverSharingStrategy, Bool> in
            
            input.passwordItemSelected.accept(!input.passwordItemSelected.value)
            
            return Driver.just(input.passwordItemSelected.value)
        }
        
        self.output = WLOutput(logining: logining, logined: logined ,swiftLogined: swiftLogined, forgeted: forgeted, passwordItemed: passwordItemed, passwordEntryed: passwordEntryed)
    }
}

