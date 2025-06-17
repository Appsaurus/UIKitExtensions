//
//  PresentationDebouncer.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/28/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import UIKit
import Foundation

/// A utility class to prevent multiple rapid presentation actions
public class PresentationDebouncer {
    private var lastActionTime: TimeInterval = 0
    private let minimumInterval: TimeInterval
    
    public init(minimumInterval: TimeInterval = 0.5) {
        self.minimumInterval = minimumInterval
    }
    
    /// Executes the action only if enough time has passed since the last execution
    public func execute(_ action: @escaping () -> Void) -> Bool {
        let currentTime = Date().timeIntervalSince1970
        
        if currentTime - lastActionTime >= minimumInterval {
            lastActionTime = currentTime
            action()
            return true
        }
        return false
    }
}

// Global shared instance for convenience
public extension PresentationDebouncer {
    static let shared = PresentationDebouncer()
}
#endif
