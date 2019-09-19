//
//  ZPublishViewModel.swift
//  
//
//  Created by three stone 王 on 2019/9/19.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLToolsKit
import WLReqKit
import ObjectMapper
import WLBaseResult
import ZBean
import ZRealReq
import ZApi

@objc (ZPublishType)
public enum ZPublishType: Int {
    
    case video
    
    case image
}

public final class ZPublishViewModel: WLBaseViewModel {
    
    public var input: WLInput
    
    public var output: WLOutput
    
    public struct WLInput {
        
        let tag: String
        
        let title: Driver<String>
        
        let modelSelect: ControlEvent<ZKeyValueBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let completeTaps: Signal<Void>
        
        let textTaps: Signal<Void>
        
        let imageTaps: Signal<Void>
        
        let videoTaps: Signal<Void>
        
        let tableData: BehaviorRelay<[ZKeyValueBean]> = BehaviorRelay<[ZKeyValueBean]>(value: [])
    }
    
    public struct WLOutput {
        
        let zip: Observable<(ZKeyValueBean,IndexPath)>
        /* 完成 序列*/
        let completing: Driver<Void>
        /* 完成结果 */
        let completed: Driver<WLBaseResult>
        
        /* 选择文案 序列*/
        let textTaped: Driver<Void>
        /* 完成 序列*/
        let imageTaped: Driver<Void>
        
        /* 完成 序列*/
        let videoTaped: Driver<Void>
    }
    
    public init(_ input: WLInput ,type: ZPublishType) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let completing = input.completeTaps.flatMap { Driver.just($0) }
        
        let combine = Driver.combineLatest(input.title, input.tableData.asDriver())
        
        let completed: Driver<WLBaseResult> = input
            .completeTaps
            .withLatestFrom(combine)
            .flatMapLatest {
                
                if $0.0.wl_isEmpty { return Driver.just(WLBaseResult.failed("请输入标题")) }
                
                if type == .image {
                    
                    if $0.1.count == 0 { return Driver.just(WLBaseResult.failed("请选择图片")) }
                    
                    if !$0.1.contains(where: { $0.type == "image" }) { return Driver.just(WLBaseResult.failed("请选择至少一张图片")) }
                }
                
                if type == .video {
                    
                    if $0.1.count == 0 { return Driver.just(WLBaseResult.failed("请选择视频")) }
                    
                    if !$0.1.contains(where: { $0.type == "video" }) { return Driver.just(WLBaseResult.failed("请选择视频")) }
                }
                
                let title = ZKeyValueBean()
                
                title.type = "title"
                
                title.value = $0.0
                
                var result = [title]
                
                result += $0.1
                
                let content = WLJsonCast.cast(argu: result.toJSON())
                
                return onUserDictResp(ZUserApi.publish(input.tag, content: content))
                    .mapObject(type: ZCircleBean.self)
                    .map({ WLBaseResult.operation($0) })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
        }
        
        let textTaped = input.textTaps.flatMap { Driver.just($0) }
        
        let imageTaped = input.imageTaps.flatMap { Driver.just($0) }
        
        let videoTaped = input.videoTaps.flatMap { Driver.just($0) }
        
        self.output = WLOutput(zip: zip, completing: completing, completed: completed, textTaped: textTaped, imageTaped: imageTaped, videoTaped: videoTaped)
    }
}

extension ZPublishViewModel {
    
    public func removeContent(_ idx: Int) {
        
        var value = input.tableData.value
        
        value.remove(at: idx)
        
        input.tableData.accept(value)
    }
}
