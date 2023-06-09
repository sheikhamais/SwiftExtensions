//
//  ExtensionUILabel.swift
//  nhsios
//
//  Created by Amais Sheikh	 on 26/08/2022.
//

import Foundation
import UIKit

public extension UILabel {
    
    func setTrailingAsteric(fontSize: CGFloat = 24, yOffset: CGFloat = -6) {
        
        let asteric = UILabel()
        asteric.translatesAutoresizingMaskIntoConstraints = false
        asteric.text = "*"
        asteric.textAlignment = .center
        asteric.textColor = .red
        
        addSubview(asteric)
        
        asteric.setSize(.init(width: 12, height: 12))
        asteric.centerXAnchor.constraint(equalTo: trailingAnchor, constant: 6).isActive = true
        asteric.centerYAnchor.constraint(equalTo: centerYAnchor, constant: yOffset).isActive = true
    }
    
    func transitionChangeText(_ text: String, animationOptions: UIView.AnimationOptions = .transitionCrossDissolve) {
        UIView.transition(with: self, duration: 0.16, options: animationOptions) {
            self.text = text
        }
    }
}
