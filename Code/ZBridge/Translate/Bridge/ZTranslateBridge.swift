//
//  ZTranslateBridge.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/16.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import ZBridge
import ZTransition
import AVFoundation
import ZApi
import ZHud

@objc (ZTranslateBridge)
public final class ZTranslateBridge: ZBaseBridge {
    
    public var style: ZTranslateStyle = .ko
    
    var viewModel: ZTranslateViewModel!
    
    final let synthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()
    
    var speakLanguage: String = "zh-cn"
}
extension ZTranslateBridge {
    
    @objc public func createTranslate(_ vc: ZTViewController) {
        
        if let from = vc.view.viewWithTag(401) as? UITextView,let to = vc.view.viewWithTag(402) as? UITextView,let translateItem = vc.view.viewWithTag(403) as? UIButton ,let speaker = vc.view.viewWithTag(404) as? UIButton ,let placeHolder = vc.view.viewWithTag(405) as? UILabel {
            
            let input = ZTranslateViewModel.WLInput(translateTaps: translateItem.rx.tap.asSignal(),
                                                    from: from.rx.text.orEmpty.asDriver(),
                                                    to: to.rx.text.orEmpty.asDriver(),
                                                    speakerTaps: speaker.rx.tap.asSignal(),
                                                    style: style)
            
            viewModel = ZTranslateViewModel(input)
            
            viewModel
                .output
                .translating
                .drive(onNext: { (_) in
                    
                    ZHudUtil.show(withStatus: "翻译中...")
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .placeholderHidden
                .asObservable()
                .bind(to: placeHolder.rx.isHidden)
                .disposed(by: disposed)
            
            viewModel
                .output
                .translated
                .drive(onNext: {
                    
                    ZHudUtil.pop()
                    
                    switch $0 {
                        
                    case let .ok(message: msg):
                        
                        to.text = msg
                        
                        ZHudUtil.showInfo("翻译成功")
                        
                    case let .failed(message: msg):
                        
                        ZHudUtil.showInfo(msg)
                        
                    default: break
                    }
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .speaker
                .drive(onNext: { [weak self] in
                    
                    guard let `self` = self else { return }
                    
                    switch $0 {
                        
                    case let .ok(message: msg):
                        
                        let speaker = AVSpeechUtterance(string: msg)
                        
                        speaker.voice = AVSpeechSynthesisVoice(language: self.speakLanguage)
                        
                        speaker.rate = 0.4
                        
                        speaker.pitchMultiplier = 0.8
                        
                        speaker.postUtteranceDelay = 0.1
                        
                        self.synthesizer.speak(speaker)
                        
                    default: break
                    }
                    
                })
                .disposed(by: disposed)
        }
    }
    
    @objc public func changeLanguage(_ language: String) {
        
       speakLanguage = language
    }
    
    @objc public func changeStyle(_ style: ZTranslateStyle) {
        
        self.style = style
    }
}
