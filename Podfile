# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'Days 2.1' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Days 2.1
  pod 'DynamicColor', '~> 5.0.0'
  pod 'RealmSwift'

end

post_install do |installer|
  installer.pods_project.targets.each do |t|
    t.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.5'
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end
end
