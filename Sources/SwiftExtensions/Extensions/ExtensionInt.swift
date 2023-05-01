//
//  ExtensionInt.swift
//  nhsios
//
//  Created by Amais Sheikh on 22/08/2022.
//

import Foundation

public extension Int {
    
    var isPositive: Bool {
        return self >= 0
    }
    
    var cgFloatValue: CGFloat {
        return CGFloat(self)
    }
    
    var autoSized: Double {
        return Double(self).dynamicSizeValue
    }
}
