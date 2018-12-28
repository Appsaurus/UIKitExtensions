use_frameworks!

def shared
    pod 'Swiftest', :git => 'https://github.com/appsaurus/Swiftest.git'
end

def libaryShared
    pod 'SwiftLint'
end

def testShared
    pod 'SwiftTestUtils', :git => 'https://github.com/appsaurus/SwiftTestUtils.git'
end

target 'UIKitExtensions-iOS' do
    platform :ios, '9.0'
    shared
    libaryShared
end

target 'UIKitExtensions-iOS-Tests' do
    platform :ios, '9.0'
    shared
    testShared
end

target 'UIKitExtensions-macOS' do
    platform :osx, '10.10'
    shared
    libaryShared
end

target 'UIKitExtensions-macOS-Tests' do
    platform :osx, '10.10'
    shared
    testShared
end

target 'UIKitExtensions-tvOS' do
    platform :tvos, '11'
    shared
    libaryShared
end

target 'UIKitExtensions-tvOS-Tests' do
    platform :tvos, '11'
    shared
    testShared
end

target 'UIKitExtensions-watchOS' do
    platform :watchos, '3'
    shared
    libaryShared
end









#target 'UIKitExtensions-watchOS-Tests' do
#    shared
#end
