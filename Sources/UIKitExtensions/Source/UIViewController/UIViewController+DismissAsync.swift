//
//  UIViewController+DismissAsync.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 5/14/25.
//

import UIKit

@available(iOS 13.0, *)
public extension UIViewController {
    func dismiss(animated: Bool = true) async {
        await withCheckedContinuation { continuation in
            dismiss(animated: animated) {
                continuation.resume()
            }
        }
    }
}
