source 'https://github.com/CocoaPods/Specs'
platform :ios, '8.0'
inhibit_all_warnings!
use_frameworks!

workspace 'SGTUIKit'
project 'SGTUIKit.xcodeproj'
project 'Demo/Demo.xcodeproj'

target 'SGTUIKit' do
    project 'SGTUIKit.xcodeproj'
    platform :ios, '8.0'
    pod 'ReactiveObjC'
    pod 'Masonry'
    pod 'SDWebImage'
end

target 'Demo' do
    project 'Demo/Demo.xcodeproj'
    platform :ios, '8.0'
    pod 'SGTUIKit', :path => '../SGTUIKit'
end
