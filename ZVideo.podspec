Pod::Spec.new do |spec|
  
  spec.name         = "ZVideo"
  spec.version      = "0.6.5"
  spec.summary      = "A Lib For 视频."
  spec.description  = <<-DESC
  ZVideo是视频展示
  DESC
  
  spec.homepage     = "https://github.com/StoneStoneStoneWang/ZStoreKit.git"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author             = { "StoneStoneStoneWang" => "yuanxingfu1314@163.com" }
  spec.platform     = :ios, "10.0"
  spec.ios.deployment_target = "10.0"
  
  spec.swift_version = '5.0'
  
  spec.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  
  spec.static_framework = true
  
  spec.frameworks = 'UIKit', 'Foundation' ,'AVFoundation'
  
  spec.source = { :git => "https://github.com/StoneStoneStoneWang/ZStoreKit.git", :tag => "#{spec.version}" }
  
  spec.source_files = "Code/ZVideo/*.{h,m}"
  spec.dependency 'ZConfig'
  spec.dependency 'ZPlayer'
  spec.dependency 'JXTAlertManager'
  spec.dependency 'ZBombBridge/Video/Bridge'
  spec.dependency 'SToolsKit'
  spec.dependency 'ZBean/Circle'
  spec.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
  
end

