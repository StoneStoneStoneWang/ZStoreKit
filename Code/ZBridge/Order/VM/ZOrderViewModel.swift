//
//  ZOrderViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/12/26.
//  Copyright © 2019 three stone 王. All rights reserved.
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

struct ZOrderViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<ZCircleBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let headerRefresh: Driver<Void>
        
        let footerRefresh: Driver<Void>
        
        let page: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 1)
        
        let tag: String
    }
    
    struct WLOutput {
        
        let zip: Observable<(ZCircleBean,IndexPath)>
        
        let tableData: BehaviorRelay<[ZCircleBean]> = BehaviorRelay<[ZCircleBean]>(value: [])
        
        let endHeaderRefreshing: Driver<WLBaseResult>
        
        let endFooterRefreshing: Driver<WLBaseResult>
        
        let footerHidden: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: true)
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let headerRefreshData = input
            .headerRefresh
            .flatMapLatest({_ in
                
                return onUserArrayResp(ZUserApi.fetchMyList(input.tag, page: 1))
                    .mapArray(type: ZCircleBean.self)
                    .map({ return $0.count > 0 ? WLBaseResult.fetchList($0) : WLBaseResult.empty })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
            })
        
        let endHeaderRefreshing = headerRefreshData.map { $0 }
        
        let footerRefreshData = input
            .footerRefresh
            .flatMapLatest({_ in
                
                return onUserArrayResp(ZUserApi.fetchMyList(input.tag, page: input.page.value))
                    .mapArray(type: ZCircleBean.self)
                    .map({ return $0.count > 0 ? WLBaseResult.fetchList($0) : WLBaseResult.empty })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
            })
        
        let endFooterRefreshing = footerRefreshData.map { $0 }
        
        let output = WLOutput(zip: zip, endHeaderRefreshing: endHeaderRefreshing, endFooterRefreshing: endFooterRefreshing)
        
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

    static func updateCircle(_ tag: String,content: String,encode: String) -> Driver<WLBaseResult> {
        
        return onUserVoidResp(ZUserApi.updateCircle(tag, content: content, encode: encode))
            .map({ WLBaseResult.ok("更新成功！")  })
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
    
    static func removeMyCircle(_ encoded: String ) -> Driver<WLBaseResult> {
        
        return onUserVoidResp(ZUserApi.deleteMyCircle(encoded))
            .map({ WLBaseResult.ok("删除成功！")  })
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
}


// 出租T 无需求 三大本 任务  出租T 无需求 三大本 任务  出租T 无需求 三大本 任务  出租T 无需求 三大本 任务  出租T 无需求 三大本 任务
// 代工 [野性之皮][魔暴龙皮护腿][魔暴龙皮手套] 1.2收硬甲皮 1.25收厚皮 邮寄立取
// 竞技场 老高已出 来老板 [野蛮角斗士链甲]
// 《龙卷风》1团 备战bwl 目前GKP 1团(周五晚6.30开打)招收稳定FS2名 小德1名 牧师1名 2团(周二晚6.30开打)招收 奶妈若干 法师若干

