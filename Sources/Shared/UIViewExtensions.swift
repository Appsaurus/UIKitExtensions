//
//  UIViewExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 4/17/16.
//
//

import UIKit
import DinoDNA

public extension UIView{
    
    /// X value of CGRect's origin
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        } set(value) {
            self.frame.origin.x = value
        }
    }
    
    /// Y value of CGRect's origin
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        } set(value) {
            self.frame.origin.y = value
        }
    }
    
    /// Width of CGRect's size
    public var w: CGFloat {
        get {
            return self.frame.w
        } set(value) {
            self.frame.w = value
        }
    }
    
    /// Height of CGRect's size
    public var h: CGFloat {
        get {
            return self.frame.h
        } set(value) {
            self.frame.h = value
        }
    }
    
    public var size: CGSize{
        get{
            return frame.size
        }
        set{
            frame.size = newValue
        }
    }
    
}
public extension UIView {
    
    /**
     Convenience method for instantiating views with a nib. Defaults to a nib that is named after the class.
     
     Example naming convention for default implementation: UICustomView -> UICustomView.xib
     
     Use type inference to help the compiler return the correct type of view.
     
     - parameter nibNameOrNil: The name of the nib to instantiate
     
     - returns: The instantiated view
     */
    public class func fromNib<T : UIView>(_ nibName: String? = nil) -> T? {
        let nibName = nibName ?? self.className
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! T
        return view
    }
    
    /// Crawls the responder chain to find the parentviewcontroller of view which the method is called upon.
    public var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    public var firstResponder: UIView? {
        return findFirstSubview(matching: {$0.isFirstResponder})
    }
    
    public func disableGestureRecognizers(){
        gestureRecognizers?.forEach({ (gr) -> () in
            gr.isEnabled = false
        })
    }
    
    public func enableGestureRecognizers(){
        gestureRecognizers?.forEach({ (gr) -> () in
            gr.isEnabled = true
        })
    }
    
    public func removeGestureRecognizers(){
        gestureRecognizers?.forEach({ (gr) -> () in
            self.removeGestureRecognizer(gr)
        })
    }
    
    @discardableResult
    public func setBackgroundBlurStyle(_ blurStyle: UIBlurEffect.Style, withVibrancy vibrancy: Bool? = false) -> UIVisualEffectView{
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        insertSubview(effectView, at: 0)
        backgroundColor = UIColor.clear
        return effectView
        //TODO: Implement adding vibrancy to all subviews that are vibrancy compatible
    }
    
    public func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    
    
    public func addBorder(_ width: CGFloat, color: UIColor){
        layer.borderWidth = width / UIScreen.main.scale
        layer.borderColor = color.cgColor
    }
        
    @discardableResult public func addBorder(edges: UIRectEdge, color: UIColor = UIColor.white, thickness: CGFloat = 1, padding: CGFloat = 0.0) -> [UIView] {
        
        var thickness = thickness
        thickness = (thickness / UIScreen.main.scale)
        
        var borders = [UIView]()
        
        func border() -> UIView {
            let border = UIView(frame: CGRect.zero)
            border.backgroundColor = color
            return border
        }
        
        if edges.contains(.top) || edges.contains(.all) {
            let top = border()
            addSubview(top)
            top.topAnchor.constraint(equalTo: topAnchor, constant: padding)
            top.leftAnchor.constraint(equalTo: leftAnchor, constant: padding)
            top.rightAnchor.constraint(equalTo: rightAnchor, constant: padding)
            borders.append(top)
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            let left = border()
            addSubview(left)
            left.topAnchor.constraint(equalTo: topAnchor, constant: padding)
            left.leftAnchor.constraint(equalTo: leftAnchor, constant: padding)
            left.bottomAnchor.constraint(equalTo: bottomAnchor, constant: padding)
            borders.append(left)
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            let right = border()
            addSubview(right)
            right.topAnchor.constraint(equalTo: topAnchor, constant: padding)
            right.bottomAnchor.constraint(equalTo: bottomAnchor, constant: padding)
            right.rightAnchor.constraint(equalTo: rightAnchor, constant: padding)
            borders.append(right)
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            let bottom = border()
            addSubview(bottom)
            bottom.bottomAnchor.constraint(equalTo: bottomAnchor, constant: padding)
            bottom.leftAnchor.constraint(equalTo: leftAnchor, constant: padding)
            bottom.rightAnchor.constraint(equalTo: rightAnchor, constant: padding)
            borders.append(bottom)
        }
        borders.forEach { (b) in
            b.heightAnchor.constraint(equalToConstant: thickness)
        }
        return borders
    }
    
}



