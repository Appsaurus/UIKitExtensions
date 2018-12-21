//
//  UIBarButtonItemExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 4/12/17.
//
//

#if canImport(UIKit)
import UIKit
import Swiftest

extension UIBarButtonItem {
    public var frame: CGRect {
        // swiftlint:disable next force_cast
        return (value(forKey: "view") as! UIView).frame
    }
    
//    public convenience init<T: FontIconEnumProtocol>(icon: T, fontSize: CGFloat = App.style.barButtonFontSize * 1.5, onTouchUpInside: VoidClosure? = nil){
//        let button = UIButton()
//        button.setFontIconTitle(icon, fontSize: fontSize)
//        self.init(customButton: button)
//    }
//    
//    public convenience init(customButton: UIButton, onTouchUpInside: VoidClosure? = nil){
//        customButton.frame = CGRect(x: 0, y: 0, width: 44.0 , height: 44.0) //TODO: Change to 66 x 66 for Plus sized iPhones
//        if let onTouchUpInside = onTouchUpInside{
//            customButton.addAction(forControlEvents: .touchUpInside) {
//                onTouchUpInside()
//            }
//        }
//        self.init(customView: customButton)
//    }
}

//extension UIBarButtonItem{
//    static func barButtonWithCustomUIButton(_ titleColor: UIColor? = .primaryContrast, textAlignment: NSTextAlignment = .center, width: CGFloat = 75.0) -> UIBarButtonItem{
//        let button = BaseUIButton(frame: CGRect(x: 0, y: 0, width: 50.0 , height: 75.0))
//        button.setTitleColor(titleColor, for: .normal)
//        button.titleLabel!.textAlignment = textAlignment
//        return UIBarButtonItem(customView: button)
//    }
//    
//    static func barButtonWithCustomButton(_ textStyle: TextStyle = .regular(color: .primaryContrast), textAlignment: NSTextAlignment = .center, width: CGFloat = 75.0) -> UIBarButtonItem{
//        let button = BaseButton(frame: CGRect(x: 0, y: 0, width: 50.0 , height: 75.0))
//        button.styleMap = [.normal : ButtonStyle(textStyle: textStyle)]
//        button.titleLabel.textAlignment = textAlignment
//        return UIBarButtonItem(customView: button)
//    }
//}
#endif
