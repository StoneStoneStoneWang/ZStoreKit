
Pod::Spec.new do |spec|
  
  spec.name         = "ZRealReq"
  spec.version      = "0.3.9"
  spec.summary      = "A Lib For realReq."
  spec.description  = <<-DESC
  ZRealReq是请求的封装
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
  
  spec.source_files = "Code/ZRealReq/*.{swift}"
  
  spec.dependency 'ZCache/User'
  
  spec.dependency 'WLReqKit'
  
  spec.dependency 'ZUpload'
  
  spec.dependency 'ZReq'
  
  spec.dependency 'ZSign'
end
