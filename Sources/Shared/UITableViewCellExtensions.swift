//
//  UITableViewCellExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 9/15/16.
//
//

import Foundation
import UIKit

public extension UITableViewCell{
    public func applyClearBackground(){
        backgroundColor = UIColor.clear
        backgroundView?.backgroundColor = UIColor.clear
    }
    
    public class var defaultReuseIdentifier: String{
        return className + "Identifier"
    }
    
    public func hideSeparatorInset(){
        self.layoutMargins = UIEdgeInsets.zero
        self.separatorInset = UIEdgeInsets.zero
    }
    
    public func setSelectedBackground(color: UIColor?){
        guard let color = color else{
            self.selectedBackgroundView = nil
            return
        }
        let bgView = UIView()
        bgView.backgroundColor = color
        self.selectedBackgroundView = bgView
    }
}
