//
//  ExtensionUINavigationController.swift
//  nhsios
//
//  Created by Amais Sheikh	 on 26/08/2022.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func popToViewController(ofType type: AnyClass) {
        let viewControllers: [UIViewController] = self.viewControllers.reversed()
        for viewcontroller in viewControllers {
            if viewcontroller.isKind(of: type) {
                self.popToViewController(viewcontroller, animated: true)
                break
            }
        }
    }
}
