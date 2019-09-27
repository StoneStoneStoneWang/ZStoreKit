Pod::Spec.new do |spec|
  
  spec.name         = "ZPublish"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For 发布."
  spec.description  = <<-DESC
  ZPublish是发布
  DESC
  
  spec.homepage     = "https://github.com/StoneStoneStoneWang/ZStoreKit.git"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author             = { "StoneStoneStoneWang" => "yuanxingfu1314@163.com" }
  spec.platform     = :ios, "10.0"
  spec.ios.deployment_target = "10.0"
  
  spec.swift_version = '5.0'
  
  spec.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  
  spec.static_framework = true
  
  spec.frameworks = 'UIKit', 'Foundation' ,'AVFoundation' ,'CoreServices'
  
  spec.source = { :git => "https://github.com/StoneStoneStoneWang/ZStoreKit.git", :tag => "#{spec.version}" }
  
  spec.source_files = "Code/ZPublish/*.{h,m}"
  spec.dependency 'ZConfig'
  spec.dependency 'Masonry'
  spec.dependency 'JXTAlertManager'
  spec.dependency 'SDWebImage'
  spec.dependency 'ZBridge/Publish'
  spec.dependency 'ZTextEdit'
  spec.dependency 'ZTextField'
  spec.dependency 'WLToolsKit/Image'
end

