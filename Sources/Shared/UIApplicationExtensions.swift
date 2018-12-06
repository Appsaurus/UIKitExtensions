//
//  UIApplicationExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 4/17/16.
//
//

import UIKit
import MapKit
import DinoDNA

public extension UIApplication{
    public class var topmostViewController: UIViewController?{
        return UIApplication.shared.topmostViewController
    }
    
    public var topmostViewController: UIViewController?{
        guard var topController = keyWindow?.rootViewController else{
            return nil
        }
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
    
    public class var topMostWindow: UIWindow?{
        return UIApplication.shared.windows.last
    }
    
    public var topMostWindow: UIWindow?{
        return windows.last
    }
    
    ///The root view of the topmost window. Example use case: You can present alert controllers from here without disrupting the state of current first responders in underlying view controllers.
    
    public class var topWindowRootViewController: UIViewController?{
        return UIApplication.shared.topMostWindow?.rootViewController
    }
    
    public var topWindowRootViewController: UIViewController?{
        return topMostWindow?.rootViewController
    }
    
    
    public func callNumber(_ phoneNumber:String) {
        var phoneNumber = phoneNumber
        let charsToRemove = CharacterSet.decimalDigits.inverted
        phoneNumber = phoneNumber.components(separatedBy: charsToRemove).joined(separator: "")
        if let phoneCallURL:URL = URL(string:"tel://\(phoneNumber)") {
            if (self.canOpenURL(phoneCallURL)) {
                self.openURL(phoneCallURL);
            }
        }
    }
    
    public func confirmAndCallPhoneNumber(_ phoneNumber: String){
        self.topmostViewController?.confirmUserIntention(title: "Call \(phoneNumber)?", confirmationTitle: "Yes", cancelTitle: "No", prompt: nil, runOnConfirmation:{
            self.callNumber(phoneNumber)
        })
    }
    
    //MARK: Apple Maps deep links
    public func openAppleMapsAndDropPin(_ address: String){
        var address = address
        address = address.replacingOccurrences(of: " ", with: "+")
        self.openURL(URL(string: "http://maps.apple.com/?address=\(address)")!)
    }
    
    public func openAppleMapsAndGiveDirections(_ destinationAddress: String){
        var address = destinationAddress
        address = address.replacingOccurrences(of: " ", with: "+")
        self.openURL(URL(string: "http://maps.apple.com/?daddr=\(address)&dirflg=d")!)
    }
    
    public func openAppleMapsAndGiveDirectionsWithDestinationCoordinates(_ long:String, lat:String){
        
        let coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(long)!, CLLocationDegrees(lat)!)
        let placemark:MKPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary:nil)
        let mapItem:MKMapItem = MKMapItem(placemark: placemark)
        openAppleMapsAndGiveDirections(nil, destination: mapItem)
    }
    
    public func openAppleMapsAndGiveDirections(_ startLocation: MKMapItem? = MKMapItem.forCurrentLocation(), destination: MKMapItem){
        let launchOptions:NSDictionary = NSDictionary(object: MKLaunchOptionsDirectionsModeDriving, forKey: MKLaunchOptionsDirectionsModeKey as NSCopying)
        MKMapItem.openMaps(with: [startLocation!, destination], launchOptions: launchOptions as? [String : AnyObject])
    }
}

public extension UIApplication{
    public class var mainWindow: UIWindow{
        return  UIApplication.shared.delegate!.window!!
    }

}

public extension UIApplication{
    public class func documentsDirectory() -> URL{
        let fm = FileManager.default
        return fm.urls(for: .documentDirectory, in: .userDomainMask).last!
    }
    
    public class func enableAutolayoutWarningLog(_ enabled: Bool = true){
        UserDefaults.standard.setValue(enabled, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
    }
    
    public class func emptyDocumentsDirectory(){
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
    
    
    public func refreshAllViews(){
        for window in self.windows{
            for view in window.subviews{
                view.removeFromSuperview()
                window.addSubview(view)
            }
        }
    }
    
}

public extension UIApplication {
    
    public class var versionNumber: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    public class var buildNumber: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
    
    public class var versionAndBuildNumber: String {
        let version = versionNumber, build = buildNumber
        return version == build ? "v\(version)" : "v\(version)(\(build))"
    }
}
