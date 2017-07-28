Pod::Spec.new do |s|
	s.name         = 'TwitterLoginSDK'
    s.version      = '1.0.4'
    s.homepage     = "http://www.lianluo.com/"
    s.license      = { :type => 'MIT', :file => 'LICENSE' }
    s.author       = { "liguangjian" => "liguangjian@lianluo.com" }
    s.summary      = 'Lianluo UserCenter Module..'
    s.platform     =  :ios, '9.0'
    s.source       = { :git => "https://github.com/meliguangjian/ConvenientLogin.git", :tag => s.version.to_s }
    s.frameworks       = 'UIKit', 'JavaScriptCore','SystemConfiguration','CoreTelephony'
    s.libraries        = 'icucore', 'z.1.2.5', 'stdc++'
    s.requires_arc = true
    s.ios.deployment_target = '9.0'
    s.vendored_frameworks = 'ConvenientLogin/Lib/TwitterSDK/TwitterKit.framework', 'ConvenientLogin/Lib/TwitterSDK/TwitterCore.framework'

end
