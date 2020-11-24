// 
// Copyright 2020 New Vector Ltd
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

class RoomSettingsViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_197400_removeSharingFunctionality() throws {
        /// Given I am in a Chat Room (that I am a member of)
        /// AND I have selected Room Details
        /// AND I have selected Room Settings
        /// AND I am an Admin or Moderator in the Room
        /// AND I select the Room Avatar to change the Avatar
        /// AND I have permissions to use the device's camera
        /// When the camera is displayed
        /// Then the only options for me - other than changing the camera settings or cancelling - is to take a photo or video.
        /// I must not be able to select existing files/media from my Device to add to the chat.
        /// Note: Remove the menu and take the user straight to the camera.
        /// The remainder of the functionality is OOTB and described in another story.
        
        XCTAssert(BuildSettings.sharingFeaturesEnabled == false)
        
    }
    
    func test_193085_removeRoomSettings() throws {
        /// Given I have selected a Chat Room that I am a Room Member
        /// When I have selected the Chat Room Settings
        /// Then I cannot see the following OOTB Chat Room settings as they are not required
        /// . Addresses
        /// . Flair
        /// . Advanced
        /// . Direct Chat
        /// . Add Matrix Apps

        /// Given I have selected a Chat Room that I am a Room Member
        ///  When I have selected the Chat Room Settings
        /// Then I cannot see or select the Room Access setting and it must always be set to "Only people who have been invited".

        /// Given I have selected a Chat Room that I am a Room Member
        /// AND I have selected the Security & Privacy settings
        /// AND I have permissions to change these settings (i.e. Chat Room Administrator)
        /// When I have selected the Who Can Read History setting
        /// Then I can only select from the following values
        /// . Members only (since the point in time of selecting this option)
        /// . Members only (since they were invited)
        /// . Members only (since they joined)
        /// Note: The following value must be removed "Anyone".
        
        XCTAssert(BuildSettings.roomSettingsScreenShowDirectChatOption == false)
        XCTAssert(BuildSettings.roomSettingsScreenAllowChangingAccessSettings == false)
        XCTAssert(BuildSettings.roomSettingsScreenShowAddressSettings == false)
        XCTAssert(BuildSettings.roomSettingsScreenShowFlairSettings == false)
        XCTAssert(BuildSettings.roomSettingsScreenShowAdvancedSettings == false)
        
    }


}

