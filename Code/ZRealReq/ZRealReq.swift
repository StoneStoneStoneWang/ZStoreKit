//
//  ZRealReq.swift
//  ZRealReq
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxSwift
import WLReqKit
import ZCache
import ZReq
import ZUpload
import ZSign

public func onUserDictResp<T : WLObserverReq>(_ req: T) -> Observable<[String:Any]> {
    
    return Observable<[String:Any]>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !ZAccountCache.default.token.isEmpty {
            
            params.updateValue(ZAccountCache.default.token, forKey: "token")
        }
        
        ZReqHandler.s_postWithUrl(url: req.host + req.reqName, params: params, header: req.headers, succ: { (data) in
            
            observer.onNext(data as! [String:Any])
            
            observer.onCompleted()
        }, fail: { (error) in
            
            let ocError = error as NSError
            
            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func onUserArrayResp<T : WLObserverReq>(_ req: T) -> Observable<[Any]> {
    
    return Observable<[Any]>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !ZAccountCache.default.token.isEmpty {
            
            params.updateValue(ZAccountCache.default.token, forKey: "token")
        }
        ZReqHandler.s_postWithUrl(url: req.host + req.reqName, params: params, header: req.headers, succ: { (data) in

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


// 无返回值的 在data里
public func onUserVoidResp<T : WLObserverReq>(_ req: T) -> Observable<Void> {
    
    return Observable<Void>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !ZAccountCache.default.token.isEmpty {
            
            params.updateValue(ZAccountCache.default.token, forKey: "token")
        }
        
        ZReqHandler.s_postWithUrl(url: req.host + req.reqName, params: params, header: req.headers, succ: { (data) in

            observer.onNext(())

            observer.onCompleted()

        }, fail: { (error) in

            let ocError = error as NSError

            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func onAliDictResp<T : WLObserverReq>(_ req: T) -> Observable<ZALCredentialsBean> {
    
    return Observable<ZALCredentialsBean>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !ZAccountCache.default.token.isEmpty {
            
            params.updateValue(ZAccountCache.default.token, forKey: "token")
        }
        
        ZUploadManager.fetchAliObj(withUrl: req.host + req.reqName , andParams: params, andHeader: req.headers, andSucc: { (credentials) in

            observer.onNext(credentials)

            observer.onCompleted()

        }, andFail: { (error) in

            let ocError = error as NSError

            if ocError.code == 131 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }

            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func onUploadImgResp(_ data: Data ,file: String ,param: ZALCredentialsBean) -> Observable<String> {
    
    return Observable<String>.create({ (observer) -> Disposable in
        
        ZUploadManager.uploadAvatar(with: data, andFile: file, andUid: ZAccountCache.default.uid, andParams: param, andSucc: { (objKey) in

            observer.onNext(objKey)

            observer.onCompleted()

        }, andFail: { (error) in

            let ocError = error as NSError

            if ocError.code == 132 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }

            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func onUploadPubImgResp(_ data: Data ,file: String ,param: ZALCredentialsBean) -> Observable<String> {
    
    return Observable<String>.create({ (observer) -> Disposable in
        
        ZUploadManager.uploadImage(with: data, andFile: file, andUid: ZAccountCache.default.uid, andParams: param, andSucc: { (objKey) in

            observer.onNext(objKey)

            observer.onCompleted()

        }, andFail: { (error) in

            let ocError = error as NSError

            if ocError.code == 132 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }

            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}
public func onUploadVideoResp(_ data: Data ,file: String ,param: ZALCredentialsBean) -> Observable<String> {
    
    return Observable<String>.create({ (observer) -> Disposable in
        
        ZUploadManager.uploadVideo(with: data, andFile: file, andUid: ZAccountCache.default.uid, andParams: param, andSucc: { (objKey) in

            observer.onNext(objKey)

            observer.onCompleted()

        }, andFail: { (error) in

            let ocError = error as NSError

            if ocError.code == 132 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }

            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
//
        return Disposables.create { }
    })
}
