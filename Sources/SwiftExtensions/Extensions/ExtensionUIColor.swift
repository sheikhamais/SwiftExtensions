//
//  ExtensionUIColor.swift
//  nhsios
//
//  Created by Amais Sheikh on 22/08/2022.
//

import UIKit

public extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (0, 0, 0, 0)
        }

        self.init(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, alpha: Double(a) / 255)
    }
}

////MARK: - App wide used colors
//extension UIColor {
//
//    @nonobjc class var nhsThemeBlue: UIColor {
//        return UIColor(hex: "#005EB8")
//    }
//
//    @nonobjc class var nhsLightSkyBlue: UIColor {
//        return UIColor(hex: "#e9f4ff")
//    }
//
//    @nonobjc class var nhsBluePurpleBackground: UIColor {
//        return UIColor(hex: "#AFBDD7")
//    }
//
//    @nonobjc class var nhsDarkGray: UIColor {
//        return UIColor(hex: "#696969")
//    }
//
//    @nonobjc class var nhsLightGray: UIColor {
//        return UIColor(hex: "#E0E0E0")
//    }
//
//    @nonobjc class var nhsLightGray2: UIColor {
//        return UIColor(hex: "#F5F5F5")
//    }
//
//    @nonobjc class var nhsLightGray3: UIColor {
//        return UIColor(hex: "#8E8E93")
//    }
//
//    @nonobjc class var nhsLightGray4: UIColor {
//        return UIColor(hex: "#EDEDED")
//    }
//
//    @nonobjc class var nhsGray5: UIColor {
//        return UIColor(hex: "#B8B8B8")
//    }
//
//    @nonobjc class var nhsGray6: UIColor {
//        return UIColor(hex: "#3E3E44")
//    }
//
//    @nonobjc class var nhsLightBackgroundGray: UIColor {
//        return UIColor(hex: "#F9F9F9")
//    }
//
//    @nonobjc class var textGray: UIColor {
//        return UIColor(hex: "#565656")
//    }
//
//    @nonobjc class var nhsRed: UIColor {
//        return UIColor(hex: "#C71111")
//    }
//}
