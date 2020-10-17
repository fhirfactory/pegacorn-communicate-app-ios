// 
// Copyright 2020 Vector Creations Ltd
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation

/// BuildSettings provides settings computed at build time.
/// In future, it may be automatically generated from xcconfig files
@objcMembers
final class BuildSettings: NSObject {
    
    // MARK: - Bundle Settings
    static var bundleDisplayName: String {
        Bundle.app.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    }
    
    static var applicationGroupIdentifier: String {
        Bundle.app.object(forInfoDictionaryKey: "applicationGroupIdentifier") as! String
    }
    
    static var baseBundleIdentifier: String {
        Bundle.app.object(forInfoDictionaryKey: "baseBundleIdentifier") as! String
    }
    
    static var keychainAccessGroup: String {
        Bundle.app.object(forInfoDictionaryKey: "keychainAccessGroup") as! String
    }
    
    static var pushKitAppIdProd: String {
        return baseBundleIdentifier + ".ios.voip.prod"
    }
    
    static var pushKitAppIdDev: String {
        return baseBundleIdentifier + ".ios.voip.dev"
    }
    
    static var pusherAppIdProd: String {
        return baseBundleIdentifier + ".ios.prod"
    }
    
    static var pusherAppIdDev: String {
        return baseBundleIdentifier + ".ios.dev"
    }
    
    static var pushKitAppId: String {
        #if DEBUG
        return pushKitAppIdDev
        #else
        return pushKitAppIdProd
        #endif
    }
    
    static var pusherAppId: String {
        #if DEBUG
        return pusherAppIdDev
        #else
        return pusherAppIdProd
        #endif
    }
    
    // Element-Web instance for the app
    static let applicationWebAppUrlString = "https://app.element.io"
    
    
    // MARK: - Server configuration
    
    // Default servers proposed on the authentication screen
    static let serverConfigDefaultHomeserverUrlString = "https://matrix.org"
    static let serverConfigDefaultIdentityServerUrlString = "https://vector.im"
    
    static let serverConfigSygnalAPIUrlString = "https://matrix.org/_matrix/push/v1/notify"
    
    
    // MARK: - Legal URLs
    static let applicationCopyrightUrlString = "https://element.io/copyright"
    static let applicationPrivacyPolicyUrlString = "https://element.io/privacy"
    static let applicationAcknowledgementUrlString = "https://element.io/privacy"
    static let applicationTermsConditionsUrlString = "https://element.io/terms-of-service"
    
    
    // MARk: - Matrix permalinks
    // Paths for URLs that will considered as Matrix permalinks. Those permalinks are opened within the app
    static let matrixPermalinkPaths: [String: [String]] = [
        "app.element.io": [],
        "staging.element.io": [],
        "develop.element.io": [],
        "mobile.element.io": [""],
        // Historical ones
        "riot.im": ["/app", "/staging", "/develop"],
        "www.riot.im": ["/app", "/staging", "/develop"],
        "vector.im": ["/app", "/staging", "/develop"],
        "www.vector.im": ["/app", "/staging", "/develop"],
        // Official Matrix ones
        "matrix.to": ["/"],
        "www.matrix.to": ["/"],
    ]
    
    
    // MARK: - VoIP
    static var allowVoIPUsage: Bool {
        #if canImport(JitsiMeet)
        return true
        #else
        return false
        #endif
    }
    static let stunServerFallbackUrlString: String? = "stun:turn.matrix.org"
    
    
    // MARK: -  Public rooms Directory
    static let publicRoomsShowDirectory: Bool = true
    static let publicRoomsAllowServerChange: Bool = true
    // List of homeservers for the public rooms directory
    static let publicRoomsDirectoryServers = [
        "matrix.org"
    ]
    
    
    // MARK: - Analytics
    static let analyticsServerUrl = URL(string: "https://piwik.riot.im/piwik.php")
    static let analyticsAppId = "14"
    
    
    // MARK: - Bug report
    static let bugReportEndpointUrlString = "https://riot.im/bugreports"
    // Use the name allocated by the bug report server
    static let bugReportApplicationId = "riot-ios"
    
    
    // MARK: - Integrations
    static let integrationsUiUrlString = "https://scalar.vector.im/"
    static let integrationsRestApiUrlString = "https://scalar.vector.im/api"
    // Widgets in those paths require a scalar token
    static let integrationsScalarWidgetsPaths = [
        "https://scalar.vector.im/_matrix/integrations/v1",
        "https://scalar.vector.im/api",
        "https://scalar-staging.vector.im/_matrix/integrations/v1",
        "https://scalar-staging.vector.im/api",
        "https://scalar-staging.riot.im/scalar/api",
    ]
    // Jitsi server used outside integrations to create conference calls from the call button in the timeline
    static let jitsiServerUrl = NSURL(string: "https://jitsi.riot.im")

    
    // MARK: - Features
    
    /// Setting to force protection by pin code
    static let forcePinProtection: Bool = false
    
    /// Max allowed time to continue using the app without prompting PIN
    static let pinCodeGraceTimeInSeconds: TimeInterval = 0
    
    /// Force non-jailbroken app usage
    static let forceNonJailbrokenUsage: Bool = true
    
