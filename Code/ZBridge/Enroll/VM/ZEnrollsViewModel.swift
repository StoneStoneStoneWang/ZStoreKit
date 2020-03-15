//
//  ZEnrollsViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2020/3/11.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLReqKit
import WLBaseResult
import ZBean
import ZRealReq
import ZApi
import WLToolsKit

fileprivate let cTag: String = "活动报名"

struct ZEnrollsViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<ZCircleBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let headerRefresh: Driver<Void>
        
        let footerRefresh: Driver<Void>
        
        let addItemTapped: Signal<Void>
        
        let page: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 1)
        
        let tag: String
    }
    
    struct WLOutput {
        
        let zip: Observable<(ZCircleBean,IndexPath)>
        
        let tableData: BehaviorRelay<[ZCircleBean]> = BehaviorRelay<[ZCircleBean]>(value: [])
        
        let endHeaderRefreshing: Driver<WLBaseResult>
        
        let endFooterRefreshing: Driver<WLBaseResult>
        
        let footerHidden: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: true)
        
        let added: Driver<Void>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let headerRefreshData = input
            .headerRefresh
            .flatMapLatest({_ in
                
                return onUserArrayResp(ZUserApi.fetchMyList("\(cTag)-\(input.tag)", page: 1))
                    .mapArray(type: ZCircleBean.self)
                    .map({ return $0.count > 0 ? WLBaseResult.fetchList($0) : WLBaseResult.empty })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
            })
        
        let endHeaderRefreshing = headerRefreshData.map { $0 }
        
        let footerRefreshData = input
            .footerRefresh
            .flatMapLatest({_ in
                
                return onUserArrayResp(ZUserApi.fetchMyList("\(cTag)-\(input.tag)", page: input.page.value))
                    .mapArray(type: ZCircleBean.self)
                    .map({ return $0.count > 0 ? WLBaseResult.fetchList($0) : WLBaseResult.empty })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
            })
        
        let endFooterRefreshing = footerRefreshData.map { $0 }
        
        let added: Driver<Void> = input.addItemTapped.flatMap { Driver.just($0) }
        
        let output = WLOutput(zip: zip, endHeaderRefreshing: endHeaderRefreshing, endFooterRefreshing: endFooterRefreshing, added: added)
        
        headerRefreshData
            .drive(onNext: { (result) in
                
                switch result {
                case let .fetchList(items):
                    
                    if !items.isEmpty {
                        
                        input.page.accept(2)
                        
                        if items.count < 20 {
                            
                            output.footerHidden.accept(true)
                            
                            input.page.accept(1)
                        } else {
                            
                            output.footerHidden.accept(false)
                        }
                    } else {
                        
                        input.page.accept(1)
                        
                        output.footerHidden.accept(true)
                    }
                    
                    output.tableData.accept(items as! [ZCircleBean])
                    
                case .empty: output.tableData.accept([])
                default: break
                }
            })
            .disposed(by: disposed)
        
        footerRefreshData
            .drive(onNext: { (result) in
                
                switch result {
                case let .fetchList(items):
                    
                    if !items.isEmpty {
                        
                        var page = input.page.value
                        
                        page += 1
                        
                        input.page.accept(page)
                        
                        if items.count < 20 {
                            
                            output.footerHidden.accept(true)
                            
                        } else {
                            
                            output.footerHidden.accept(false)
                        }
                    } else {
                        
                        output.footerHidden.accept(true)
                    }
                    
                    var values = output.tableData.value
                    
                    values += items as! [ZCircleBean]
                    
                    output.tableData.accept(values )
                default: break
                }
            })
            .disposed(by: disposed)
        
        self.output = output
    }
}