fileprivate extension CGRect{ //Temp fix for clash between DinoDNA and Motion pods
	fileprivate var center: CGPoint{
		return CGPoint(x: x + w/2, y: y + h/2)
	}
}

public extension UIView{
    public static func animateView(_ view: UIView, toDestinationFrame destinationFrame: CGRect, destinationSuperview: UIView = UIApplication.mainWindow, animationDuration: TimeInterval = 0.5, additionalAnimations: VoidClosure? = nil, completion: VoidClosure? = nil){
        
        view.moveToMainWindow()
        
        UIView.animate(withDuration: animationDuration, animations: {
            additionalAnimations?()
            view.frame = destinationSuperview.convert(destinationFrame, to: UIApplication.mainWindow)
            view.layoutIfNeeded()
        }, completion: { (finished) in
            view.frame = destinationFrame
            destinationSuperview.addSubview(view)
            completion?()
        })
    }

    //FIXME: This works for one animation on a view and scales nicely, but any subsequent animation on the same view seems to break. I think this has something to do with the transform no longer being equal to identity, and the frame no longer being valid after the first animation.
    public static func animateTransformOfView(_ view: UIView, toDestinationFrame destinationFrame: CGRect, destinationSuperview: UIView = UIApplication.mainWindow, animationDuration: TimeInterval = 0.5, completion: VoidClosure? = nil){
        
        view.moveToMainWindow()
        
        let widthScale = destinationFrame.w / view.bounds.w
        let heightScale = destinationFrame.h / view.bounds.h
        
        let scaleTransform = CGAffineTransform(scaleX: widthScale, y: heightScale)
        
        let centerXDestinationOffset = destinationFrame.center.x - view.center.x
        let centerYDestinationOffset = destinationFrame.center.y - view.center.y
        let translationTransform = CGAffineTransform(translationX: centerXDestinationOffset, y: centerYDestinationOffset)
        let finalTransform = scaleTransform.concatenating(translationTransform)
        
        UIView.animate(withDuration: animationDuration, animations: {
            view.transform = finalTransform
        }, completion: { (finished) in
            destinationSuperview.addSubview(view)
            view.frame = destinationFrame
            completion?()
        })
        
    }
    
    /**
     Moves view from current superview to main window, maintaining position.
     
     - returns: New frame coordinates in window coordinate space
     */
    @discardableResult
    public func moveToMainWindow() -> CGRect{
        if superview === UIApplication.mainWindow{ return frame}
        let mainWindowFrame = self.frameInMainWindow
        UIApplication.mainWindow.addSubview(self)
        self.frame = mainWindowFrame
        //self.bounds.size = frameInMainWindow.size
        //self.center = frameInMainWindow.center
        return mainWindowFrame
    }
    
    public var frameInMainWindow: CGRect{
        if superview === UIApplication.mainWindow{ return frame }
        return superview!.convert(frame, to: UIApplication.mainWindow)
    }
    
    public func deactivateAutolayoutConstraints(){
        NSLayoutConstraint.deactivate(constraints)
    }
    
    public func activateAutolayoutConstraints(){
        NSLayoutConstraint.activate(constraints)
    }
    
    @discardableResult
    public func removeAllConstraints() -> [NSLayoutConstraint]{
        let constraints = self.constraints
        self.removeConstraints(constraints)
        return constraints        
    }
    
    public func frameConverted(for view: UIView) -> CGRect {
        return frameConvertedToCoordinateSpace(of:view)
    }
    