    static let allowSendingStickers: Bool = false //the integrations menu can be disabled from the Riot-Defaults plist, under: matrixApps
    
    static let allowLocalContactsAccess: Bool = false
    
    // MARK: - Feature Specifics
    
    /// Not allowed pin codes. User won't be able to select one of the pin in the list.
    static let notAllowedPINs: [String] = []
    
    // MARK: - General Settings Screen Toggles
    /// Booleans that hide or show different elements on the Settings screen
    
    static let settingsScreenAllowUserSignOut: Bool = false
    static let settingsScreenShowUserFirstName: Bool = false
    static let settingsScreenShowUserSurname: Bool = false
    static let settingsScreenAllowAddingEmailThreepids: Bool = false
    static let settingsScreenAllowAddingPhoneThreepids: Bool = false
    static let settingsScreenAllowChangingPassword: Bool = false
    static let settingsScreenAllowChangingProfilePicture: Bool = true
    static let settingsScreenAllowChangingdisplayName: Bool = false
    static let settingsScreenShowThreepidExplanatory: Bool = false
    static let settingsScreenShowDiscoverySettings: Bool = false
    static let settingsScreenAllowIdentityServerConfig: Bool = true
    static let settingsScreenAllowSelectingIdentityServer: Bool = false
    static let settingsScreenShowAdvancedSettings: Bool = true
    static let settingsScreenShowLabSettings: Bool = false
    static let settingsScreenShowIntegrationSettings: Bool = false
    static let settingsScreenShowCallsSettings: Bool = false
    static let settingsScreenShowNotificationDecryptedContentSettings: Bool = false
    static let settingsScreenAllowChangingRageshakeSettings: Bool = false
    static let settingsScreenAllowChangingCrashUsageDataSettings: Bool = false
    static let settingsScreenAllowBugReportingManually: Bool = false
    static let settingsScreenAllowDeactivatingAccount: Bool = false
    static let settingsScreenShowUserInterfaceSettings: Bool = false
    static let settingsScreenShowOLMVersion: Bool = false
    static let settingsScreenShowCopyRight: Bool = false
    static let settingsScreenAllowClearingCacheSettings: Bool = false
    static let settingsScreenAllowMarkAllAsRead: Bool = false
    static let settingsScreenShowThirdPartNotice: Bool = false
    static let settingsScreenShowAcknowledgement: Bool = true
    static let settingsScreenShowPinWithMissed = false // to set the default for this setting, change the appropriate row in Riot-Defaults.plist
    static let settingsEnforceSpecificLanguage : Bool = true
    static let settingsDefaultLanguage : String = "en"

    
    // MARK: - General Settings Defaults Overrides
    /// Override values that are used to control the value of settings that are hidden from users
    
    /// Leave this as an empty string value to allow user theme selection
    static let settingsScreenOverrideDefaultThemeSelection : NSString = "lingo"
    
    // MARK: - Room Settings Screen
    
    static let roomSettingsScreenShowLowPriorityOption: Bool = true
    static let roomSettingsScreenShowDirectChatOption: Bool = false
    static let roomSettingsScreenAllowChangingAccessSettings: Bool = true
    static let roomSettingsScreenAllowChangingHistorySettings: Bool = true
    static let roomSettingsScreenShowAddressSettings: Bool = false
    static let roomSettingsScreenShowFlairSettings: Bool = false
    static let roomSettingsScreenShowAdvancedSettings: Bool = false
    
    // MARK: - Room Participants
    static let roomParticipantAllowBan : Bool = false
    static let roomParticipantShowSecurity : Bool = false
    static let roomParticipantShowVoipCallByDefault : Bool = true
    static let roomParticipantAllowHideAll : Bool = false
    
    // MARK: - Message
    static let messageDetailsAllowShare: Bool = true
    static let messageDetailsAllowPermalink: Bool = true
    static let messageDetailsAllowViewSource: Bool = false
    static let messageDetailsAllowSave: Bool = true
    static let messageDetailsAllowViewEncryptionInformation : Bool = false
    static let messageDetailsAllowReportContent : Bool = false
    
    // MARK: - HTTP
    /// Additional HTTP headers will be sent by all requests. Not recommended to use request-specific headers, like `Authorization`.
    /// Empty dictionary by default.
    static let httpAdditionalHeaders: [String: String] = [:]
    
    //MARK: - Room Actions
    static let roomAllowRemoveAdministrativeMessage = false
    
    
    // MARK: - Authentication Screen
    static let authScreenShowRegister: Bool = true
    static let authScreenShowPhoneNumber: Bool = true
    static let authScreenShowPhoneNumberCountryCode: Bool = false
    static let authScreenShowForgotPassword: Bool = true
    static let authScreenShowCustomServerOptions: Bool = true
    static let authScreenAllowCustomAuthenticationServers: Bool = false
    
    /// Value to customise the image logo at the top of the authenticaiton screen
    static let authScreenImageLogoName: String = "lingo_logo_dark"
    
    // MARK: - Home Screen
    static let homeScreenShowFavourites : Bool = false
    
    // MARK: - Theme Application Settings
    /// Additional toggles that determine if theme customisations should apply to particular elements of the application
    static let themeAppliesToLoginPageLogo: Bool = false
    
}
