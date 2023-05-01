//
//  ExtensionUIViewConstraints.swift
//  nhsios
//
//  Created by Amais Sheikh	 on 23/08/2022.
//

import UIKit

//MARK: - Constraints Extensions
public extension UIView {
    
    //pinning all
    func pinToView(_ view: UIView, padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        pinToViewCommon(view: view, padding: padding)
    }
    
    func pinToSuperview(padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        if let parentView = superview {
            pinToViewCommon(view: parentView, padding: padding)
        }
    }
    
    //horizontal, vertical pins
    func pinHorizontallyToView(_ view: UIView, padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        pinHorizontallyToViewCommon(view: view, padding: padding)
    }
    
    func pinHorizontallyToSuperview(padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        if let parentView = superview {
            pinHorizontallyToViewCommon(view: parentView, padding: padding)
        }
    }
    
    func pinVerticallyToView(_ view: UIView, padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        pinVerticallyToViewCommon(view: view, padding: padding)
    }
    
    func pinVerticallyToSuperview(padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        if let parentView = superview {
            pinVerticallyToViewCommon(view: parentView, padding: padding)
        }
    }
    
    //centerring constraints
    func centerToView(view: UIView) {
        centerToViewCommon(view: view)
    }
    
    func centerToSuperview() {
        if let parentView = superview {
            centerToViewCommon(view: parentView)
        }
    }
    
    func centerXToSuperview(offset: CGFloat = 0) {
        if let parentView = superview {
            centerXAnchor.constraint(equalTo: parentView.centerXAnchor, constant: offset).isActive = true
        }
    }
    
    func centerYToSuperview(offset: CGFloat = 0) {
        if let parentView = superview {
            centerYAnchor.constraint(equalTo: parentView.centerYAnchor, constant: offset).isActive = true
        }
    }
    
    //height width constraints
    func setSize(_ size: CGSize) {
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
public extension UIView {
    
    func setPadding(padding: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8),
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
    
    func removeTrailingConstraintWrtSuperview() {
        
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
