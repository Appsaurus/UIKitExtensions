//
//  UIDeviceExtensions.swift
//  
//
//  Created by Brian Strobach on 9/28/22.
//

#if canImport(UIKit)
import UIKit

public extension UIDevice{

    var userAgentString: String{
        return "\(UIApplication.displayName)/\(UIApplication.versionNumber) (\(model); CPU iPhone OS \(systemVersion.string.replacingOccurrences(of: ".", with: "_")) like Mac OS X)"
    }

    var modelVersioned: String {
        var sysinfo = utsname()
        uname(&sysinfo)
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)?.trimmingCharacters(in: .controlCharacters) ?? "unknown"
    }

    var osNameAndVersion: String {
        return "\(systemName) \(systemVersion)"
    }
}

//eg. Darwin/16.3.0
func DarwinVersion() -> String {
    var sysinfo = utsname()
    uname(&sysinfo)
    let dv = String(bytes: Data(bytes: &sysinfo.release, count: Int(_SYS_NAMELEN)), encoding: .ascii)?.trimmingCharacters(in: .controlCharacters) ?? "unknown"
    return "Darwin/\(dv)"
}
//eg. CFNetwork/808.3
func CFNetworkVersion() -> String {
    let dictionary = Bundle(identifier: "com.apple.CFNetwork")?.infoDictionary!
    let version = dictionary?["CFBundleShortVersionString"] as? String ?? "unknown"
    return "CFNetwork/\(version)"
}
#endif