    public func frameConvertedToCoordinateSpace(of view: UIView) -> CGRect {

		let immediateParent = superview ?? UIApplication.mainWindow
		return immediateParent.convert(frame, to: view.superview ?? UIApplication.mainWindow)
    }
    
}

public extension UIView {
    public func alphaFromPoint(_ point: CGPoint) -> CGFloat {
        var pixel: [UInt8] = [0, 0, 0, 0]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let alphaInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: alphaInfo.rawValue)
        
        context!.translateBy(x: -point.x, y: -point.y);
        
        self.layer.render(in: context!)
        
        let floatAlpha = CGFloat(pixel[3])
        return floatAlpha
    }
    
    public func hasAlphaAtPoint(_ point: CGPoint) -> Bool{
        return alphaFromPoint(point) > 0.0
    }
}

public extension UIView {

	public func addSubviews(_ views: UIView...){
		views.forEach{addSubview($0)}
	}
    public func addSubviews(_ views: [UIView]){
        views.forEach{addSubview($0)}
    }

	//Optional subiews

	public func addSubview(_ optionalSubview: UIView?){
		guard let view = optionalSubview else { return }
		addSubview(view)
	}
	public func addSubviews(_ optionalSubviews: [UIView?]){
		addSubviews(optionalSubviews.removeNils())
	}

	public func addSubviews(_ optionalSubviews: UIView?...){
		addSubviews(optionalSubviews.removeNils())
	}

	public func moveToFront(){
		superview?.bringSubviewToFront(self)
	}
}

////MARK: Designable
//
//public extension UIView {
//    
//    public func roundCorners(){
//        cornerRadius = frame.minSideLength/2.0
//    }
//    
//    @IBInspectable public var cornerRadius: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//            if newValue > 0{
//                layer.masksToBounds = true
//            }
//
//        }
//    }
//    @IBInspectable public var borderWidth: CGFloat{
//        get {
//            return layer.borderWidth
//        }
//        set {
//            layer.borderWidth = (newValue / UIScreen.main.scale)
//        }
//    }
//    @IBInspectable public var borderColor: UIColor? {
//        get {
//            if let cBorderColor = layer.borderColor{
//                return UIColor(cgColor: cBorderColor)
//            }
//            else {
//                return nil
//            }
//        }
//        set {
//            layer.borderColor = newValue?.cgColor
//        }
//        
//    }
//    
//    public func optimizeSubviews(){
//        subviews.forEach { (view) in
//            view.optimizeRendering()
//        }
//    }
//    public func optimizeRendering(){
//        layer.shouldRasterize = true
//        layer.rasterizationScale = UIScreen.main.scale
//        layer.isOpaque = true
//    }
//}

//MARK: Animation Extensions

public typealias AnimationCompletion = ((Bool) -> Void)

extension UIView {
    
