import XCTest
@testable import UIKitExtensions

class SharedTests: XCTestCase {

    #if !os(tvOS) && !os(watchOS)
    func testBold() {
        let boldString = "hello".bold
        // swiftlint:disable next legacy_constructor
        let attrs = boldString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, boldString.length))
        XCTAssertNotNil(attrs[NSAttributedString.Key.font])
        
        #if os(macOS)
        guard let font = attrs[.font] as? NSFont else {
            XCTFail("Unable to find font in testBold")
            return
        }
        XCTAssertEqual(font, NSFont.boldSystemFont(ofSize: NSFont.systemFontSize))
        #elseif os(iOS)
        guard let font = attrs[NSAttributedString.Key.font] as? UIFont else {
            XCTFail("Unable to find font in testBold")
            return
        }
        XCTAssertEqual(font, UIFont.boldSystemFont(ofSize: UIFont.systemFontSize))
        #endif
    }
    #endif
    
    func testUnderline() {
        let underlinedString = "hello".underline
        // swiftlint:disable legacy_constructor
        let attrs = underlinedString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, underlinedString.length))
        // swiftlint:enable legacy_constructor
        XCTAssertNotNil(attrs[NSAttributedString.Key.underlineStyle])
        guard let style = attrs[NSAttributedString.Key.underlineStyle] as? Int else {
            XCTFail("Unable to find style in testUnderline")
            return
        }
        XCTAssertEqual(style, NSUnderlineStyle.single.rawValue)
    }
    
    func testStrikethrough() {
        let strikedthroughString = "hello".strikethrough
        // swiftlint:disable next legacy_constructor
        let attrs = strikedthroughString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, strikedthroughString.length))
        XCTAssertNotNil(attrs[NSAttributedString.Key.strikethroughStyle])
        guard let style = attrs[NSAttributedString.Key.strikethroughStyle] as? NSNumber else {
            XCTFail("Unable to find style in testStrikethrough")
            return
        }
        XCTAssertEqual(style, NSNumber(value: NSUnderlineStyle.single.rawValue as Int))
    }
    
    #if os(iOS)
    func testItalic() {
        let italicString = "hello".italic
        // swiftlint:disable next legacy_constructor
        let attrs = italicString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, italicString.length))
        XCTAssertNotNil(attrs[NSAttributedString.Key.font])
        guard let font = attrs[NSAttributedString.Key.font] as? UIFont else {
            XCTFail("Unable to find font in testItalic")
            return
        }
        XCTAssertEqual(font, UIFont.italicSystemFont(ofSize: UIFont.systemFontSize))
    }
    #endif
    
    func testColored() {
        let coloredString = "hello".colored(with: .orange)
        // swiftlint:disable next legacy_constructor
        let attrs = coloredString.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, coloredString.length))
        XCTAssertNotNil(attrs[NSAttributedString.Key.foregroundColor])
        
        #if os(macOS)
        guard let color = attrs[.foregroundColor] as? NSColor else {
            XCTFail("Unable to find color in testColored")
            return
        }
        XCTAssertEqual(color, NSColor.orange)
        #else
        guard let color = attrs[NSAttributedString.Key.foregroundColor] as? UIColor else {
            XCTFail("Unable to find color in testColored")
            return
        }
        XCTAssertEqual(color, UIColor.orange)
        #endif
    }
}
