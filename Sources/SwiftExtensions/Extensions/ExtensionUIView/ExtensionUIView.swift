//
//  ExtensionUIView.swift
//  nhsios
//
//  Created by Amais Sheikh on 22/08/2022.
//

import UIKit

public extension UIView
{
    var globalFrame: CGRect {
        return self.convert(self.bounds, to: nil)
    }
    
    func addCornerRadiusTo(cornerRadius: CGFloat = 8, corners: CACornerMask)
    {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.layer.maskedCorners = corners
    }
    
    func addAllSubviews(_ views: UIView ...)
    {
        for view in views
        {
            self.addSubview(view)
        }
    }
    
    func addShadowToView(shadowColor: UIColor  = UIColor.black,
                         offset: CGSize         = .zero,
                         shadowRadius: CGFloat = 10,
                         shadowOpacity: Float  = 0.8)
    {
        layer.shadowColor      = shadowColor.cgColor
        layer.shadowOpacity    = shadowOpacity
        layer.shadowOffset     = offset
        layer.shadowRadius     = shadowRadius
   
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    @discardableResult
    func makeViewDull(alpha: CGFloat = 0.3) -> UIView
    {
        let coveringView: UIView =
            {
                let obj = UIView()
                obj.translatesAutoresizingMaskIntoConstraints = false
                obj.backgroundColor = .black
                obj.alpha = alpha
                return obj
            }()
        
        addSubview(coveringView)
        
        NSLayoutConstraint.activate([
            
            coveringView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coveringView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coveringView.topAnchor.constraint(equalTo: topAnchor),
            coveringView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        return coveringView
    }
    
    @discardableResult
    func setScrollView(direction: NSLayoutConstraint.Axis = .vertical,
                       scrollContentContainerView: UIView) -> UIScrollView {
        let scrollView: UIScrollView =
            {
                let obj = UIScrollView()
                obj.translatesAutoresizingMaskIntoConstraints = false
                return obj
            }()
        
        addSubview(scrollView)
        scrollView.addSubview(scrollContentContainerView)
        
        let scrollFrameGuide = scrollView.frameLayoutGuide
        let scrollContentGuide = scrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            scrollContentContainerView.leadingAnchor.constraint(equalTo: scrollContentGuide.leadingAnchor),
            scrollContentContainerView.trailingAnchor.constraint(equalTo: scrollContentGuide.trailingAnchor),
            scrollContentContainerView.topAnchor.constraint(equalTo: scrollContentGuide.topAnchor),
            scrollContentContainerView.bottomAnchor.constraint(equalTo: scrollContentGuide.bottomAnchor)
        ])
        
        if direction == .vertical {
            scrollContentContainerView.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor).isActive = true
            scrollContentContainerView.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor).isActive = true
        } else {
            scrollContentContainerView.topAnchor.constraint(equalTo: scrollFrameGuide.topAnchor).isActive = true
            scrollContentContainerView.bottomAnchor.constraint(equalTo: scrollFrameGuide.bottomAnchor).isActive = true
        }
        
        return scrollView
    }
    
    func animateAlpha(to alpha: CGFloat = 1,
                             duration: TimeInterval = 1,
                             delay: TimeInterval = 0,
                             options: AnimationOptions = .curveEaseInOut,
                             completion: VoidHandler? = nil) {
        
        UIView.animate(withDuration: duration, delay: delay, options: options) {
            self.alpha = alpha
        } completion: { _ in
            completion?()
        }
    }
    
    func makeRepeatingRotations(duration: TimeInterval = 1, delay: TimeInterval = 0, animatingOptions: UIView.AnimationOptions = [.curveEaseInOut], angle: CGFloat = .pi) {
        UIView.animate(withDuration: duration, delay: delay, options: animatingOptions) {
            self.transform = CGAffineTransform(rotationAngle: angle)
        } completion: { _ in
            let newAngle = (angle + .pi).truncatingRemainder(dividingBy: (2 * .pi))
            self.makeRepeatingRotations(angle: newAngle)
        }
    }
    
    func addBorder(color: UIColor = .black, lineWidth: CGFloat = 1) {
        layer.borderColor = color.cgColor
        layer.borderWidth = lineWidth
    }
    
    func addEndEditingGesture()
    {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleViewTap))
        gesture.cancelsTouchesInView = false
        self.addGestureRecognizer(gesture)
    }
    @objc private func handleViewTap() { self.endEditing(true) }
    
    @discardableResult
    func addBottomSeparator(color: UIColor = .darkGray, lineWidth: CGFloat = 1) -> UIView {
        
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = color
        
        addSubview(separatorView)
        separatorView.pinHorizontallyToSuperview()
        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: lineWidth).isActive = true
        return separatorView
    }
}
