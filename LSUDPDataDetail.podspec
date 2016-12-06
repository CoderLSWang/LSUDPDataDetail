#
#  Be sure to run `pod spec lint LSUDPDataDetail.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

    s.name         = "LSUDPDataDetail"
    s.version      = "0.0.2"
    s.summary      = "A framework that use one line of code to solve hex or decimal multifarious data transformation problem"
    s.homepage     = "https://github.com/CoderLSWang/LSUDPDataDetail"
    s.license      = "MIT"
    s.author       = { "CoderLSWang" => "709926980@qq.com" }
    s.platform     = :ios
    s.ios.deployment_target = "7.0"
    s.source       = { :git => "https://github.com/CoderLSWang/LSUDPDataDetail.git", :tag => "0.0.2" }
    s.source_files  = "LSUDPDataDetail/LSUDPDataDetail/**/*.{h,m}"
    s.requires_arc = true


end
