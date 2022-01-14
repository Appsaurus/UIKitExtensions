//
//  ContentView.swift
//  UIKitExtensionsDemo (WatchOS) WatchKit Extension
//
//  Created by Brian Strobach on 1/14/22.
//

import SwiftUI
import UIKitExtensions

struct ContentView: View {
    var body: some View {
        Text(UIKitExtensionsClass().text)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
