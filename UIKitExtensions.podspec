Pod::Spec.new do |s|
  s.name             = "UIKitExtensions"
  s.summary          = "A short description of UIKitExtensions."
  s.version          = "0.0.30"
  s.homepage         = "github.com/Strobocop/UIKitExtensions"
  s.license          = 'MIT'
  s.author           = { "Brian Strobach" => "brian@appsaurus.io" }
  s.source           = {
    :git => "https://github.com/appsaurus/UIKitExtensions.git",
    :tag => s.version.to_s
  }
  
  s.social_media_url = 'https://twitter.com/Strobocop'
  
  s.swift_version = '5.0'
  s.requires_arc = true
  
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.2'
  s.watchos.deployment_target = "3.0"

  
  s.ios.source_files = 'Sources/{iOS,Shared}/**/*'
  s.tvos.source_files = 'Sources/{iOS,tvOS,Shared}/**/*'
  s.osx.source_files = 'Sources/{macOS,Shared}/**/*'
  s.watchos.source_files = 'Sources/{watchOS,Shared}/**/*'

  s.frameworks = 'Foundation'
  s.ios.frameworks = 'UIKit'
  s.osx.frameworks = 'AppKit'
  
  s.dependency 'Swiftest'
  s.dependency 'DarkMagic'
end
