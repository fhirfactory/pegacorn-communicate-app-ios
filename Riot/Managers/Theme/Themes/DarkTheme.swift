/*
 Copyright 2018 New Vector Ltd

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import Foundation
import UIKit

/// Color constants for the dark theme
@objcMembers
class DarkTheme: NSObject, Theme {
    
    var identifier: String = "dark"

    var backgroundColor: UIColor = UIColor(rgbHex: 0x15191E)

    var baseColor: UIColor = UIColor(rgbHex: 0x21262C)
    var baseIconPrimaryColor: UIColor = UIColor(rgbHex: 0xEDF3FF)
    var baseTextPrimaryColor: UIColor = UIColor(rgbHex: 0xFFFFFF)
    var baseTextSecondaryColor: UIColor = UIColor(rgbHex: 0xA9B2BC)

    var searchBackgroundColor: UIColor = UIColor(rgbHex: 0x15191E)
    var searchPlaceholderColor: UIColor = UIColor(rgbHex: 0xA9B2BC)

    var headerBackgroundColor: UIColor = UIColor(rgbHex: 0x21262C)
    var headerBorderColor: UIColor  = UIColor(rgbHex: 0x15191E)
    var headerTextPrimaryColor: UIColor = UIColor(rgbHex: 0xFFFFFF)
    var headerTextSecondaryColor: UIColor = UIColor(rgbHex: 0xA9B2BC)

    var textPrimaryColor: UIColor = UIColor(rgbHex: 0xFFFFFF)
    var textSecondaryColor: UIColor = UIColor(rgbHex: 0xA9B2BC)

    var tintColor: UIColor = UIColor(displayP3Red: 0.05098039216, green: 0.7450980392, blue: 0.5450980392, alpha: 1.0)
    var tintBackgroundColor: UIColor = UIColor(rgbHex: 0x1F6954)
    var tabBarUnselectedItemTintColor: UIColor = UIColor(rgbHex: 0x8E99A4)
    var unreadRoomIndentColor: UIColor = UIColor(rgbHex: 0x2E3648)
    var lineBreakColor: UIColor = UIColor(rgbHex: 0x363D49)
    
    var noticeColor: UIColor = UIColor(rgbHex: 0xFF4B55)
    var noticeSecondaryColor: UIColor = UIColor(rgbHex: 0x61708B)

    var warningColor: UIColor = UIColor(rgbHex: 0xFF4B55)

    var avatarColors: [UIColor] = [
        UIColor(rgbHex: 0x03B381),
        UIColor(rgbHex: 0x368BD6),
        UIColor(rgbHex: 0xAC3BA8)]
    
    var userNameColors: [UIColor] = [
        UIColor(rgbHex: 0x368BD6),
        UIColor(rgbHex: 0xAC3BA8),
        UIColor(rgbHex: 0x03B381),
        UIColor(rgbHex: 0xE64F7A),
        UIColor(rgbHex: 0xFF812D),
        UIColor(rgbHex: 0x2DC2C5),
        UIColor(rgbHex: 0x5C56F5),
        UIColor(rgbHex: 0x74D12C)
    ]

    var statusBarStyle: UIStatusBarStyle = .lightContent
    var scrollBarStyle: UIScrollView.IndicatorStyle = .white
    var keyboardAppearance: UIKeyboardAppearance = .dark

    var placeholderTextColor: UIColor = UIColor(rgbHex: 0xA1B2D1) // Use secondary text color
    var selectedBackgroundColor: UIColor = UIColor(rgbHex: 0x040506)
    var overlayBackgroundColor: UIColor = UIColor(white: 0.7, alpha: 0.5)
    var matrixSearchBackgroundImageTintColor: UIColor = UIColor(rgbHex: 0x7E7E7E)
    
    func applyStyle(onTabBar tabBar: UITabBar) {
        tabBar.unselectedItemTintColor = self.tabBarUnselectedItemTintColor
        tabBar.tintColor = self.tintColor
        tabBar.barTintColor = self.baseColor
        tabBar.isTranslucent = false
    }
    
    // Note: We are not using UINavigationBarAppearance on iOS 13+ atm because of UINavigationBar directly include UISearchBar on their titleView that cause crop issues with UINavigationController pop.
    func applyStyle(onNavigationBar navigationBar: UINavigationBar) {
        navigationBar.tintColor = self.tintColor
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: self.textPrimaryColor
        ]
        navigationBar.barTintColor = self.baseColor
        navigationBar.shadowImage = UIImage() // Remove bottom shadow

        // The navigation bar needs to be opaque so that its background color is the expected one
        navigationBar.isTranslucent = false
    }
    
    func applyStyle(onSearchBar searchBar: UISearchBar) {
        searchBar.searchBarStyle = .default
        searchBar.barStyle = .black
        searchBar.barTintColor = self.baseColor
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage() // Remove top and bottom shadow        
        searchBar.tintColor = self.tintColor
        
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = self.searchBackgroundColor
            searchBar.searchTextField.textColor = self.searchPlaceholderColor
        } else {
            if let searchBarTextField = searchBar.vc_searchTextField {
                searchBarTextField.textColor = self.searchPlaceholderColor
            }
        }
    }
    
    func applyStyle(onTextField texField: UITextField) {
        texField.textColor = self.textPrimaryColor
        texField.tintColor = self.tintColor
    }
    
    func applyStyle(onButton button: UIButton) {
        // NOTE: Tint color does nothing by default on button type `UIButtonType.custom`
        button.tintColor = self.tintColor
        button.setTitleColor(self.tintColor, for: .normal)
    }
}
