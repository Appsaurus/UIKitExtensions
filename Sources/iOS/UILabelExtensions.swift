//
//  UILabelExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 4/21/16.
//
//

#if canImport(UIKit)
import UIKit

public extension UILabel{
    
    public var fontSize: CGFloat{
        set{
            if let font = self.font{
                self.font = font.withSize(newValue)
            }
            else{
                self.font = UIFont.systemFont(ofSize: newValue)
            }
        }
        get{
            return self.font.pointSize
        }
    }
    
    public var fontName: String{
        set{
            self.font = UIFont(name: fontName, size: fontSize)
        }
        get{
            return self.font.familyName
        }
    }
    
    public func adjustFontSizeToFit(height: CGFloat){
        
        guard let text = text else { return }
        font = font?.sizedToFit(text: text, inHeight: height)
    }
    
    public func adjustFontSizeToFitHeight(scaleFactor: CGFloat = 1.0){
        adjustFontSizeToFit(height: h * scaleFactor)
    }

    
    convenience init(frame: CGRect = .zero, text: String) {
        self.init(frame: frame)
        self.text = text
    }
    
    public func wrapWords(){
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
    }
    
    public func truncateAfter(lines: Int){
        numberOfLines = lines
        lineBreakMode = .byTruncatingTail
    }
}

public extension UILabel{
    public func addGlowingTextShadow(_ color: UIColor? = nil, radius: CGFloat = 5.0, opacity: Float = 1.0, offset: CGSize = CGSize.zero){
        let color: UIColor = color ?? textColor
        layer.addGlowingShadow(color, radius: radius, opacity: opacity, offset: offset)
    }
    public func verticallyCenterAllCharactersInAttributedText(){
        if self.attributedText != nil{
            self.attributedText = self.attributedText?.mutable.verticallyCenterAllCharacters()
        }
    }
}

extension UILabel {
    func sizeOfTitle() -> CGSize {
        return text?.size(withAttributes: [NSAttributedString.Key.font: self.font]) ?? .zero
    }
}


//MARK: Autosizing font to fit frame
//source: https://github.com/tbaranes/FittableFontLabel

public extension UILabel {
    
    /**
     Resize the font to make the current text fit the label frame.
     - parameter maxFontSize:  The max font size available
     - parameter minFontScale: The min font scale that the font will have
     - parameter rectSize:     Rect size where the label must fit
     */
    public func fontSizeToFit(maxFontSize: CGFloat = 100, minFontScale: CGFloat = 0.1, rectSize: CGSize? = nil) {
        guard let unwrappedText = self.text else {
            return
        }
        
        let newFontSize = fontSizeThatFits(text: unwrappedText, maxFontSize: maxFontSize, minFontScale: minFontScale, rectSize: rectSize)
        font = font.withSize(newFontSize)
    }
    
    /**
     Returns a font size of a specific string in a specific font that fits a specific size
     - parameter text:         The text to use
     - parameter maxFontSize:  The max font size available
     - parameter minFontScale: The min font scale that the font will have
     - parameter rectSize:     Rect size where the label must fit
     */
    public func fontSizeThatFits(text string: String, maxFontSize: CGFloat = 100, minFontScale: CGFloat = 0.1, rectSize: CGSize? = nil) -> CGFloat {
        let maxFontSize = maxFontSize.isNaN ? 100 : maxFontSize
        let minFontScale = minFontScale.isNaN ? 0.1 : minFontScale
        let minimumFontSize = maxFontSize * minFontScale
        let rectSize = rectSize ?? bounds.size
        guard string.count != 0 else {
            return self.font.pointSize
        }
        
        let constraintSize = numberOfLines == 1 ?
            CGSize(width: CGFloat.greatestFiniteMagnitude, height: rectSize.height) :
            CGSize(width: rectSize.width, height: CGFloat.greatestFiniteMagnitude)
        return binarySearch(string: string, minSize: minimumFontSize, maxSize: maxFontSize, size: rectSize, constraintSize: constraintSize)
    }
    
}

// MARK: - Helpers
private extension UILabel {
    
    func currentAttributedStringAttributes() -> [NSAttributedString.Key : Any] {
        var newAttributes = [NSAttributedString.Key: Any]()
        attributedText?.enumerateAttributes(in: NSRange(0..<(text?.count ?? 0)), options: .longestEffectiveRangeNotRequired, using: { attributes, _, _ in
            newAttributes = attributes
        })
        return newAttributes
    }
    
}

// MARK: - Search
private extension UILabel {
    
    enum FontSizeState {
        case fit, tooBig, tooSmall
    }
    
    func binarySearch(string: String, minSize: CGFloat, maxSize: CGFloat, size: CGSize, constraintSize: CGSize) -> CGFloat {
        let fontSize = (minSize + maxSize) / 2
        var attributes = currentAttributedStringAttributes()
        attributes[.font] = font.withSize(fontSize)
        
        let rect = string.boundingRect(with: constraintSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        let state = numberOfLines == 1 ? singleLineSizeState(rect: rect, size: size) : multiLineSizeState(rect: rect, size: size)
        
        // if the search range is smaller than 0.1 of a font size we stop
        // returning either side of min or max depending on the state
        let diff = maxSize - minSize
        guard diff > 0.1 else {
            switch state {
            case .tooSmall:
                return maxSize
            default:
                return minSize
            }
        }
        
        switch state {
        case .fit: return fontSize
        case .tooBig: return binarySearch(string: string, minSize: minSize, maxSize: fontSize, size: size, constraintSize: constraintSize)
        case .tooSmall: return binarySearch(string: string, minSize: fontSize, maxSize: maxSize, size: size, constraintSize: constraintSize)
        }
    }
    
    func singleLineSizeState(rect: CGRect, size: CGSize) -> FontSizeState {
        if rect.width >= size.width + 10 && rect.width <= size.width {
            return .fit
        } else if rect.width > size.width {
            return .tooBig
        } else {
            return .tooSmall
        }
    }
    
    func multiLineSizeState(rect: CGRect, size: CGSize) -> FontSizeState {
        // if rect within 10 of size
        if rect.height < size.height + 10 &&
            rect.height > size.height - 10 &&
            rect.width > size.width + 10 &&
            rect.width < size.width - 10 {
            return .fit
        } else if rect.height > size.height || rect.width > size.width {
            return .tooBig
        } else {
            return .tooSmall
        }
    }
    
}
#endif
