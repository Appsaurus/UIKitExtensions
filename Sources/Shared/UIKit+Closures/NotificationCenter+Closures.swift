//
//  NotificationCenter+Closures.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 1/1/19.
//  Copyright © 2019 Brian Strobach. All rights reserved.
//

#if canImport(Foundation)
import Foundation
import Swiftest
import DarkMagic

public typealias NotificationClosure = ClosureIn<Notification>
public typealias NotificationObservation = ActionIn<Notification>

public protocol NotificationClosureObserver: ActionDelegatable {}
public extension NotificationClosureObserver where Self: NSObject {

    /// Closure based API for responding to Notifications. Automatically retains the
    /// closure for the lifespan of the object this method is called on.
    ///
    /// - Parameters:
    ///   - name: The name of the notification for which to register the observer; that is, only notifications with this name are delivered to the observer.
    ///   - object: The object whose notifications the observer wants to receive; that is, only notifications sent by this sender are delivered to the observer.
    ///If you pass nil, the notification center doesn’t use a notification’s sender to decide whether to deliver it to the observer.
    ///   - notificationCenter: The notification center to use to register the observation.
    ///   - closure: The closure to invoke whenever the notification is posted.
    /// - Returns: A cancellable notification observation.
    @discardableResult
    public func on(_ name: Notification.Name,
                   object: Any? = nil,
                   from notificationCenter: NotificationCenter? = nil,
                   closure: @escaping NotificationClosure) -> NotificationObservation {
        let notificationCenter = notificationCenter ?? (self as? NotificationCenter) ?? .default
        return addAction(binding: closure, to: { [unowned notificationCenter] in
            notificationCenter.addObserver($0,
                                           selector: $1,
                                           name: name,
                                           object: object)
        })

    }

    /// Closure based API for responding to Notifications. Automatically retains the
    /// closure for the lifespan of the object this method is called on.
    ///
    /// - Parameters:
    ///   - name: The name of the notification for which to register the observer; that is, only notifications with this name are delivered to the observer.
    ///   - object: The object whose notifications the observer wants to receive; that is, only notifications sent by this sender are delivered to the observer.
    ///If you pass nil, the notification center doesn’t use a notification’s sender to decide whether to deliver it to the observer.
    ///   - notificationCenter: The notification center to use to register the observation.
    ///   - closure: The closure to invoke whenever the notification is posted.
    /// - Returns: A cancellable notification observation.
    @discardableResult
    public func on(_ name: Notification.Name,
                   object: Any? = nil,
                   from notificationCenter: NotificationCenter? = nil,
                   closure: @escaping VoidClosure) -> VoidAction {
        let notificationCenter = notificationCenter ?? (self as? NotificationCenter) ?? .default
        return addAction(binding: closure, to: { [unowned notificationCenter] in
            notificationCenter.addObserver($0,
                                           selector: $1,
                                           name: name,
                                           object: object)
        })

    }
}

extension NSObject: NotificationClosureObserver {}

#endif