    public func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    public func rotate(_ degrees: CGFloat, animated: Bool = false, duration: TimeInterval = 0.5, completion: VoidClosure? = nil) {
        
        if animated{
            UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseOut, animations: { [weak self] in
                
                self?.transform = CGAffineTransform(rotationAngle: .pi)
                
            }) { (complete) in
                completion?()
            }
        }
        else{
            transform = CGAffineTransform(rotationAngle: degrees.degreesToRadians as! CGFloat)
            completion?()
        }
    }
    
    public func startInfiniteFadeInOut(_ duration: TimeInterval = 0.8){
        let targetAlpha:CGFloat = self.alpha > 0 ? 0 : 1
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       options: [UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.repeat, UIView.AnimationOptions.beginFromCurrentState],
                       animations: { [weak self] in
                        self?.alpha = targetAlpha
            },
                       completion: nil)
    }
    
    public func stopInfiniteFadeInOut(_ finalAlpha: CGFloat, duration: TimeInterval = 0.8){
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       options: [UIView.AnimationOptions.beginFromCurrentState],
                       animations: { [weak self] in
                        self?.alpha = finalAlpha
            },
                       completion: {[weak self] (finished) in
                        self?.layer.removeAllAnimations()
        })
    }
    
    public func hide(_ duration: TimeInterval = 0.3, delay: TimeInterval = 0.0, completion: VoidClosure? = nil){
        animateAlpha(duration, delay: delay, toValue: 0.0, completion: completion)
    }
    
    public func show(_ duration: TimeInterval = 0.3, delay: TimeInterval = 0.0, completion: VoidClosure? = nil){
        animateAlpha(duration, delay: delay, toValue: 1.0, completion: completion)
    }
    
    
    public func animateAlpha(_ duration: Double, delay: Double, toValue: CGFloat, completion: VoidClosure? = nil){
        if toValue > 0{
            self.isHidden = false
        }
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {[weak self] () -> Void in
            self?.alpha = toValue
        }) {[weak self] (finished) -> Void in
            if finished{
                if toValue == 0.0{
                    self?.isHidden = true
                }
                completion?()
            }
        }
    }
    
    
    public func animateConstraintChanges(_ changes: VoidClosure? = nil, configuration: AnimationConfiguration = AnimationConfiguration(), additionalAnimations: VoidClosure? = nil, completion: VoidClosure? = nil){
        UIView.animateConstraintChanges(changes, of: [self], configuration: configuration, additionalAnimations: additionalAnimations, completion: completion)
    }
    
    class public func animateConstraintChanges(_ changes: VoidClosure? = nil, of views: [UIView], configuration: AnimationConfiguration = AnimationConfiguration(), additionalAnimations: VoidClosure? = nil, completion: VoidClosure? = nil){
        changes?()
        animate(configuration: configuration, layoutViews: views, animations: additionalAnimations, completion: completion)
    }
    
    public func animate(configuration: AnimationConfiguration = AnimationConfiguration(), animations: VoidClosure? = nil, completion: VoidClosure? = nil){
        UIView.animate(configuration: configuration, layoutViews: [self], animations: animations, completion: completion)        
    }
    
    class public func animate(configuration: AnimationConfiguration = AnimationConfiguration(), layoutViews views: [UIView]? = nil, animations: VoidClosure? = nil, completion: VoidClosure? = nil){
        if let configuration = configuration as? SpringAnimationConfiguration{
            UIView.animate(withDuration: configuration.duration, delay: configuration.delay, usingSpringWithDamping: configuration.springDamping, initialSpringVelocity: configuration.springVelocity, options: configuration.options, animations: {
                views?.forEach{$0.layoutIfNeeded()}
                animations?()
            }) { (finished) -> Void in
                if finished{
                    completion?()
                }
            }
        }
        else{
            UIView.animate(withDuration: configuration.duration, delay: configuration.delay, options: configuration.options, animations: {
                animations?()
                views?.forEach{$0.layoutIfNeeded()}
                
            }) { (finished) -> Void in
                if finished{
                    completion?()
                }
            }
        }
    }

    public func springAnimate(configuration: SpringAnimationConfiguration = SpringAnimationConfiguration(), animations: VoidClosure? = nil, completion: VoidClosure? = nil){
        UIView.springAnimate(configuration: configuration, layoutViews: [self], animations: animations, completion: completion)
    }
    
    public func springAnimateConstraintChanges(_ changes: VoidClosure? = nil, configuration: SpringAnimationConfiguration = SpringAnimationConfiguration(), additionalAnimations: VoidClosure? = nil, completion: VoidClosure? = nil){
        UIView.springAnimateConstraintChanges(changes, of: [self], configuration: configuration, additionalAnimations: additionalAnimations, completion: completion)
    }
    
    class public func springAnimateConstraintChanges(_ changes: VoidClosure? = nil, of views: [UIView], configuration: SpringAnimationConfiguration = SpringAnimationConfiguration(), additionalAnimations: VoidClosure? = nil, completion: VoidClosure? = nil){
        changes?()
       springAnimate(configuration: configuration, layoutViews: views, animations: additionalAnimations, completion: completion)
    }
    
    class public func springAnimate(configuration: SpringAnimationConfiguration = SpringAnimationConfiguration(), layoutViews views: [UIView]? = nil, animations: VoidClosure? = nil, completion: VoidClosure? = nil){
        
        UIView.animate(withDuration: configuration.duration, delay: configuration.delay, usingSpringWithDamping: configuration.springDamping, initialSpringVelocity: configuration.springVelocity, options: configuration.options, animations: {
            views?.forEach{$0.layoutIfNeeded()}
            animations?()
        }) { (finished) -> Void in
            if finished{
                completion?()
            }
        }
    }
}

