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

class AuthenticationViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_195667_loginLogoDisplaysCorrectly() throws {
        /// Given I have started the Lingo Application
        /// When the application displays the Splash screen
        /// Then the application displays the approved Lingo logo.
        
        XCTAssert(BuildSettings.themeAppliesToLoginPageLogo == false)
        XCTAssert(BuildSettings.authScreenImageLogoName == "lingo_logo_dark")
        
    }
    
    func test_195339_loginLogoDisplaysCorrectly() throws {
        /// Steps to Reproduce:
        /// Login to Lingo Application on iOS device
        /// Navigate to a User settings
        /// Verify the 'Sign Out' option

        /// Expected Result:
        /// Logged in users have functionality to sign out of the application for BYOD users.
        
        XCTAssert(BuildSettings.settingsScreenAllowUserSignOut == true)
        
    }

}
