Pod::Spec.new do |spec|
  
  spec.name         = "ZPrivacy"
  spec.version      = "0.1.2"
  spec.summary      = "A Lib For 隐私与协议."
  spec.description  = <<-DESC
  ZPravicy是隐私与协议
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
  
  spec.source_files = "Code/ZPrivacy/*.{h,m}"
  spec.dependency 'ZInner'
  spec.dependency 'ZConfig'
  spec.dependency 'ZBridge/Privacy'
  spec.dependency 'ZTransition'
  spec.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
end
