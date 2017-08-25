Pod::Spec.new do |s|
  s.requires_arc = true
  s.name = 'FitpaySDKCardIO'
  s.version = '0.2'
  s.license = 'MIT'
  s.summary = 'Swift based library for the Fitpay Platform with card.io scanner'
  s.homepage = 'https://github.com/fitpay/fitpay-ios-sdk'
  s.authors = { 'Fit Pay, Inc' => 'sdk@fit-pay.com' }
  s.source = { :git => 'https://github.com/fitpay/fitpay-card.io.git', :tag => 'v0.2' }

  s.dependency 'FitpaySDK', '>= 0.4.14'

  s.ios.deployment_target = '9.0'
  s.source_files          = "FitpaySDKCardIO/**/*.{swift,h}"
  s.frameworks            = 'Accelerate', 'AVFoundation', 'AudioToolbox', 'CoreMedia', 'CoreVideo', 'MobileCoreServices', 'OpenGLES', 'QuartzCore', 'Security', 'UIKit'
  s.libraries             = 'c++'
  s.vendored_libraries    = 'FitpaySDKCardIO/CardIO/libCardIO.a', 'FitpaySDKCardIO/CardIO/libopencv_core.a', 'FitpaySDKCardIO/CardIO/libopencv_imgproc.a'

  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }

end
