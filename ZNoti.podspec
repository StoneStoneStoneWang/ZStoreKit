
Pod::Spec.new do |spec|
  
  spec.name         = "ZNoti"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For 通知."
  spec.description  = <<-DESC
  ZNoti一个对通知的封装,我以后所有的界面跳转事件 都通过通知的方式抛出去
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
  
  spec.vendored_frameworks = 'ZNoti/ZNoti.framework'
  
end


