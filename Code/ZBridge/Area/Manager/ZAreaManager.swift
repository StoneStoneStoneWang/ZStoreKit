//
//  ZAreaManager.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/19.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import ZBean
import ZYYCache
import RxCocoa
import WLBaseResult
import RxSwift
import ZReq
import WLReqKit
import ZApi
import Alamofire

@objc (ZAreaManager)
public class ZAreaManager: NSObject {
    
    @objc (shared)
    public static let `default`: ZAreaManager = ZAreaManager()
    
    private override init() { }
    // 全部地区
    @objc public var allAreas: [ZAreaBean] = []
}

extension ZAreaManager {
    
      public func fetchAreas() -> Driver<WLBaseResult> {
        
        if allAreas.count > 0 {
            
            return Driver.just(WLBaseResult.fetchList(allAreas))
        } else {
            
            if isAreaFileExist() {
                
                let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
                
                let targetPath = cachePath + "/Areas"
                
                if let arr = NSArray(contentsOfFile: targetPath) {
                    
                    var mutable: [ZAreaBean] = []
                    
                    for item in arr {
                        
                        mutable += [ZAreaBean(JSON: item as! [String: Any])!]
                    }
                    
                    allAreas += mutable
                    
                    return Driver.just(WLBaseResult.fetchList(mutable))
                }
                
                return Driver.just(WLBaseResult.failed("获取本地数据失败!"))
            } else {
                
                return onAreaArrayResp(ZUserApi.fetchAreaJson)
                    .map({ ZAreaManager.default.saveArea($0) })
                    .map({ _ in WLBaseResult.fetchList(ZAreaManager.default.allAreas)  })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
            }
        }
    }
    
   @objc public func fetchSomeArea(_ id: Int)  -> ZAreaBean {
        
        assert(allAreas.count > 0, "请先调用 fetchArea")
        
        var result: ZAreaBean!
        
        for item in allAreas {
            
            if item.areaId == id {
                
                result = item
                
                break
            }
        }
        
        return result ?? ZAreaBean()
    }
    
   @objc public func saveArea(_ areas: [Any]) -> [Any] {
        
        for item in areas {
            
            allAreas += [ZAreaBean(JSON: item as! [String: Any])!]
        }
        
        let mutable = NSMutableArray()
        
        mutable.addObjects(from: areas)
        
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
        
        let targetPath = cachePath + "/Areas"
        
        mutable.write(toFile: targetPath, atomically: true)
        
        return areas
    }
    
    public func isAreaFileExist() -> Bool {
        
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
        
        let targetPath = cachePath + "/Areas"
        
        return FileManager.default.fileExists(atPath: targetPath)
    }
}

public func onAreaArrayResp<T : WLObserverReq>(_ req: T) -> Observable<[Any]> {
    
    return Observable<[Any]>.create({ (observer) -> Disposable in
        
        ZReqHandler.s_postAreaWithUrl(url: req.host + req.reqName, params: req.params, succ: { (data) in
            
            observer.onNext(data as! [Any])
            
            observer.onCompleted()
            
        }, fail: { (error) in
            
            let ocError = error as NSError
            
            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        
        return Disposables.create { }
    })
}
