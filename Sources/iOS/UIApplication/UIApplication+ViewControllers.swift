//
//  UIApplicationExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 4/17/16.
//
//

#if canImport(UIKit)
import UIKit
import MapKit
import Swiftest
import SafariServices

public extension UIApplication {
    class var topmostViewController: UIViewController? {
        return UIApplication.shared.topmostViewController
    }
    
    var topmostViewController: UIViewController? {
        guard var topController = keyWindow?.rootViewController else {
            return nil
        }
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
    
    class var topMostWindow: UIWindow? {
        return UIApplication.shared.windows.last
    }
    
    var topMostWindow: UIWindow? {
        return windows.last
    }
    
    ///The root view of the topmost window. Example use case: You can present alert controllers from here without disrupting the state of current first responders in underlying view controllers.
    
    class var topWindowRootViewController: UIViewController? {
        return UIApplication.shared.topMostWindow?.rootViewController
    }
    
    var topWindowRootViewController: UIViewController? {
        return topMostWindow?.rootViewController
    }


    @discardableResult
    func openURL(_ urlString: String) throws {
        guard let url = urlString.url else {
            throw URLError(.badURL)
        }
        try openURLIfPossible(url)
    }
    @discardableResult
    func openURLIfPossible(_ urlString: String) throws {
        guard let url = urlString.url else {
            throw URLError(.badURL)
        }
        try openURLIfPossible(url)
    }

    @discardableResult
    func openURLIfPossible(_ url: URL) throws {
        guard canOpenURL(url) else {
            throw URLError(.badURL)
        }
        openURL(url)
    }

    func open(url: URLConvertible, embeddedInApp: Bool = true, orShowError message: String? = nil) {
        do{
            try UIApplication.shared.openURLIfPossible(try url.assertURL())
        }
        catch {
            topmostViewController?.showError(title: "Error", message: message ?? "Unable to open URL", error: error)
        }
    }
    
    func callNumber(_ phoneNumber: String) throws {
        var phoneNumber = phoneNumber
        let charsToRemove = CharacterSet.decimalDigits.inverted
        phoneNumber = phoneNumber.components(separatedBy: charsToRemove).joined(separator: "")
        try openURLIfPossible("tel://\(phoneNumber)")
    }
    
    func confirmAndCallPhoneNumber(_ phoneNumber: String) {
        let callAction = { [weak self] in
            do{
                try self?.callNumber(phoneNumber)
            }
            catch{
                self?.topmostViewController?.showError(error: error)
            }
        }
        self.topmostViewController?.presentAlert(title: "Call \(phoneNumber)?",
                                                actions: [ "Yes" => callAction(),
                                                            "No" .~ .cancel])
    }
    
    // MARK: Apple Maps deep links
    func openAppleMapsAndDropPin(_ address: String) {
        var address = address
        address = address.replacingOccurrences(of: " ", with: "+")
        self.openURL(URL(string: "http://maps.apple.com/?address=\(address)")!)
    }
    
    func openAppleMapsAndGiveDirections(_ destinationAddress: String) {
        var address = destinationAddress
        address = address.replacingOccurrences(of: " ", with: "+")
        self.openURL(URL(string: "http://maps.apple.com/?daddr=\(address)&dirflg=d")!)
    }
    
    func openAppleMapsAndGiveDirectionsWithDestinationCoordinates(_ long: String, lat: String) {
        
        let coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(long)!, CLLocationDegrees(lat)!)
        let placemark: MKPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let mapItem: MKMapItem = MKMapItem(placemark: placemark)
        openAppleMapsAndGiveDirections(nil, destination: mapItem)
    }
    
    func openAppleMapsAndGiveDirections(_ startLocation: MKMapItem? = MKMapItem.forCurrentLocation(), destination: MKMapItem) {
        let launchOptions: NSDictionary = NSDictionary(object: MKLaunchOptionsDirectionsModeDriving,
                                                       forKey: MKLaunchOptionsDirectionsModeKey as NSCopying)
        MKMapItem.openMaps(with: [startLocation!, destination], launchOptions: launchOptions as? [String: AnyObject])
    }
}

public extension UIApplication {
    class var mainWindow: UIWindow {
        return  UIApplication.shared.delegate!.window!!
    }

}

public extension UIApplication {
    class func documentsDirectory() -> URL {
        let fm = FileManager.default
        return fm.urls(for: .documentDirectory, in: .userDomainMask).last!
    }
    
    class func enableAutolayoutWarningLog(_ enabled: Bool = true) {
        UserDefaults.standard.setValue(enabled, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
    }
    
    class func emptyDocumentsDirectory() {
        debugLog("Attempting to empty documents directory")
        let fileMgr = FileManager()
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        if let directoryContents = try? fileMgr.contentsOfDirectory(atPath: dirPath) {
            for path in directoryContents {
                let fullPath = (dirPath as NSString).appendingPathComponent(path)
                try? fileMgr.removeItem(atPath: fullPath)
            }
        }
    }
    
    func refreshAllViews() {
        for window in self.windows {
            for view in window.subviews {
                view.removeFromSuperview()
                window.addSubview(view)
            }
        }
    }
    
}

public extension UIApplication {

    class var bundleID: String {
        return Bundle.main.bundleIdentifier!
    }
    class var versionNumber: String {
        // swiftlint:disable next force_cast
        return Bundle.main.versionNumber!
    }
    
    class var buildNumber: String {
        // swiftlint:disable next force_cast
        return Bundle.main.buildNumber!
    }
    
    class var versionAndBuildNumber: String {
        let version = versionNumber, build = buildNumber
        return "\(versionNumber)(\(buildNumber))"
    }

    class var displayName: String {
        // swiftlint:disable next force_cast
        return Bundle.main.displayName!
    }

    class var majorAppVersion: String {
        // swiftlint:disable next force_cast
        return versionNumber.components(separatedBy: ".").first!
    }
}

public extension Bundle {
    // Name of the app - title under the icon.
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
            object(forInfoDictionaryKey: "CFBundleName") as? String
    }

    var versionNumber: String? {
        // swiftlint:disable next force_cast
        return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    var buildNumber: String? {
        // swiftlint:disable next force_cast
        return object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
}
#endif
