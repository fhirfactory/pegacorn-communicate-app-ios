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

class LingoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_195667_selectLingoBrandingTheme() throws {
        /// Given I am an Authenticated User
        /// When I am viewing the navigation bar
        /// Then the OOTB Favourites function is not shown and is removed from the Application.
        
        XCTAssert(BuildSettings.settingsScreenOverrideDefaultThemeSelection == "lingo")
        
    }
    
    func test_196512_displayActualFavouritesUnreadCountInTabBar() throws {
        /// Steps:
        /// Ensure you have at least one chat in the Favourites tab.
        /// Arrange to have an unread message appear that favourited chat.

        /// Expected:
        /// The Favourites chat tab, the chat in the list, and the Chats icon in the bottom navigation bar all reflect the unread message.
        
        XCTAssert(BuildSettings.displayActualFavouritesNotificationCountInTabBar == true)
        
    }
    
    
    

}
