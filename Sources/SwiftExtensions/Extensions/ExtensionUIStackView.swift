//
//  ExtensionUIStackView.swift
//  nhsios
//
//  Created by Amais Sheikh on 22/08/2022.
//

import UIKit

public extension UIStackView
{
    func addAllArrangedSubviews(_ views: UIView ...)
    {
        for view in views
        {
            self.addArrangedSubview(view)
        }
    }
    
    func removeAllArrangedSubviews()
    {
        for view in self.arrangedSubviews
        {
            view.removeFromSuperview()
        }
    }
}
