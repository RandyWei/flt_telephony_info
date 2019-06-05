#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flt_telephony_info'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin , get telephony info'
  s.description      = <<-DESC
A new Flutter plugin , get telephony info
                       DESC
  s.homepage         = 'https://www.bughub.dev'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'bughub.dev' => 'smile561607154@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.frameworks = 'CoreTelephony'
  s.ios.deployment_target = '8.0'
end

