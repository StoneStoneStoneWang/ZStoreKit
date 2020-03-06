//
//  ZCharactersViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2020/3/4.
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

fileprivate let cTag: String = "角色信息"

struct ZCharactersViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<ZCircleBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let headerRefresh: Driver<Void>
        
        let footerRefresh: Driver<Void>
        
        let itemAccessoryButtonTapped: Driver<IndexPath>
        
        let addItemTapped: Signal<Void>
        
        let page: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 1)
    }
    
    struct WLOutput {
        
        let zip: Observable<(ZCircleBean,IndexPath)>
        
        let tableData: BehaviorRelay<[ZCircleBean]> = BehaviorRelay<[ZCircleBean]>(value: [])
        
        let endHeaderRefreshing: Driver<WLBaseResult>
        
        let endFooterRefreshing: Driver<WLBaseResult>
        
        let footerHidden: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: true)
        
        let itemAccessoryButtonTapped: Driver<IndexPath>
        
        let added: Driver<Void>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let headerRefreshData = input
            .headerRefresh
            .flatMapLatest({_ in
                
                return onUserArrayResp(ZUserApi.fetchMyList(cTag, page: 1))
                    .mapArray(type: ZCircleBean.self)
                    .map({ return $0.count > 0 ? WLBaseResult.fetchList($0) : WLBaseResult.empty })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
            })
        
        let endHeaderRefreshing = headerRefreshData.map { $0 }
        
        let footerRefreshData = input
            .footerRefresh
            .flatMapLatest({_ in
                
                return onUserArrayResp(ZUserApi.fetchMyList(cTag, page: input.page.value))
                    .mapArray(type: ZCircleBean.self)
                    .map({ return $0.count > 0 ? WLBaseResult.fetchList($0) : WLBaseResult.empty })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
            })
        
        let endFooterRefreshing = footerRefreshData.map { $0 }
        
        let itemAccessoryButtonTapped: Driver<IndexPath> = input.itemAccessoryButtonTapped.map { $0 }
        
        let added: Driver<Void> = input.addItemTapped.flatMap { Driver.just($0) }
        
        let output = WLOutput(zip: zip, endHeaderRefreshing: endHeaderRefreshing, endFooterRefreshing: endFooterRefreshing, itemAccessoryButtonTapped: itemAccessoryButtonTapped, added: added)
        
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
    
    static func addCharacters(_ tag: String,content: String) -> Driver<WLBaseResult> {
        
        return onUserVoidResp(ZUserApi.publish(tag, content: content))
            .map({ WLBaseResult.ok("添加角色信息成功！")  })
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
    
    static func updateCharacters(_ tag: String,content: String,encode: String) -> Driver<WLBaseResult> {
        
        return onUserVoidResp(ZUserApi.updateCircle(tag, content: content, encode: encode))
            .map({ WLBaseResult.ok("更新角色信息成功！")  })
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
    
    static func removeMyCharacters(_ encoded: String ) -> Driver<WLBaseResult> {
        
        return onUserVoidResp(ZUserApi.deleteMyCircle(encoded))
            .map({ WLBaseResult.ok("删除角色信息成功！")  })
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
}
