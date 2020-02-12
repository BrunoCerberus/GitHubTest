//
//  UIColor+Utils.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import UIKit

extension UIColor {
    
    public static let imBackgroundComponent = UIColor(hex6: 0x26272C)
    public static let imNavigationColor = UIColor.black
    public static let imActivityIndicator = UIColor.white
    public static let imNavigationBarTintColor = UIColor.white
    public static let imTitleTextAttributes = UIColor.white
    public static let imActivityIndicatorPullToRefresh = UIColor(hex6: 0x242528)
    public static let imBarButtonItems = UIColor(hex6: 0x64FFDA)
    public static let imUpperView = UIColor(hex6: 0x242528)
    public static let imBottomView = UIColor(hex6: 0x000000)

    // MARK: - Initializer
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(fromHex: Int) {
        self.init(red: (fromHex >> 16) & 0xff, green: (fromHex >> 8) & 0xff, blue: fromHex & 0xff)
    }
    
    convenience init?(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines).remove(["#"])
        guard let hexNumber = UInt32(hexString, radix: 16) else {
            return nil
        }
        self.init(hex6: hexNumber)
    }

    /**
     The six-digit hexadecimal representation of color of the form #RRGGBB.
     
     - parameter hex6: Six-digit hexadecimal value.
     */
    public convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green = CGFloat((hex6 & 0x00FF00) >> 8) / divisor
        let blue = CGFloat(hex6 & 0x0000FF) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
