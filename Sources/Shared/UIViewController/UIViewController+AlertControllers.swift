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

    public func presentAlert(title: String? = nil,
                             message: String? = nil,
                             actions: UIAlertActionConvertible...) {
        presentAlert(title: title, message: message, actions: actions)
    }

    public func presentAlert(title: String? = nil,
                             message: String? = nil,
                             actions: [UIAlertActionConvertible]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.add(actions: actions.map {$0.toAlertAction})
        self.present(alertController, animated: true, completion: nil)
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
