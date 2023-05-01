//
//  ExtensionUIViewController.swift
//  nhsios
//
//  Created by Amais Sheikh on 22/08/2022.
//

import UIKit

public extension UIViewController
{
    func addChildViaConstraints(child: UIViewController, toView: UIView)
    {
        addChild(child)
        toView.addSubview(child.view)
        child.didMove(toParent: self)
        
        child.view.translatesAutoresizingMaskIntoConstraints = false
        guard let childVcView = child.view
        else { return }
        
        NSLayoutConstraint.activate([
            childVcView.leadingAnchor.constraint(equalTo: toView.leadingAnchor),
            childVcView.trailingAnchor.constraint(equalTo: toView.trailingAnchor),
            childVcView.topAnchor.constraint(equalTo: toView.topAnchor),
            childVcView.bottomAnchor.constraint(equalTo: toView.bottomAnchor)
        ])
    }
    
    func removeSelfFromParent() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    func removeChild(viewController: UIViewController)
    {
        guard viewController.parent != nil else {
            return
        }
        
        viewController.willMove(toParent: nil)
        viewController.removeFromParent()
        viewController.view.removeFromSuperview()
    }
    
    func addEndEditingGesture()
    {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleViewTap))
        gesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(gesture)
    }
    @objc private func handleViewTap() { self.view.endEditing(true) }
    
    func navigate(to vc: AnyClass) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        for viewcontroller in viewControllers {
            if viewcontroller.isKind(of: vc){
                self.navigationController!.popToViewController(viewcontroller, animated: true)

            }
        }
    }
    
    func showAlertView(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showErrorAlertView(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
