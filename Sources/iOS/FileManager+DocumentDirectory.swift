//
//  UIApplication+DocumentDirectory.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/26/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import UIKit
import Swiftest

public extension FileManager {
    public var documentsDirectory: URL {
        return urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    public func emptyDocumentsDirectory() throws {
        let directoryPath = documentsDirectory.absoluteString
        
        guard let directoryContents = try? contentsOfDirectory(atPath: directoryPath) else { return }
        
        for path in directoryContents {
            let fullPath = directoryPath.appendingPathComponent(path)
            try removeItem(atPath: fullPath)
        }
    }
}

extension URL {
    public static var documentsDirectory: URL {
        return FileManager.default.documentsDirectory
    }
}
#endif
