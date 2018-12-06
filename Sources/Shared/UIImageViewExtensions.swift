////
////  UIImageViewExtensions.swift
////  Pods
////
////  Created by Brian Strobach on 7/17/17.
////
////
//
//import AlamofireImage
//
//extension BaseImageView{
//    
//    open func displayRoundedRectImage(withUrlString urlString: String, placeholderImage: UIImage? = nil){
//        let imageShape = ImageShape.roundedRect(radius: App.layout.roundedCornerRadius)
//        displayImage(withUrlString: urlString, placeholderImage: placeholderImage, shape: imageShape)
//    }
//    
//    open func displayImage(withUrlString urlString: String, placeholderImage: UIImage? = nil, filter: ImageFilter? = nil,  transition: ImageTransition = ImageTransition.crossDissolve(0.2), shape: ImageShape){
//        imageShape = shape
//        displayImage(withUrlString: urlString, placeholderImage: placeholderImage, filter: filter, transition: transition)
//    }
//    
//}
//
//
//extension UIImageView{
//
//    open func displayImage(_ nameOrUrl: String, placeholderImage: UIImage? = nil, filter: ImageFilter? = nil, transition: ImageTransition = ImageTransition.crossDissolve(0.2)){
//        guard let image = UIImage(named: nameOrUrl) else{
//            displayImage(withUrlString: nameOrUrl, placeholderImage: placeholderImage, filter: filter, transition: transition)
//            return
//        }
//        self.image = image
//
//    }
//    open func displayImage(withUrlString urlString: String, placeholderImage: UIImage? = nil, filter: ImageFilter? = nil, transition: ImageTransition = ImageTransition.crossDissolve(0.2)){
//        resetImage()
//        guard let url: URL = URL(string: urlString) else { return }
//        af_setImage(withURL: url, placeholderImage: placeholderImage, filter: filter, imageTransition: ImageTransition.crossDissolve(0.2), runImageTransitionIfCached: false)
//    }
//    
//    open func resetImage(){
//        af_cancelImageRequest()
//        image = nil
//    }
//}
//
//extension UIButton{
//    open func displayImage(withUrlString urlString: String, filter: ImageFilter? = nil, for state: UIControl.State){
//        resetImage(for: state)
//        guard let url: URL = URL(string: urlString) else { return }
//        af_setImage(for: state, url: url)
//    }
//    
//    open func resetImage(for state: UIControl.State){
//        af_cancelImageRequest(for: state)
//    }
//}
//
