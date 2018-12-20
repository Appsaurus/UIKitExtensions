//
//  UIViewControllerExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 5/25/16.
//
//

import Foundation
import Swiftest

public extension UIViewController{

    public func preloadView() {
        let _ = view
    }
    
    public func dismissOrPop(animated: Bool = true){
        if let nav = navigationController{
            nav.popViewController(animated: animated)
        }
        else{
            self.dismiss(animated: animated, completion: nil)
        }
    }
    public func isModal() -> Bool {
        if((self.presentingViewController) != nil) {
            return true
        }
        return false
    }
    
    public var isCurrentlyVisibleToUser: Bool{
        return self.isViewLoaded && view.window != nil
    }
    
    public func add(childViewController: UIViewController, toContainer container: UIView){
        childViewController.view.frame = container.bounds
        container.addSubview(childViewController.view)
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.willMove(toParent: self)
        addChild(childViewController)
        childViewController.didMove(toParent: self)
    }
    
    public func remove(childViewController: UIViewController) {
        childViewController.willMove(toParent: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParent()
        childViewController.didMove(toParent: nil)
    }
    
    
    
    public func swap(childViewController oldViewController: UIViewController, withReplacementViewController newViewController:UIViewController, inContainer containerView: UIView, animated: Bool = true, completion: VoidClosure? = nil){
        remove(childViewController: oldViewController)
        add(childViewController: newViewController, toContainer: containerView)
        completion?()
    }
    
    public func present(viewController: UIViewController, animated: Bool = true, completion: VoidClosure? = nil){
        present(viewController, animated: animated, completion: completion)
    }
    
    public func push(viewController: UIViewController, animated: Bool = true, completion: VoidClosure? = nil) {
        guard let navVC = self as? UINavigationController ?? self.navigationController else { return }
        guard let completion = completion else{
            navVC.pushViewController(viewController, animated: animated)
            return
        }
        navVC.pushViewController(viewController, animated: animated, completion: completion)
    }
    
    public func presentAlertController(title: String?, message: String?, dismissButtonTitle: String = "OK", buttonTitle: String? = nil, buttonClosure: VoidClosure? = nil){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let buttonTitle = buttonTitle, let buttonClosure = buttonClosure{
            let buttonAction = UIAlertAction(title: buttonTitle, style: .default) { (action) in
                buttonClosure()
            }
            alertController.addAction(buttonAction)
        }
        
        let dismissAction = UIAlertAction(title: dismissButtonTitle, style: .default) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(dismissAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func presentAlertController(title: String?, message: String?, cancelButtonTitle: String = "Cancel", onCancel: @escaping VoidClosure = {}, retryButtonTitle: String = "Retry", retryButtonClosure: @escaping VoidClosure){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { (action) in
            onCancel()
        }
        alertController.addAction(cancelAction)
        
        let retryButtonAction = UIAlertAction(title: retryButtonTitle, style: .default) { (action) in
            retryButtonClosure()
        }
        alertController.addAction(retryButtonAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func presentAlertController(title: String?, message: String?, buttonTitle: String, buttonClosure: @escaping VoidClosure, secondButtonTitle: String? = nil, secondButtonClosure: VoidClosure? = nil){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let buttonAction = UIAlertAction(title: buttonTitle, style: .default) { (action) in
            buttonClosure()
        }
        alertController.addAction(buttonAction)
        
        if let secondButtonTitle = secondButtonTitle, let secondButtonClosure = secondButtonClosure{
            let secondButtonAction = UIAlertAction(title: secondButtonTitle, style: .default) { (action) in
                secondButtonClosure()
            }
            alertController.addAction(secondButtonAction)
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func presentAlertControllerWithTextField(title: String? = nil, message: String? = nil, textFieldIsSecure: Bool = false, submitButtonTitle: String, submitButtonClosure: @escaping ClosureIn<String?>, cancelButtonClosure: VoidClosure? = nil, inputTextFieldPlaceholder: String? = nil){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var textFieldToSubmit: UITextField?
        
        alertController.addTextField { (textField) in
            textField.placeholder = inputTextFieldPlaceholder
            textFieldToSubmit = textField
            if textFieldIsSecure{
                textField.isSecureTextEntry = true
            }
        }
        
        let buttonAction = UIAlertAction(title: submitButtonTitle, style: .default) { (action) in
            submitButtonClosure(textFieldToSubmit!.text)
        }
        alertController.addAction(buttonAction)
        
        let secondButtonAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            cancelButtonClosure?()
        }
        alertController.addAction(secondButtonAction)
        
        self.present(alertController, animated: true) {
            // ...
        }
    }
    
    public func confirmUserIntention(title: String? = "Confirm", confirmationTitle: String = "Yes", cancelTitle: String = "No", prompt: String? = nil, runOnConfirmation: @escaping VoidClosure){
        presentAlertController(title: title!, message: prompt, dismissButtonTitle: cancelTitle, buttonTitle: confirmationTitle, buttonClosure: runOnConfirmation)
    }
    
    
}

extension UIViewController{
	public func showErrorAlert(title: String? = nil, message: String? = nil, _ error: Error? = nil){
		let error: Error = error ?? BasicError.unknown
		presentAlertController(title: title, message: message ?? error.localizedDescription)
	}
    public func showError(title: String? = nil, message: String? = nil, error: Error? = nil){
        let error: Error = error ?? BasicError.unknown
        presentAlertController(title: title, message: message ?? error.localizedDescription)
    }
    
    public func showError(title: String? = nil, message: String? = nil, error: Error? = nil, cancelButtonTitle: String = "Cancel", onCancel: @escaping VoidClosure = {}, retryButtonTitle: String = "Retry", retryButtonClosure: @escaping VoidClosure = {}){
        let error: Error = error ?? BasicError.unknown
        presentAlertController(title: title, message: message ?? error.localizedDescription, cancelButtonTitle: cancelButtonTitle, onCancel: onCancel, retryButtonTitle: retryButtonTitle, retryButtonClosure: retryButtonClosure)
    }
}
//MARK: Navigation item title
extension UIViewController{
//
//    @discardableResult
//    public func setupNavigationBarTitleLabel(text: String = "", inset: UIEdgeInsets? = nil, style: TextStyle = NavigationBarStyle.default.titleTextStyle, maxNumberOfLines: Int = 1) -> UILabel{
//        let navBar = navigationController!.navigationBar
//        let frame = navBar.bounds.insetBy(dx: navBar.frame.w/6.0, dy: navBar.frame.h/5.0)
//        let titleLabel = UILabel(frame: frame, text: text)
//        titleLabel.apply(textStyle: style)
//        titleLabel.adjustsFontSizeToFitWidth = true
//        titleLabel.numberOfLines = maxNumberOfLines
//        titleLabel.textAlignment = .center
//        navigationItem.titleView = titleLabel
//        return titleLabel
//    }

    public func maxNavivgationBarTitleFrame(padding: CGFloat = 0.0, centerHorizontally: Bool = true) -> CGRect?{
        guard let navFrame = navigationController?.navigationBar.frame else{
            return nil
        }
        var maxX: CGFloat = navFrame.width
        var minX: CGFloat = 0.0
        
        if let rbFrame = navigationItem.rightBarButtonItems?.first?.frame{
            maxX = (rbFrame.minX + padding)
        }
        if let lbFrame = navigationItem.leftBarButtonItems?.last?.frame{
            minX = (lbFrame.maxX - padding)
        }
        if centerHorizontally{
            let leftAdjust: CGFloat = minX
            let rightAdjust: CGFloat = navFrame.width - maxX
            if leftAdjust > rightAdjust{
                maxX -= (leftAdjust - rightAdjust)
            }
            else if rightAdjust > leftAdjust{
                minX += (rightAdjust - leftAdjust)
            }
        }
        return CGRect(x: minX, y: 0.0, width: maxX - minX, height: navFrame.size.height)
        
    }
}


extension UIViewController{
    
    open func extendViewUnderNavigationBar(){
        edgesForExtendedLayout = [.top]
        extendedLayoutIncludesOpaqueBars = true
    }
    
    open func extendViewUnderTabBar(){
        edgesForExtendedLayout = [.bottom]
        extendedLayoutIncludesOpaqueBars = true
    }
    
    open func extendViewUnderBars(){
        edgesForExtendedLayout = [.top, .bottom]
        extendedLayoutIncludesOpaqueBars = true
    }
}

extension Array where Element: UIViewController{
	public func loadViewsIfNeeded(){
		for viewController in self{
			switch viewController{
			case let navController as UINavigationController:
				navController.loadViewIfNeeded()
				navController.viewControllers.loadViewsIfNeeded()
			default:
				viewController.loadViewIfNeeded()
				viewController.children.loadViewsIfNeeded()
			}

		}
	}
}
