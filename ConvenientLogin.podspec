Pod::Spec.new do |s|
	s.name         = 'ConvenientLogin'
    s.version      = '1.0.0'
    s.homepage     = "http://www.lianluo.com/"
    s.license      = { :type => 'MIT', :file => 'LICENSE' }
    s.author       = { "liguangjian" => "liguangjian@lianluo.com" }
    s.summary      = 'Lianluo UserCenter Module..'
    s.platform     =  :ios, '8.0'
    s.source       = { :git => "https://github.com/meliguangjian/ConvenientLogin.git", :tag => s.version.to_s }
    s.frameworks       = 'UIKit', 'JavaScriptCore','SystemConfiguration','CoreTelephony'
    s.libraries        = 'icucore', 'z.1.2.5', 'stdc++'
    s.requires_arc = true
    s.ios.deployment_target = '8.0'
    s.source_files  = ["ConvenientLogin/Classes/**"]

    s.default_subspecs = 'Tools', 'Network', 'ThirdParty'      #默认模块如果不写则为所有

    s.subspec 'Tools' do |tools|
        tools.source_files = 'ConvenientLogin/Classes/Tools/**.{h,m}'
        tools.dependency 'MBProgressHUD', '~> 0.9.1'
    end

    s.subspec 'Network' do |network|
        network.source_files = 'ConvenientLogin/Classes/Network/**.{h,m}'
        network.dependency 'ConvenientLogin/Tools'
        network.dependency 'Reachability'
    end

    s.subspec 'ThirdParty' do |thirdParty|
        thirdParty.source_files = 'ConvenientLogin/Classes/ThirdParty/**.{h,m}'
        thirdParty.frameworks = 'UIKit'
        thirdParty.dependency 'ConvenientLogin/Tools'
        thirdParty.dependency 'ConvenientLogin/Network'
    end

    s.subspec 'Connection' do |sp|
        # 腾讯QQ
        #sp.subspec 'QQ' do |ssp|
         #   ssp.vendored_frameworks = 'ConvenientLogin/Lib/TencentOpenApiSDK/Basic/TencentOpenAPI.framework'
        #    ssp.libraries = 'sqlite3'
        #end
        # WeChatSDK
        sp.subspec 'WeChatSDK' do |ssp|
            ssp.vendored_libraries = "ConvenientLogin/Lib/WeChatSDK/*.a"
            ssp.source_files = "ConvenientLogin/Lib/WeChatSDK/*.h"
            ssp.libraries = 'sqlite3'
        end
    end
end
