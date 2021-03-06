Pod::Spec.new do |spec|
  
  spec.name         = "ZTextEdit"
  spec.version      = "0.4.5"
  spec.summary      = "A Lib For 文本编辑"
  spec.description  = <<-DESC
  ZTextEdit是地图
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
  
  spec.source_files = "Code/ZTextEdit/*.{h,m}"
  spec.dependency 'ZConfig'
  spec.dependency 'ZTransition'
  spec.dependency 'ZActionBridge/TextEdit'
  spec.dependency 'Masonry'
end

