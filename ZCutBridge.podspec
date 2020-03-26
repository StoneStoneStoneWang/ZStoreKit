Pod::Spec.new do |spec|
  
  spec.name         = "ZCutBridge"
  spec.version      = "0.6.9"
  spec.summary      = "A Lib For bridge."
  spec.description  = <<-DESC
  ZCutBridge是oc swift 转换的封装呢
  DESC
  
  spec.homepage     = "https://github.com/StoneStoneStoneWang/ZStoreKit.git"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author             = { "StoneStoneStoneWang" => "yuanxingfu1314@163.com" }
  spec.platform     = :ios, "10.0"
  spec.ios.deployment_target = "10.0"
  
  spec.swift_version = '5.0'
  
  spec.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  
  spec.static_framework = true
  
  spec.frameworks = 'UIKit', 'Foundation'
  
  spec.source = { :git => "https://github.com/StoneStoneStoneWang/ZStoreKit.git", :tag => "#{spec.version}" }
  
  # 协议
  spec.subspec 'Pro' do |protocol|
    
    protocol.subspec 'VM' do |vm|
      
      vm.source_files = "Code/ZBridge/Protocol/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'RxSwift'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ZSign'
    end
    
    #    protocol.subspec 'Bridge' do |bridge|
    #      bridge.source_files = "Code/ZBridge/Protocol/Bridge/*.{swift}"
    #      bridge.dependency 'ZCutBridge/Protocol/VM'
    #      bridge.dependency 'ZTextInner'
    #      bridge.dependency 'ZBridge/Base'
    #
    #    end
  end
  
#  spec.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }

end
