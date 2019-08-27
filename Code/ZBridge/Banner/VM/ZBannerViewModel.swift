//
//  ZBannerViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/27.
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
import ZRealReq
import ZApi

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
    }
    
    struct WLOutput {
        
        let tableData: BehaviorRelay<[ZCircleBean]>
        
        let timered: Observable<Int>
        
        let zip: Observable<(ZCircleBean,IndexPath)>
        
    }
    
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let tableData: BehaviorRelay<[ZCircleBean]> = BehaviorRelay<[ZCircleBean]>(value: [])
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        input
            .contentoffSetX
            .subscribe(onNext: { (x) in
                
                let width = input.style == .one ? (WL_SCREEN_WIDTH - 60 ) : WL_SCREEN_WIDTH
                
                input.currentPage.accept(Int(x / width) )
                
            })
            .disposed(by: disposed)
        
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
        
        self.output = WLOutput(tableData: tableData, timered: timered, zip: zip)
    }
    static func fetchBanners() -> Driver<WLBaseResult> {
        
        return onUserArrayResp(ZUserApi.fetchList("", page: 1))
            .mapArray(type: ZCircleBean.self)
            .map({ WLBaseResult.fetchList($0)})
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
}
