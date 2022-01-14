//
//  String+SpellCheck.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/19/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension String {
    
    /// Swiftest: Check if the given string spelled correctly
    public var isSpelledCorrectly: Bool {
        return rangeOfMispelledWord.location == NSNotFound
    }

    public var rangeOfMispelledWord: NSRange {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: self,
                                                            range: range,
                                                            startingAt: 0,
                                                            wrap: false,
                                                            language: Locale.preferredLanguages.first ?? "en")
        return misspelledRange
    }
    
}
#endif
