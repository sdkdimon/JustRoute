
Pod::Spec.new do |s|
  s.name             = "JustRoute"
  s.version          = "0.0.1"
  s.summary          = "iOS ViewController routing lib"
  s.homepage         = "https://github.com/sdkdimon/JustRoute"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Dmitry Lizin" => "sdkdimon@gmail.com" }
  s.source           = { :git => "https://github.com/sdkdimon/JustRoute.git", :branch => 'dev' }

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.requires_arc = true
  s.module_name = 'JustRoute'
  s.source_files = 'JustRoute/JustRoute/*.{h,m}'
  s.public_header_files = 'JustRoute/JustRoute/*.h'
  s.default_subspecs = 'Navigation', 'Presentation', 'Window'
  
  s.subspec 'Navigation' do |navigation|
    navigation.source_files = 'JustRoute/JustRoute/Navigation/*.{h,m}'
    navigation.public_header_files = 'JustRoute/JustRoute/Navigation/*.h'
  end
  
  s.subspec 'Presentation' do |presentation|
    presentation.source_files = 'JustRoute/JustRoute/Presentation/*.{h,m}'
    presentation.public_header_files = 'JustRoute/JustRoute/Presentation/*.h'
  end
  
  s.subspec 'Window' do |window|
    window.source_files = 'JustRoute/JustRoute/Window/*.{h,m}'
    window.public_header_files = 'JustRoute/JustRoute/Window/*.h'
  end
  
end
