// 
// Copyright 2020 Health Directorate
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

import XCTest
@testable import Riot

class RoomViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_192985_viewSourceIsHidden() throws {
        /// Given I am a Room Member
        /// AND I have selected the Room
        /// When have selected a message or file
        /// Then the following OOTB functions are removed/unavailable, including
        ///     View Source (of the selected Message)
        ///     View Decrypted Source (of the selected Message)
        ///     Report Content (of the selected Message)
        ///     Encryption Information (of the selected Message)
        ///     Session Information (of the selected Message)
        
        XCTAssert(BuildSettings.messageDetailsAllowViewSource == false)  // Note this is used to prevent both view source and view decrypted source
        XCTAssert(BuildSettings.messageDetailsAllowReportContent == false)
        XCTAssert(BuildSettings.messageDetailsAllowViewEncryptionInformation == false) // Note this is used to prevent both encryption and session information
        
    }
    
    func test_192346_preventRemovingAdminMessages() throws {
        /// Given I am a Room Administrator or Moderator
        /// When I have the Room Open
        /// AND I have selected a System generated Message from the Room Timeline
        /// Then I am not able to Remove the system generated Message.
        
        XCTAssert(BuildSettings.roomAllowRemoveAdministrativeMessage == false)
        
    }
    
    func test_192990_preventManageIntegrations() throws {
        /// Given I am a Room Member
        /// When I select the Room
        /// Then the following OOTB functions are removed/unavailable, including
        ///     Manage Integrations
        
        XCTAssert(UserDefaults.standard.bool(forKey: "matrixApps") == false)
        
    }
    
    func test_194171_allowRoomRightsMessagesInRooms() throws {
        /// Given I am a Room Member
        /// When I am viewing the Room Timeline
        /// Then I am able to see each change to a Room Member's Rights on the timeline including
        /// . the display name of the user that made the change
        /// . the display name of the user that had their room rights changed
        /// . the change in room rights (from and to)

        /// Given I am a Room Member
        /// When I am viewing the Room Timeline
        /// Then I am able to see the following Room Right changes on the timeline
        /// AND it includes the following room right changes
        /// . Normal rights to Moderator rights
        /// . Normal rights to Administrator rights
        /// . Moderator rights to Administrator rights
        /// . Moderator rights to Normal rights
        /// . Administrator rights to Moderator rights
        /// . Administrator rights to Normal rights
        
        XCTAssert(BuildSettings.messagesAllowViewRoomRightsChanges == true)
        XCTAssert(BuildSettings.messagesMinimumPowerLevelAllowViewRoomRightsChanges == RoomPowerLevel.user.rawValue)
        
    }
    
    func test_197400_removeSharingFunctionality() throws {
        /// Given I am in a Chat Room (that I am a member of)
        /// When I view the composing options
        /// Then the only option to add media to the Chat Room from the Chat Room is 'Take a photo or video'

        /// Notes

        ///     The paperclip menu is to be replaced with a camera icon that triggers the 'Take photo or video' action.
        ///     I am not able to see or select the 'Send File' action anymore.
        
        XCTAssert(BuildSettings.sharingFeaturesEnabled == false)
        XCTAssert(BuildSettings.sharingFeaturesAllowGalleryAvatars == true)
        
    }
    
    func test_197523_preventUserOverrideOfMediaFileSizes() throws {
        /// Given I am an authenticated user
        /// AND I have selected my User Profile
        /// When I select my User Settings
        /// Then I am not able to see the Default Compression setting.

        /// Given I am an authenticated user
        /// When I am taking a photo in the Application
        /// Then the Default Compression setting value = 'Original'.
        
        XCTAssert(BuildSettings.roomInputToolbarCompressionMode == MXKRoomInputToolbarCompressionModeNone)
        
    }
    
    func test_192960_directoryChatInitiation() throws {
        /// If End-to-End encryption is enabled then initiate a direct chat from the Directory tab using E2E encyrption
        /// For Lingo we don't use E2E encryption so we want to disable this option at all times
        
        XCTAssert(BuildSettings.ifE2EEnabledUseE2EInDirectChats == false)
        
    }

}

