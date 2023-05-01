//
//  ExtensionInt.swift
//  nhsios
//
//  Created by Amais Sheikh on 22/08/2022.
//

import UIKit

public extension Int {
    
    var isPositive: Bool {
        return self >= 0
    }
    
    var cgFloatValue: CGFloat {
        return CGFloat(self)
    }
    
    var autoSized: CGFloat {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let diagonalSize = sqrt((screenWidth * screenWidth) + (screenHeight * screenHeight))
        let percentage = CGFloat(self)/1020*100 //1020 is the diagonal size of iphone 12 pro max
        return diagonalSize * percentage / 100
    }
}
