Pod::Spec.new do |spec|
  
  spec.name         = "ZNickName"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For 昵称蛇追."
  spec.description  = <<-DESC
  ZNickName是昵称蛇追
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
  
  spec.source_files = "Code/ZNickName/*.{h,m}"
  spec.dependency 'ZTextField'
  spec.dependency 'ZConfig'
  spec.dependency 'ZBridge/NickName'
  spec.dependency 'Masonry'
  spec.dependency 'ZTransition'
  
end