public class AnimationConfiguration{
    public var duration: TimeInterval
    public var delay: TimeInterval
    public var options: UIView.AnimationOptions
    public init(duration: TimeInterval = 0.3, delay: TimeInterval = 0.0, options: UIView.AnimationOptions = []) {
        self.duration = duration
        self.delay = delay
        self.options = options
    }
}

public class SpringAnimationConfiguration: AnimationConfiguration{
    public var springDamping: CGFloat
    public var springVelocity: CGFloat
    public init(duration: TimeInterval = 0.3, delay: TimeInterval = 0.0, springDamping: CGFloat = 0.5, springVelocity: CGFloat = 0.8, options: UIView.AnimationOptions = []) {
        self.springDamping = springDamping
        self.springVelocity = springVelocity
        super.init(duration: duration, delay: delay, options: options)
    }
    
}

extension UIView {
    public func toImage(transparentBackground: Bool? = nil) -> UIImage {
        
        let opaque = transparentBackground != nil ? !transparentBackground! : isOpaque
        UIGraphicsBeginImageContextWithOptions(bounds.size, opaque, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
//        UIGraphicsBeginImageContext(self.frame.size)
//        guard let context = UIGraphicsGetCurrentContext() else { return nil }
//        self.layer.render(in: context)
//        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil}
//        UIGraphicsEndImageContext()
//        
//        return image
    }
}


extension UIView{
    public func findAllSubviews<T: UIView>(ofType type: T.Type, recursive: Bool = true) -> [T]{
        var matches: [T] = []
        subviews.forEach { (view) in
            if let match = view as? T{
                matches.append(match)
            }
            if recursive && view.subviews.count > 0{
                matches.append(contentsOf: view.findAllSubviews(ofType: type))
            }
        }
        return matches
    }
    
    public func findAllSubviews(recursive: Bool = true, matching check: (_ viewToCheck: UIView) -> Bool) -> [UIView]{
        var matches: [UIView] = []
        subviews.forEach { (view) in
            if check(view){
                matches.append(view)
            }
            if recursive && view.subviews.count > 0{
                matches.append(contentsOf: view.findAllSubviews(matching: check))
            }
        }
        return matches
    }
    
    public func findFirstSubview(recursive: Bool = true, matching check: ViewTest) -> UIView?{
        guard subviews.count > 0 else { return nil }
        for view in subviews{
            if check(view){
                return view
            }
            if recursive && view.subviews.count > 0{
                if let recursiveMatch = view.findFirstSubview(matching: check){
                    return recursiveMatch
                }
            }
        }
        return nil
    }
}

public typealias ViewTest = (_ viewToCheck: UIView) -> Bool

extension UIView{
	public func findFirstParentView(matching check: ViewTest) -> UIView?{
		var currentView: UIView? = self
        while let viewToTest = currentView?.superview{
			if check(viewToTest){
				return viewToTest
			}
			currentView = viewToTest
		}
		return nil
	}

	public var firstVisibleParentBackgroundColor: UIColor?{
		return findFirstParentView(matching: { (view) -> Bool in
			view.backgroundColor != nil
		})?.backgroundColor
	}
	
}

extension UIView{
    
    public var isVisible: Bool{
        set{
            isHidden = !newValue
        }
        get{
            return !isHidden
        }
    }
    
}

extension Array where Element: UIView{
    public var isHidden: Bool{
        get{
            return self.contains { (element) -> Bool in
                !element.isHidden
                } ? false : true            
        }
        set{
            self.forEach({$0.isHidden = newValue})
        }
    }
}

