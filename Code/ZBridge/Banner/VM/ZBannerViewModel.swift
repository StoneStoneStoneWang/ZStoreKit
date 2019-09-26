//
//  ZBannerViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/9/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLToolsKit
import WLBaseResult
import WLReqKit
import ZBean
import ZApi
import ZRealReq

@objc (ZBannerStyle)
public enum ZBannerStyle: Int {
    case one
    case two
}


struct ZBannerViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let contentoffSetX: Observable<CGFloat>
        
        let modelSelect: ControlEvent<ZCircleBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        /* 定时器 序列*/
        let timer: Observable<Int> = Observable<Int>.timer(1, period: 4, scheduler: MainScheduler.instance)
        
        let currentPage: BehaviorRelay<Int>
        
        let style: ZBannerStyle
    }
    
    struct WLOutput {
        
        let tableData: BehaviorRelay<[ZCircleBean]>
        
        let timered: Observable<Int>
        
        let zip: Observable<(ZCircleBean,IndexPath)>
        
        let currentPage: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    }
    
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let tableData: BehaviorRelay<[ZCircleBean]> = BehaviorRelay<[ZCircleBean]>(value: [])
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let timered: Observable<Int> = Observable<Int>
            .create({ (ob) -> Disposable in
                
                input
                    .timer
                    .subscribe(onNext: { (res) in
                        
                        ob.onNext(input.currentPage.value + 1)
                        
                    })
                    .disposed(by: disposed)
                
                return Disposables.create { _ = input.timer.takeLast(tableData.value.count) }
            })
        
        let output = WLOutput(tableData: tableData, timered: timered, zip: zip)
        
        self.output = output
        
        input
            .contentoffSetX
            .subscribe(onNext: { (x) in
                
                let width = input.style == .one ?  WL_SCREEN_WIDTH : (WL_SCREEN_WIDTH - 60 )
                
                input.currentPage.accept(Int(x / width) )
                
                output.currentPage.accept(Int(x / width) / 4)
                
                printLog(message: output.currentPage.value)
            })
            .disposed(by: disposed)
        
    }
    static func fetchBanners() -> Driver<WLBaseResult> {
        
        return onUserArrayResp(ZUserApi.fetchList("", page: 1))
            .mapArray(type: ZCircleBean.self)
            .map({ WLBaseResult.fetchList($0)})
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
}
