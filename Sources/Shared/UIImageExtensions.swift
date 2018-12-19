//
//  UIImageExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 4/17/16.
//
//

import UIKit
import Swiftest

public extension UIImage{
    
    public var minSideLength: CGFloat{
        return min(size.width, size.height)
    }
    public var maxSideLength: CGFloat{
        return max(size.width, size.height)
    }
    
    /**
     Creates an Image that is a color.
     - Parameter color: The UIColor to create the image from.
     - Parameter size: The size of the image to create.
     - Returns: A UIImage that is the color passed in.
     */
    public class func image(ofColor color: UIColor, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0.0, y: -size.height)
        
        context.setBlendMode(.multiply)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        color.setFill()
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image?.withRenderingMode(.alwaysOriginal)
    }	
    
 
    
    public func croppedtoRect(_ rect: CGRect) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        let rotatedCopy = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        if let ref:CGImage = rotatedCopy!.cgImage!.cropping(to: rect){
            return UIImage(cgImage: ref)
        }
        debugLog("Attempted to crop image with invalid rect")
        return nil
    }
    
    
    public func rotated(by degrees: CGFloat) -> UIImage {
        return UIImage.rotate(img: self, by: degrees)
    }
    
    public class func rotate(img: UIImage, by degrees: CGFloat) -> UIImage {
        
        let rotatedViewBox = UIView(frame: CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height))
        let t = CGAffineTransform(rotationAngle: degrees.degreesToRadians)
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size
        
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()
        
        bitmap!.setAllowsAntialiasing(true)
        bitmap!.setShouldAntialias(true)
        bitmap!.interpolationQuality = .high
        bitmap!.translateBy(x: rotatedSize.width/2, y: rotatedSize.height/2)
        
        bitmap!.rotate(by: degrees.degreesToRadians)
        
        bitmap!.scaleBy(x: 1.0, y: -1.0)
        bitmap!.draw(img.cgImage!, in: CGRect(x: -img.size.width / 2, y: -img.size.height / 2, width: img.size.width - 1, height: img.size.height - 1))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    @available(iOS 10.0, *)
    public func rotated(by rotationAngle: Measurement<UnitAngle>, options: ImageRotationOptions = []) -> UIImage? {
        
        
        guard let cgImage = self.cgImage else { return nil }

        let rotationInRadians = CGFloat(rotationAngle.converted(to: .radians).value)
        let transform = CGAffineTransform(rotationAngle: rotationInRadians)
        var rect = CGRect(origin: .zero, size: self.size).applying(transform)
        rect.origin = .zero
        
            let renderer = UIGraphicsImageRenderer(size: rect.size)
        return renderer.image { renderContext in
            renderContext.cgContext.translateBy(x: rect.midX, y: rect.midY)
            renderContext.cgContext.rotate(by: rotationInRadians)
            
            let x = options.contains(.flipVertical) ? -1.0 : 1.0
            let y = options.contains(.flipHorizontal) ? 1.0 : -1.0
            renderContext.cgContext.scaleBy(x: CGFloat(x), y: CGFloat(y))
            
            let drawRect = CGRect(origin: CGPoint(x: -self.size.width/2, y: -self.size.height/2), size: self.size)
            renderContext.cgContext.draw(cgImage, in: drawRect)
        }
    }
}

public struct ImageRotationOptions: OptionSet {
    public let rawValue: Int
    public init(rawValue:Int){ self.rawValue = rawValue}
    static let flipVertical = ImageRotationOptions(rawValue: 1)
    static let flipHorizontal = ImageRotationOptions(rawValue: 2)
}

public enum AspectRatioType{
    case square, portrait, landscape
}
extension UIImage{
    
    public var aspectRatioType: AspectRatioType{
        switch aspectRatio{
        case 1.0: return .square
        case CGFloat.leastNormalMagnitude..<1.0: return .portrait
        default: return .landscape
        }
    }
    
    ///Width:Height
    public var aspectRatio: CGFloat{
        return size.width /  size.height
    }
}

extension UIImage {
    
    public class func imageWithLayer(layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(layer.bounds.size, layer.isOpaque, UIScreen.main.scale)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}


extension UIImage{
    public var cgImagePropertyOrientation: CGImagePropertyOrientation {
        switch imageOrientation {
        case .up:
            return CGImagePropertyOrientation.up
        case .upMirrored:
            return CGImagePropertyOrientation.upMirrored
        case .down:
            return CGImagePropertyOrientation.down
        case .downMirrored:
            return CGImagePropertyOrientation.downMirrored
        case .left:
            return CGImagePropertyOrientation.left
        case .leftMirrored:
            return CGImagePropertyOrientation.leftMirrored
        case .right:
            return CGImagePropertyOrientation.right
        case .rightMirrored:
            return CGImagePropertyOrientation.rightMirrored
        }
    }
}
