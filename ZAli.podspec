
Pod::Spec.new do |spec|
  
  spec.name         = "ZAli"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For 阿里封装."
  spec.description  = <<-DESC
  ZAli一个阿里的封装
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
  
  spec.subspec 'OSS' do |oss|
    oss.vendored_frameworks = 'ZAli/OSS/ZOSS.framework'
    oss.dependency 'AliyunOSSiOS'
  end
  
end


