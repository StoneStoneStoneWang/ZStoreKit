Pod::Spec.new do |spec|
  
  spec.name         = "ZTextField"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For 地图."
  spec.description  = <<-DESC
  ZTextField是地图
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
  
  spec.subspec 'Setting' do |setting|
    setting.source_files = "Code/ZTextFeild/Setting/*.{swift}"
  end
  spec.subspec 'Base' do |base|
    base.source_files = "Code/ZTextFeild/Base/*.{swift}"
    base.dependency 'WLToolsKit/Then'
    base.dependency 'ZTextField/Setting'
  end
  
  spec.subspec 'LeftTitle' do |leftTitle|
    leftTitle.source_files = "Code/ZTextFeild/LeftTitle/*.{swift}"
    leftTitle.dependency 'ZTextField/Base'
    leftTitle.dependency 'WLToolsKit/Color'
  end
  spec.subspec 'LeftImage' do |leftImage|
    leftImage.source_files = "Code/ZTextFeild/LeftImg/*.{swift}"
    leftImage.dependency 'ZTextField/Base'
  end
  spec.subspec 'NickName' do |nickName|
    nickName.source_files = "Code/ZTextFeild/NickName/*.{swift}"
    nickName.dependency 'ZTextField/Base'
  end
  
  spec.subspec 'Password' do |password|
    password.source_files = "Code/ZTextFeild/Password/*.{swift}"
    password.dependency 'ZTextField/LeftImage'
    password.dependency 'ZTextField/LeftTitle'
  end
  
  spec.subspec 'Vcode' do |vcode|
    vcode.source_files = "Code/ZTextFeild/Vcode/*.{swift}"
    vcode.dependency 'ZTextField/LeftImage'
    vcode.dependency 'ZTextField/LeftTitle'
  end
  
end
