# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ProStudio' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
	pod 'IQKeyboardManagerSwift'
	pod 'SwiftyJSON'
	pod 'Firebase'
	pod 'Firebase/Core'
	pod 'Firebase/AdMob'
  	pod 'Hero'
	pod 'Firebase/Analytics'
	pod 'Firebase/Auth'
	pod 'Firebase/Crash'
	pod 'Firebase/Database'
	pod 'Firebase/DynamicLinks'
	pod 'Firebase/Invites'
        pod 'Alamofire'
        pod 'AlamofireImage'
	pod 'Firebase/Messaging'
	pod 'Firebase/Performance'
	pod 'Firebase/RemoteConfig'
        pod 'GoogleSignIn'
	pod 'Firebase/Storage'
        pod 'Shift'
	pod 'ImagePicker'
        pod 'Fabric'
        pod 'Crashlytics'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
        end
    end
end