//
//  ExtensionUIView.swift
//  nhsios
//
//  Created by Amais Sheikh on 22/08/2022.
//

import UIKit

extension UIView
{
    // MARK: - Section Name
    var globalFrame: CGRect {
        return self.convert(self.bounds, to: nil)
    }
    
    // MARK: - Section Name
    func addCornerRadius(_ radius: CGFloat = 8.0)
    { self.layer.cornerRadius = radius }
    
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
    
    public func makeRepeatingRotations(duration: TimeInterval = 1, delay: TimeInterval = 0, animatingOptions: UIView.AnimationOptions = [.curveEaseInOut], angle: CGFloat = .pi) {
        UIView.animate(withDuration: duration, delay: delay, options: animatingOptions) {
            self.transform = CGAffineTransform(rotationAngle: angle)
        } completion: { _ in
            let newAngle = (angle + .pi).truncatingRemainder(dividingBy: (2 * .pi))
            self.makeRepeatingRotations(angle: newAngle)
        }
    }
    
    internal func addBorder(color: UIColor = .nhsLightGray, lineWidth: CGFloat = 1) {
        layer.borderColor = color.cgColor
        layer.borderWidth = lineWidth
    }
    
    public func addEndEditingGesture()
    {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleViewTap))
        gesture.cancelsTouchesInView = false
        self.addGestureRecognizer(gesture)
    }
    @objc private func handleViewTap() { self.endEditing(true) }
    
//    @discardableResult
//    internal func addBottomSeparator(color: UIColor = .nhsLightGray, lineWidth: CGFloat = 1) -> HorizontalSeparatorView {
//        let separatorView = HorizontalSeparatorView(lineWidth: lineWidth)
//        separatorView.backgroundColor = color
//        addSubview(separatorView)
//        separatorView.pinHorizontallyToSuperview()
//        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        return separatorView
//    }
}

////MARK: - NhsProgressView extension
//extension UIView {
//    public func showProgressView(title: String? = nil) {
//
//        //disable interaction
//        isUserInteractionEnabled = false
//
//        //logic to show view
//        if let existingViewInfo = NhsProgressViewCounter.views[self],
//           existingViewInfo.0 > 0 {
//            //already progress view is displayed, increase counter
//            NhsProgressViewCounter.views[self] = (existingViewInfo.0 + 1, existingViewInfo.1)
//        } else {
//            //show progress view
//            let progressView = NhsProgressView(title: title)
//            self.addSubview(progressView)
//            NSLayoutConstraint.activate([
//                progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
//                progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
//                progressView.topAnchor.constraint(equalTo: topAnchor),
//                progressView.bottomAnchor.constraint(equalTo: bottomAnchor)
//            ])
//
//            //set value in dictionary
//            NhsProgressViewCounter.views[self] = (1, progressView)
//        }
//    }
//
//    public func hideProgressView() {
//        if let existingViewInfo = NhsProgressViewCounter.views[self],
//           existingViewInfo.0 > 0 {
//
//            if existingViewInfo.0 == 1 {
//                DispatchQueue.main.async {
//                    existingViewInfo.1.removeFromSuperview()
//                    self.isUserInteractionEnabled = true
//                }
//            }
//
//            NhsProgressViewCounter.views[self] = (existingViewInfo.0 - 1, existingViewInfo.1)
//        }
//    }
//}

//// MARK: - Nhs Toast View
//extension UIView {
//
//    func showSuccessToast(withTitle title: String = "Success", withSubTitle subTitle: String, duration: CGFloat = 3, handler: VoidHandler? = nil) {
//
//        let toast = NhsToastView(style: .success, heading: title, subHeading: subTitle, toastStayDuration: duration) { thisToast in
//            thisToast.removeFromSuperview()
//            handler?()
//        }
//
//        addSubview(toast)
//        toast.pinHorizontallyToSuperview(padding: .init(top: 0, left: 12, bottom: 0, right: 12))
//        toast.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
//    }
//
//    func showErrorToast(withTitle title: String = "Error", withSubTitle subTitle: String, duration: CGFloat = 3, handler: VoidHandler? = nil) {
//
//        let toast = NhsToastView(style: .error, heading: title, subHeading: subTitle, toastStayDuration: duration) { thisToast in
//            thisToast.removeFromSuperview()
//            handler?()
//        }
//
//        addSubview(toast)
//        toast.pinHorizontallyToSuperview(padding: .init(top: 0, left: 12, bottom: 0, right: 12))
//        toast.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
//    }
//}
//
