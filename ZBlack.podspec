Pod::Spec.new do |spec|
  
  spec.name         = "ZBlack"
  spec.version      = "0.4.6"
  spec.summary      = "A Lib For 黑名单."
  spec.description  = <<-DESC
  ZBlack是黑名单界面
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
  
  spec.source_files = "Code/ZBlack/*.{h,m}"
  spec.dependency 'ZConfig'
  spec.dependency 'ZActionBridge/Black/Bridge'
  spec.dependency 'ZTable'
  spec.dependency 'Masonry'
  spec.dependency 'SDWebImage'
end
