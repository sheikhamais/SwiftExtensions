//
//  ExtensionDouble.swift
//  nhsios
//
//  Created by Amais Sheikh on 24/08/2022.
//

import UIKit

public extension Double {
    var cappedZeroToOne: CGFloat {
        return Swift.max(Swift.min(self, 1), 0)
    }
    
    var dynamicSizeValue: Double {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let diagonalSize = sqrt((screenWidth * screenWidth) + (screenHeight * screenHeight))
        let percentage = Double(self)/1020*100 //1020 is the diagonal size of iphone 12 pro max
        return diagonalSize * percentage / 100
    }
}
