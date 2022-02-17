# UIKitExtensions

<!-- Header Logo -->

<!-- <div align="center">
   <img width="600px" src="./Extras/banner-logo.png" alt="Banner Logo">
</div> -->


<!-- Badges -->

<p>
    <img src="https://img.shields.io/badge/Swift-5.5-F06C33.svg" />
    <img src="https://img.shields.io/badge/iOS-10.0+-865EFC.svg" />
    <img src="https://img.shields.io/badge/iPadOS-15.0+-F65EFC.svg" />
<!--     <img src="https://img.shields.io/badge/macOS-12.0+-179AC8.svg" /> -->
    <img src="https://img.shields.io/badge/tvOS-15.0+-41465B.svg" />
    <img src="https://img.shields.io/badge/watchOS-8.0+-1FD67A.svg" />
    <img src="https://img.shields.io/badge/License-MIT-blue.svg" />
    <img src="https://github.com/Apppsaurus/UIKitExtensions/workflows/Build%20&%20Test/badge.svg" />
    <a href="https://github.com/apple/swift-package-manager">
      <img src="https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat" />
    </a>
</p>


<p align="center">

_Description + docs coming soon_

<p />


## Installation

### Xcode Projects

Select `File` -> `Swift Packages` -> `Add Package Dependency` and enter `https://github.com/Apppsaurus/UIKitExtensions`.


### Swift Package Manager Projects

You can add `UIKitExtensions` as a package dependency in your `Package.swift` file:

```swift
let package = Package(
    //...
    dependencies: [
        .package(
            name: "UIKitExtensions",
            url: "https://github.com/Apppsaurus/UIKitExtensions"
        ),
    ],
    //...
)
```


<!-- 🔑 UNCOMMENT THE INSTRUCTIONS BELOW IF THE GITHUB REPO NAME MATCHES THE LIBRARY NAME 👇 -->

<!-- From there, refer to `UIKitExtensions` as a "target dependency" in any of _your_ package's targets that need it.

```swift
targets: [
    .target(
        name: "UIKitExtensions",
        dependencies: [
          "UIKitExtensions",
        ],
        ...
    ),
    ...
]
``` -->

<!-- 🔑 UNCOMMENT THE INSTRUCTIONS BELOW IF THE GITHUB REPO NAME DOESN'T MATCH THE LIBRARY NAME 👇 -->

From there, refer to the `UIKitExtensions` "product" delivered by the `UIKitExtensions` "package" inside of any of your project's target dependencies:

```swift
targets: [
    .target(
        name: "UIKitExtensions",
        dependencies: [
            .product(
                name: "UIKitExtensions",
                package: "UIKitExtensions"
            ),
        ],
        ...
    ),
    ...
]
```

<!-- Proceed from above choice accordingly (and delete this comment) -->

Then simply `import UIKitExtensions` wherever you’d like to use it.


<!--
    🔑 UNCOMMENT THE INSTRUCTIONS BELOW IF USING THE `@_exported` feature
    might be handy. 👇
-->

<!-- **📝 Note:** To make the library available to your entire project, you could also leverage the [functionality of the `@_exported` keyword](https://forums.swift.org/t/package-manager-exported-dependencies/11615) by placing the following line somewhere at the top level of your project:

```swift
@_exported import UIKitExtensions
``` -->


## Usage


### Requirements

- Xcode 13.0+


### 📜 Creating & Building Documentation

Documentation is built with [Xcode's DocC](https://developer.apple.com/documentation/docc). See [Apple's guidance on how to build, run, and create DocC content](https://developer.apple.com/documentation/docc/api-reference-syntax).


## 🏷 License

`UIKitExtensions` is available under the MIT license. See the [LICENSE file](./LICENSE) for more info.
