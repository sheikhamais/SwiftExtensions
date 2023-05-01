//
//  ExtensionCGFloat.swift
//  nhsios
//
//  Created by Amais Sheikh	 on 23/08/2022.
//

import Foundation

public extension CGFloat {
    
    var cappedZeroToOne: CGFloat {
        return Swift.max(Swift.min(self, 1), 0)
    }
    
    var dynamicSized: Double {
        return Double(self).dynamicSizeValue
    }
}
