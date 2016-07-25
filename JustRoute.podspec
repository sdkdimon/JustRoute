
Pod::Spec.new do |s|
  s.name             = "JustRoute"
  s.version          = "0.0.1"
  s.summary          = "iOS ViewController routing lib"
  s.homepage         = "https://github.com/sdkdimon/JustRoute"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Dmitry Lizin" => "sdkdimon@gmail.com" }
  s.source           = { :git => "https://github.com/sdkdimon/JustRoute.git", :tag => s.version }

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.requires_arc = true
  s.module_name = 'JustRoute'
  s.source_files = 'JustRoute/JustRoute/*.{h,m}'
  s.public_header_files = 'JustRoute/JustRoute/*.h'

end
