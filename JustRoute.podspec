
Pod::Spec.new do |s|
    
    SRC_ROOT = 'JustRoute/JustRoute/'
    SPEC_BASE_ROOT = SRC_ROOT + 'Base/'
    SPEC_VIEW_CONTROLLER_ROOT = SRC_ROOT + 'ViewController/'
    SPEC_NAVIGATION_ROOT =  SPEC_VIEW_CONTROLLER_ROOT + 'Navigation/'
    SPEC_PRESENTATION_ROOT =  SPEC_VIEW_CONTROLLER_ROOT + 'Presentation/'
    SPEC_WINDOW_ROOT =  SRC_ROOT + 'Window/'
    
    s.name             = 'JustRoute'
    s.version          = '0.0.1'
    s.summary          = 'iOS ViewController routing lib'
    s.homepage         = 'https://github.com/sdkdimon/JustRoute'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Dmitry Lizin' => 'sdkdimon@gmail.com' }
    s.source           = { :git => 'https://github.com/sdkdimon/JustRoute.git', :tag => s.version  }

    s.platform     = :ios, '7.0'
    s.ios.deployment_target = '7.0'
    s.requires_arc = true
    s.module_name = 'JustRoute'
    s.default_subspec = 'Base'
  
    s.subspec 'Base' do |ss|
        ss.source_files =  SPEC_BASE_ROOT + '*.{h,m}'
        ss.public_header_files = SPEC_BASE_ROOT + '*.h'
    end
  
    s.subspec 'ViewController' do |view_controller|
        view_controller.subspec 'Navigation' do |navigation|
            navigation.dependency 'JustRoute/Base'
            navigation.source_files = SPEC_NAVIGATION_ROOT + '*.{h,m}', SPEC_VIEW_CONTROLLER_ROOT + '*.{h,m}'
            navigation.public_header_files = SPEC_NAVIGATION_ROOT + '*.h', SPEC_VIEW_CONTROLLER_ROOT + '*.h'
        end

        view_controller.subspec 'Presentation' do |presentation|
            presentation.dependency 'JustRoute/Base'
            presentation.source_files = SPEC_PRESENTATION_ROOT + '*.{h,m}', SPEC_VIEW_CONTROLLER_ROOT + '*.{h,m}'
            presentation.public_header_files = SPEC_PRESENTATION_ROOT + '*.h', SPEC_VIEW_CONTROLLER_ROOT + '*.h'
        end
    end
    
    s.subspec 'Window' do |window|
        window.dependency 'JustRoute/Base'
        window.source_files = SPEC_WINDOW_ROOT + '*.{h,m}'
        window.public_header_files = SPEC_WINDOW_ROOT + '*.h'
    end    
end
