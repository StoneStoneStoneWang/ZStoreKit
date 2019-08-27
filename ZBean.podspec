
Pod::Spec.new do |spec|
  
  spec.name         = "ZBean"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For Bean."
  spec.description  = <<-DESC
  ZBean是所有模型的封装
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
  
  spec.dependency 'ObjectMapper'
  spec.dependency 'RxDataSources'
  
  spec.subspec 'Gender' do |gender|
    gender.source_files = "Code/ZBean/Gender/*.{swift}"
  end
  
  spec.subspec 'Account' do |account|
    account.source_files = "Code/ZBean/Account/*.{swift}"
    account.dependency 'ZBean/Gender'
  end
  
  spec.subspec 'User' do |user|
    user.source_files = "Code/ZBean/User/*.{swift}"
    user.dependency 'ZBean/Gender'
  end
  spec.subspec 'Black' do |black|
    black.source_files = "Code/ZBean/Black/*.{swift}"
    
  end
  spec.subspec 'Focus' do |focus|
    focus.source_files = "Code/ZBean/Focus/*.{swift}"
  end
  
  spec.subspec 'KeyValue' do |keyValue|
    keyValue.source_files = "Code/ZBean/KeyValue/*.{swift}"
  end
  
  spec.subspec 'Circle' do |circle|
    circle.source_files = "Code/ZBean/Circle/*.{swift}"
    circle.dependency 'ZBean/KeyValue'
    circle.dependency 'WLToolsKit/JsonCast'
  end
  spec.subspec 'Commodity' do |commodity|
    commodity.source_files = "Code/ZBean/Commodity/*.{swift}"
    commodity.dependency 'ZBean/KeyValue'
    commodity.dependency 'WLToolsKit/JsonCast'
  end
  
  spec.subspec 'Area' do |area|
    area.source_files = "Code/ZBean/Area/*.{swift}"
  end
  
  spec.subspec 'Address' do |address|
    address.source_files = "Code/ZBean/Address/*.{swift}"
  end
  
end
