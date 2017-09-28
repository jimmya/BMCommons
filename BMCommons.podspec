#
# Be sure to run `pod lib lint BMCommons.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BMCommons'
  s.version          = '1.44.0'
  s.summary          = 'BehindMedia Commons Library'

  s.description      = <<-DESC
                        BehindMedia Commons Library for iOS
                       DESC

  s.homepage         = 'https://github.com/werner77/BMCommons'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'Werner Altewischer'
  s.source           = { :git => 'https://github.com/werner77/BMCommons.git', :commit => '75416b749398d3f64fb9279cec056cfc2f5bca41' }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.default_subspec = 'BMCore'

  s.subspec 'BMCore' do |s_core|
    s_core.libraries = 'z', 'icucore'
    s_core.requires_arc = true
    s_core.compiler_flags = '-Wno-deprecated-declarations'
    s_core.source_files = 'BMCommons/Modules/BMCore/Sources/**/*.{c,m,h}'
    s_core.exclude_files = 'BMCommons/Modules/BMCore/**/*_Private.*'
    s_core.ios.frameworks   = 'Foundation','UIKit','CoreGraphics','SystemConfiguration','AudioToolbox','Security'
    s_core.osx.frameworks   = 'Foundation','CoreGraphics','SystemConfiguration','AudioToolbox','Security'
  end

  s.subspec 'BMRestKit' do |s_restkit|
    s_restkit.frameworks   = 'CoreData'
    s_restkit.requires_arc = true
    s_restkit.compiler_flags = '-Wno-deprecated-declarations'
    s_restkit.source_files = 'BMCommons/Modules/BMRestKit/Sources/**/*.{c,m,h}'
    s_restkit.exclude_files = 'BMCommons/Modules/BMRestKit/**/*_Private.*'
    s_restkit.dependency 'BMCommons/BMXML'
    s_restkit.dependency 'yajl-objc', '0.3.0'
  end

  s.subspec 'BMXML' do |s_xml|
    s_xml.requires_arc = true
    s_xml.compiler_flags = '-Wno-deprecated-declarations'
    s_xml.source_files = 'BMCommons/Modules/BMXML/Sources/**/*.{c,m,h}'
    s_xml.private_header_files = 'BMCommons/Modules/BMXML/**/Private/*.h'
    s_xml.libraries = 'xml2'
    s_xml.pod_target_xcconfig     = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
    s_xml.dependency 'BMCommons/BMCore'
  end

  # iOS-only modules

  s.subspec 'BMUICore' do |s_uicore|
    s_uicore.platform = :ios
    s_uicore.frameworks   = 'CoreData'
    s_uicore.requires_arc = true
    s_uicore.compiler_flags = '-Wno-deprecated-declarations'
    s_uicore.source_files = 'BMCommons/Modules/BMUICore/Sources/**/*.{c,m,h}'
    s_uicore.exclude_files = 'BMCommons/Modules/BMUICore/**/*_Private.*','BMCommons/Modules/BMUICore/Sources/Classes/BMDialogHelper.{h,m}','BMCommons/Modules/BMUICore/Sources/Classes/UIAlertView+BMCommons.{h,m}','BMCommons/Modules/BMUICore/Sources/Classes/UIActionSheet+BMCommons.{h,m}'
    s_uicore.resource_bundle = { 'BMUICore' => 'BMCommons/Modules/BMUICore/Resources/**/*.*' }
    s_uicore.dependency 'BMCommons/BMCore'
  end

  s.subspec 'BMUIExtensions' do |s_uiext|
    s_uiext.platform = :ios
    s_uiext.requires_arc = true
    s_uiext.compiler_flags = '-Wno-deprecated-declarations'
    s_uiext.source_files = 'BMCommons/Modules/BMUIExtensions/Sources/**/*.{c,m,h}'
    s_uiext.exclude_files = 'BMCommons/Modules/BMUIExtensions/**/*_Private.*','BMCommons/Modules/BMUIExtensions/Sources/Classes/BMAbstractDatePickerCell.{h,m}','BMCommons/Modules/BMUIExtensions/Sources/Classes/BMEnumeratedValueCell.{h,m}','BMCommons/Modules/BMUIExtensions/Sources/Classes/BMMailComposeController.{h,m}','BMCommons/Modules/BMUIExtensions/Sources/Classes/BMMultiPickerCell.{h,m}','BMCommons/Modules/BMUIExtensions/Sources/Classes/BMTimePickerCell.{h,m}','BMCommons/Modules/BMUIExtensions/Sources/Classes/BMValuePickerCell.{h,m}','BMCommons/Modules/BMUIExtensions/Sources/Classes/BMValueSelectionCell.{h,m}','BMCommons/Modules/BMUIExtensions/Sources/Classes/BMAlphabeticListTableViewController.{h,m}','BMCommons/Modules/BMUIExtensions/Sources/Classes/BMTextualAlertView.{h,m}','BMCommons/Modules/BMUIExtensions/Sources/Classes/BMWebDialog.{h,m}'
    s_uiext.dependency 'BMCommons/BMUICore'
  end

end
