//
//  ZCommentAdd.swift
//  ZBridge
//
//  Created by three stone 王 on 2020/3/13.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLReqKit
import ZBean
import WLBaseResult
import ZRealReq
import ZApi

struct ZCommentAddViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {

        let sendTaps: Signal<Void>
    }
    
    struct WLOutput {
    
        let sended: Driver<Void>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let sended = input.sendTaps.flatMapLatest { Driver.just($0) }
        
        let output = WLOutput(sended: sended)
        
        self.output = output
    }
    
    static func addComment(_ encoded: String,content: String) -> Driver<WLBaseResult> {
        
        return onUserDictResp(ZUserApi.addComment(encoded, content: content, tablename: "CircleFriends", type: "0"))
            .mapObject(type: ZCommentBean.self)
            .map({ WLBaseResult.operation($0) })
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
}
