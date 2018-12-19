//
//  UIGestureRecognizerExtensions.swift
//  AppsaurusUIKit
//
//  Created by Brian Strobach on 5/26/16.
//  Copyright © 2016 Appsaurus LLC. All rights reserved.
//

import UIKit
import Swiftest
// Global array of targets, as extensions cannot have non-computed properties
private var target = [Target]()

public extension UIGestureRecognizer {
    
    convenience public init(trailingClosure closure: @escaping VoidClosure) {
        // let UIGestureRecognizer do its thing
        self.init()
        
        target.append(Target(closure))
        self.addTarget(target.last!, action: #selector(Target.invoke))
    }
    
    public func onRecognition(_ closure: @escaping VoidClosure){
        target.append(Target(closure))
        self.addTarget(target.last!, action: #selector(Target.invoke))
    }
}

private class Target {
    
    // store closure
    var trailingClosure: VoidClosure
    
    init(_ closure: @escaping VoidClosure) {
        trailingClosure = closure
    }
    
    // function that gesture calls, which then
    // calls closure
    @objc func invoke() {
        trailingClosure()
    }
}
