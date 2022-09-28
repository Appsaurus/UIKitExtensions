//
//  UIViewController+ConfigureSheetPresentation.swift
//  
//
//  Created by Brian Strobach on 9/28/22.
//

#if canImport(UIKit)
import UIKit

public extension UIViewController {

    @available(iOS 15.0, *)
    func configureSheetPresentation(detents: UISheetPresentationController.Detent...,
                                    selectedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = nil,
                                    prefersGrabberVisible: Bool? = nil, animateChanges: Bool = false) {
        if let sheet = sheetPresentationController {
            if let prefersGrabberVisible = prefersGrabberVisible {
                sheet.prefersGrabberVisible = prefersGrabberVisible
            }
            let changes = {
                if let selectedDetentIdentifier = selectedDetentIdentifier {
                    sheet.selectedDetentIdentifier = selectedDetentIdentifier
                }
                sheet.detents = detents
            }
            guard animateChanges else {
                changes()
                return
            }
            sheet.animateChanges {
                changes()
            }
        }
    }
}
#endif
