# Uncomment this line to define a global platform for your project
platform :ios, '12.0'

# Use frameforks to allow usage of pod written in Swift (like PiwikTracker)
use_frameworks!

# Different flavours of pods to MatrixKit. Can be one of:
# - a String indicating an official MatrixKit released version number
# - `:local` (to use Development Pods)
# - `{'kit branch name' => 'sdk branch name'}` to depend on specific branches of each repo
# - `{ {kit spec hash} => {sdk spec hash}` to depend on specific pod options (:git => …, :podspec => …) for each repo. Used by Fastfile during CI
#
# Warning: our internal tooling depends on the name of this variable name, so be sure not to change it
$matrixKitVersion = '= 0.13.1'
$matrixSDKVersion = '= 0.17.3'

# $matrixKitVersion = :local
$matrixKitVersion = {'master' => 'develop'}

#this allows the xcode project options on individual pods to be modified.
#{'podname' => {'xcodesetting' => 'value', 'setting' => 'value'}} etc
$projectOptions = {'SideMenu' => {'APPLICATION_EXTENSION_API_ONLY' => 'NO'}, 'MatrixKit' => {'IPHONEOS_DEPLOYMENT_TARGET' => '11.0'}}

########################################

case $matrixKitVersion
  when :local
    $matrixKitVersionSpec = { :path => '../matrix-ios-kit/MatrixKit.podspec' }
    $matrixSDKVersionSpec = { :path => '../matrix-ios-sdk/MatrixSDK.podspec' }
  when Hash # kit branch name => sdk branch name – or {kit spec Hash} => {sdk spec Hash}
    kit_spec, sdk_spec = $matrixKitVersion.first # extract first and only key/value pair; key is kit_spec, value is sdk_spec
    kit_spec = { :git => 'https://github.com/fhirfactory/pegacorn-matrix-ios-kit.git', :branch => kit_spec.to_s } unless kit_spec.is_a?(Hash)
    sdk_spec = { :git => 'https://github.com/matrix-org/matrix-ios-sdk.git', :branch => sdk_spec.to_s } unless sdk_spec.is_a?(Hash)
    if $matrixSDKVersion.is_a?(String) then #even if we have a specific branch selected for matrixKitVersion, if we also have a specific MatrixSDKVersion set, we want to override our branch with that SDK Version
      sdk_spec = $matrixSDKVersion
    end
    $matrixKitVersionSpec = kit_spec
    $matrixSDKVersionSpec = sdk_spec
  when String # specific MatrixKit released version
    $matrixKitVersionSpec = $matrixKitVersion
    $matrixSDKVersionSpec = $matrixSDKVersion
end

######################
# Lingo specific note - 07/10/20
# Archiving under Xcode 12 is not correctly handling nested pod installs with the same pods in each definition
# For the time being we need to re-define the pods so that we only have one set included across all targets
# This should be revised with each Xcode 12 refresh
######################

# Method to import the right MatrixKit flavour
#def import_MatrixKit
#  pod 'MatrixSDK', $matrixSDKVersionSpec
#  pod 'MatrixSDK/SwiftSupport', $matrixSDKVersionSpec
#  pod 'MatrixSDK/JingleCallStack', $matrixSDKVersionSpec
#  pod 'MatrixKit', $matrixKitVersionSpec
#end

# Method to import the right MatrixKit/AppExtension flavour
def import_MatrixKitAppExtension
  pod 'MatrixKit', $matrixKitVersionSpec
  pod 'MatrixSDK/JingleCallStack', $matrixSDKVersionSpec
  pod 'MatrixSDK', $matrixSDKVersionSpec
  pod 'MatrixSDK/SwiftSupport', $matrixSDKVersionSpec
  pod 'MatrixKit/AppExtension', $matrixKitVersionSpec
end

########################################

abstract_target 'RiotPods' do

  pod 'GBDeviceInfo', '~> 6.3.0'
  pod 'Reusable', '~> 4.1'
  pod 'KeychainAccess', '~> 4.2'
  pod 'SideMenu'
 

  # Piwik for analytics
  pod 'MatomoTracker', '~> 7.2.0'

  # Remove warnings from "bad" pods
  pod 'OLMKit', :inhibit_warnings => true
  pod 'cmark', :inhibit_warnings => true
  pod 'zxcvbn-ios', :inhibit_warnings => true
  pod 'HPGrowingTextView', :inhibit_warnings => true

  # Tools
  pod 'SwiftGen', '~> 6.4.0'
  pod 'SwiftLint', '~> 0.36.0'
  pod 'Material', '~> 3.1.0'

  target "Riot" do
#    import_MatrixKit
    import_MatrixKitAppExtension
    pod 'DGCollectionViewLeftAlignFlowLayout', '~> 1.0.4'
    pod 'KTCenterFlowLayout', '~> 1.3.1'
    pod 'ZXingObjC', '~> 3.6.5'
    pod 'FlowCommoniOS', '~> 1.8.7'
    pod 'FFDropDownMenu', '~> 1.4'

    target 'RiotTests' do
      inherit! :search_paths
      pod 'FFDropDownMenu', '~> 1.4'
    end
    target 'LingoTests' do
      inherit! :search_paths
      pod 'FFDropDownMenu', '~> 1.4'
    end
  end

  #Commented out as Lingo does not use the sharing extension, and Xcode complains if the target is there, but not included in the project
  #target "RiotShareExtension" do
  #  import_MatrixKitAppExtension
  #end

  target "SiriIntents" do
    import_MatrixKitAppExtension
  end

  target "RiotNSE" do
    import_MatrixKitAppExtension
  end

end


post_install do |installer|
  installer.pods_project.targets.each do |target|

    # Disable bitcode for each pod framework
    # Because the WebRTC pod (included by the JingleCallStack pod) does not support it.
    # Plus the app does not enable it
    #APPLICATION_EXTENSION_API_ONLY
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      if $projectOptions.is_a?(Hash) and $projectOptions.has_key?(String(target)) then
        values = $projectOptions[String(target)]
        values.each do |key, value|
          config.build_settings[key] = value
          print("Set: ")
          print(key)
          print(" to: ")
          print(value)
          print(" for target: ")
          print(target)
          print("\n")
        end
      end
    end
  end
end
