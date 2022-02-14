//
//  UIView+DebounceUserInteraction.swift
//  
//
//  Created by Brian Strobach on 2/14/22.
//

import Foundation
import UIKit

public extension UIView {

    /// Default debounce delay for UIButton taps. Allows delay to be updated globally.
    @objc static var debounceDelay: Double = 0.5

    /// Debounces button taps with the specified delay.
    @objc func debounce(delay: Double = UIView.debounceDelay, siblings: [UIView] = []) {
        let buttons = [self] + siblings
        buttons.forEach {
            $0.isUserInteractionEnabled = false
        }
        let deadline = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            buttons.forEach {
                $0.isUserInteractionEnabled = true
            }
        }
    }
}
