//
//  UIViewControllerExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 5/25/16.
//
//

#if canImport(UIKit)
import UIKit
import Swiftest

public extension UIViewController {

    @discardableResult
    func presentAlert(style: UIAlertController.Style = .alert,
                      title: String? = nil,
                      message: String? = nil,
                      autoDismissAfter delay: TimeInterval = 2,
                      actions: UIAlertActionConvertible...) -> UIAlertController {
        return presentAlert(style: style,
                            title: title,
                            message: message,
                            autoDismissAfter: delay,
                            actions: actions)
    }

    @discardableResult
    func presentAlert(style: UIAlertController.Style = .alert,
                      title: String? = nil,
                      message: String? = nil,
                      autoDismissAfter delay: TimeInterval = 2,
                      actions: [UIAlertActionConvertible]) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        alertController.add(actions: actions.map {$0.toAlertAction})
        if alertController.actions.count == 0 {
            alertController.dismiss(after: delay)
        }
        self.present(alertController, animated: true, completion: nil)
        return alertController
    }
}

extension UIViewController {
    public func showErrorAlert(title: String? = nil, message: String? = nil, _ error: Error? = nil) {
        let error: Error = error ?? BasicError.unknown
        presentAlert(title: title, message: message ?? error.localizedDescription)
    }
    public func showError(title: String? = nil, message: String? = nil, error: Error? = nil) {
        let error: Error = error ?? BasicError.unknown
        presentAlert(title: title, message: message ?? error.localizedDescription)
    }
}

#endif
