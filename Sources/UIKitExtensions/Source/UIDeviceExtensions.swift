//
//  UIDeviceExtensions.swift
//  
//
//  Created by Brian Strobach on 9/28/22.
//

#if canImport(UIKit)
import UIKit

public extension UIDevice{
    var modelVersioned: String {
        var sysinfo = utsname()
        uname(&sysinfo)
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)?.trimmingCharacters(in: .controlCharacters) ?? "unknown"
    }
}
#endif


