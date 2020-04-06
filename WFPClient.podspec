#
# Be sure to run `pod lib lint ActionCableSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name          = 'WFPClient'
  s.module_name   = 'WFPClient'
  s.version       = '0.2.2'
  s.summary       = 'WayForPay Swift Client for Apple Pay.'
  s.swift_version = '5.1'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Swift Client for payment gateway WayForPay. Implemented Apple Pay API.'
  s.homepage         = 'https://github.com/nerzh/WayForPay-Swift-Client'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Oleh Hudeichuk' => 'emptystamp@gmail.com' }
  s.source           = { :git => 'https://github.com/nerzh/WayForPay-Swift-Client.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.linkedin.com/in/oleh-gudeychuk-428389ab'
  s.ios.deployment_target = '11.0'
  s.source_files = 'Sources/**/*'
  s.frameworks = 'Foundation'
  s.dependency 'SwiftExtensionsPack', '~> 0.3.0'
end
