//
//  ExtensionUIViewConstraints.swift
//  nhsios
//
//  Created by Amais Sheikh	 on 23/08/2022.
//

import UIKit

//MARK: - Constraints Extensions
extension UIView {
    
    //pinning all
    public func pinToView(_ view: UIView, padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        pinToViewCommon(view: view, padding: padding)
    }
    
    public func pinToSuperview(padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        if let parentView = superview {
            pinToViewCommon(view: parentView, padding: padding)
        }
    }
    
    //horizontal, vertical pins
    public func pinHorizontallyToView(_ view: UIView, padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        pinHorizontallyToViewCommon(view: view, padding: padding)
    }
    
    public func pinHorizontallyToSuperview(padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        if let parentView = superview {
            pinHorizontallyToViewCommon(view: parentView, padding: padding)
        }
    }
    
    public func pinVerticallyToView(_ view: UIView, padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        pinVerticallyToViewCommon(view: view, padding: padding)
    }
    
    public func pinVerticallyToSuperview(padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        if let parentView = superview {
            pinVerticallyToViewCommon(view: parentView, padding: padding)
        }
    }
    
    //centerring constraints
    public func centerToView(view: UIView) {
        centerToViewCommon(view: view)
    }
    
    public func centerToSuperview() {
        if let parentView = superview {
            centerToViewCommon(view: parentView)
        }
    }
    
    public func centerXToSuperview(offset: CGFloat = 0) {
        if let parentView = superview {
            centerXAnchor.constraint(equalTo: parentView.centerXAnchor, constant: offset).isActive = true
        }
    }
    
    public func centerYToSuperview(offset: CGFloat = 0) {
        if let parentView = superview {
            centerYAnchor.constraint(equalTo: parentView.centerYAnchor, constant: offset).isActive = true
        }
    }
    
    //height width constraints
    public func setSize(_ size: CGSize) {
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
    }
}

//private constraints functionality
extension UIView {
    
    private func pinToViewCommon(view: UIView, padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding.right),
            topAnchor.constraint(equalTo: view.topAnchor, constant: padding.top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding.bottom)
        ])
    }
    
    private func pinHorizontallyToViewCommon(view: UIView, padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding.right)
        ])
    }
    
    private func pinVerticallyToViewCommon(view: UIView, padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: padding.left),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding.right)
        ])
    }
    
    private func centerToViewCommon(view: UIView) {
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - Constraint Modifications
extension UIView {
    
    public func setPadding(padding: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8),
                           toInsets: [NSLayoutConstraint.Attribute])
    {
        guard let superview = superview else {
            return
        }
        
        let attributesToModify: [NSLayoutConstraint.Attribute] = [.leading, .trailing, .top, .bottom]
        for constraint in superview.constraints
        {
            guard attributesToModify.contains(constraint.firstAttribute),
                    toInsets.contains(constraint.firstAttribute)
            else {
                continue
            }
                
            if constraint.firstItem === self
            {
                if constraint.firstAttribute == .leading {
                    constraint.constant = padding.left
                } else if constraint.firstAttribute == .top{
                    constraint.constant = padding.top
                }
                else if constraint.firstAttribute == .trailing {
                    constraint.constant = -padding.right
                } else if constraint.firstAttribute == .bottom {
                    constraint.constant = -padding.bottom
                }
            }
        }
        layoutIfNeeded()
    }
    
    public func removeTrailingConstraintWrtSuperview() {
        
        guard let superview = self.superview else {
            return
        }
        
        for constraint in superview.constraints {
            
            if constraint.firstItem === self, constraint.firstAttribute == .trailing {
                constraint.isActive = false
                break
            }
        }
        layoutIfNeeded()
    }
}

//Constraints Customised Way
//extension UIView {
//
//    public enum ConstraintInfo {
//        case leading(NSLayoutXAxisAnchor? = nil, CGFloat = 0)
//        case trailing(NSLayoutXAxisAnchor? = nil, CGFloat = 0)
//        case top(NSLayoutYAxisAnchor? = nil, CGFloat = 0)
//        case bottom(NSLayoutYAxisAnchor? = nil, CGFloat = 0)
//        case fixWidth(CGFloat)
//        case fixHeight(CGFloat)
//        case width(NSLayoutDimension, CGFloat = 1)
//        case height(NSLayoutDimension, CGFloat = 1)
//        case centerX(NSLayoutXAxisAnchor? = nil, CGFloat = 1)
//        case centerY(NSLayoutYAxisAnchor? = nil, CGFloat = 1)
//    }
//
//    public func constraints(_ constraints: [ConstraintInfo]) {
//
//        constraints.forEach { constraint in
//
//            switch constraint {
//
//            case .leading(let anchor, let constant):
//                guard let anchor = anchor ?? superview?.leadingAnchor else { return }
//                leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
//
//            case .trailing(let anchor, let constant):
//                guard let anchor = anchor ?? superview?.trailingAnchor else { return }
//                trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
//
//            case .top(let anchor, let constant):
//                guard let anchor = anchor ?? superview?.topAnchor else { return }
//                topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
//
//            case .bottom(let anchor, let constant):
//                guard let anchor = anchor ?? superview?.bottomAnchor else { return }
//                bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
//
//            case .fixWidth(let width):
//                widthAnchor.constraint(equalToConstant: width).isActive = true
//
//            case .fixHeight(let height):
//                heightAnchor.constraint(equalToConstant: height).isActive = true
//
//            case .width(let dimension, let multiplier):
//                widthAnchor.constraint(equalTo: dimension, multiplier: multiplier).isActive = true
//
//            case .height(let dimension, let multiplier):
//                heightAnchor.constraint(equalTo: dimension, multiplier: multiplier).isActive = true
//
//            case .centerX(let anchor, let constant):
//                guard let anchor = anchor ?? superview?.centerXAnchor else { return }
//                centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
//
//            case .centerY(let anchor, let constant):
//                guard let anchor = anchor ?? superview?.centerYAnchor else { return }
//                centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
//            }
//        }
//    }
//}
