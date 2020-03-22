//
//  ZVideoBridge.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/22.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import ZBridge
import ZTransition
import ZHud
import ZCache

@objc(ZVideoActionType)
public enum ZVideoActionType: Int ,Codable {
    
    case myCircle = 0
    
    case circle = 1
    
    case comment = 2
    
    case watch = 3
    
    case report = 4
    
    case unLogin = 5
    
    case like = 6
    
    case focus = 7
    
    case black = 8
    
    case remove = 9
    
    case share = 10
}

public typealias ZVideoAction = (_ action: ZVideoActionType ,_ vc: ZTViewController) -> ()

@objc (ZTListBridge)
public final class ZVideoBridge: ZBaseBridge {
    
    var viewModel: ZVideoViewModel!
    
    weak var vc: ZTViewController!
}
extension ZVideoBridge {
    
    @objc public func createVideo(_ vc: ZTViewController) {
        
        self.vc = vc
    }
}
extension ZVideoBridge {
    
    @objc public func addBlack(_ OUsEncoded: String,targetEncoded: String ,content: String ,action: @escaping ZVideoAction) {
        
        if !ZAccountCache.default.isLogin() {
            
            action(.unLogin,self.vc)
            
            return
        }
        
        ZHudUtil.show(withStatus: "添加黑名单中...")
        
        ZVideoViewModel
            .addBlack(OUsEncoded, targetEncoded: targetEncoded, content: content)
            .drive(onNext: { (result) in
                
                ZHudUtil.pop()
                
                switch result {
                case .ok(let msg):
                
                    ZHudUtil.showInfo(msg)
                    
                    action(.black,self.vc)
                    
                case .failed(let msg):
                    
                    ZHudUtil.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    @objc public func focus(_ uid: String ,encode: String ,isFocus: Bool,action: @escaping ZVideoAction) {
        
        if !ZAccountCache.default.isLogin() {
            
            action(.unLogin,self.vc)
            
            return
        }
        
        ZHudUtil.show(withStatus: isFocus ? "取消关注中..." : "关注中...")
        
        ZVideoViewModel
            .focus(uid, encode: encode)
            .drive(onNext: { (result) in
                
                ZHudUtil.pop()
                
                switch result {
                case .ok:
                    
                    action(.focus,self.vc)
                    
                    ZHudUtil.showInfo(isFocus ? "取消关注成功" : "关注成功")
                case .failed(let msg):
                    
                    ZHudUtil.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
    }

    @objc public func like(_ encoded: String,isLike: Bool,action: @escaping ZVideoAction) {
        
        if !ZAccountCache.default.isLogin() {
            
            action(.unLogin,self.vc)
            
            return
        }
        
        ZHudUtil.show(withStatus: isLike ? "取消点赞中..." : "点赞中...")
        
        ZVideoViewModel
            .like(encoded, isLike: !isLike)
            .drive(onNext: { [unowned self] (result) in
                
                ZHudUtil.pop()
                
                switch result {
                case .ok(let msg):
                
                    action(.like,self.vc)
                    
                    ZHudUtil.showInfo(msg)
                case .failed(let msg):
                    
                    ZHudUtil.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
}
