//
//  ZCarouselViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2020/3/12.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLToolsKit
import WLBaseResult

@objc (ZCarouselStyle)
public enum ZCarouselStyle: Int {
    case one
    case two
}

struct ZCarouselViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let contentoffSetX: Observable<CGFloat>
        
        let modelSelect: ControlEvent<String>
        
        let itemSelect: ControlEvent<IndexPath>
        
        /* 定时器 序列*/
        let timer: Observable<Int> = Observable<Int>.timer(1, period: 4, scheduler: MainScheduler.instance)
        
        let currentPage: BehaviorRelay<Int>
        
        let style: ZCarouselStyle
    }
    
    struct WLOutput {
        
        let tableData: BehaviorRelay<[String]>
        
        let timered: Observable<Int>
        
        let zip: Observable<(String,IndexPath)>
        
        let currentPage: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    }
    
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let tableData: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: [])
        
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
                
                output.currentPage.accept(Int(x / width) % 4)
            })
            .disposed(by: disposed)
        
    }
}
