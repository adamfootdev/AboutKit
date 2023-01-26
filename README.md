# AboutKit

![Feature Graphic](https://github.com/adamfootdev/AboutKit/blob/main/Assets/feature-graphic.png?raw=true)
![Platform](https://img.shields.io/badge/platforms-iOS%2015.0%2B%20%7C%20watchOS%208.0%2B%20%7C%20tvOS%2015.0%2B-blue)

AboutKit provides developers with the ability to add an About, Features List or Welcome screen to an app. All of the screens are built using SwiftUI so can be displayed natively from a SwiftUI app or using a UIHostingController in a UIKit app.

The views have been localised into a few other languages too. The button colors adapt to the accent color of your app, or can be customized using the .accentColor SwiftUI view modifier.

All screens are supported on iOS/iPadOS and there is the ability to add the About screen to a watchOS or tvOS app as well. The Features List can be added to tvOS.

1. [Requirements](#requirements)
2. [Integration](#integration)
3. [Usage](#usage)
    - [AKMyApp](#akmyapp)
    - [AKDeveloper](#akdeveloper)
    - [AKFeatureItem](#akfeatureitem)
    - [AKOtherApp](#akotherapp)
    - [About Example](#about-example)
    - [Features List Example](#features-list-example)
    - [Welcome Example](#welcome-example)

## Requirements

- iOS 15+
- watchOS 8+
- tvOS 15+
- Xcode 12+

## Integration

### Swift Package Manager

AboutKit can be added to your app via Swift Package Manager in Xcode. Add to your project like so:

```swift
dependencies: [
    .package(url: "https://github.com/adamfootdev/AboutKit.git", from: "1.0.0")
]
```

## Usage

AboutKit provides three different views for you to add to your app. To start using the framework, you'll need to import the framework first:

```swift
import AboutKit
```

These views rely on passing in one or more created custom structs. These could be:

### AKMyApp

This is a struct containing details about the current app. It can be created like so:

```swift
let app = AKMyApp(id: "123456789", name: "App Name", appIcon: UIImage(named: "app-icon"), developer: developer, email: "app@example.com", profiles: [profile], websiteURL: "https://www.example.com", privacyPolicyURL: "https://www.example.com/privacy-policy", termsOfUseURL: "https://www.example.com/terms-of-use"))
```

If a value for the app icon is not provided, one will attempt to be downloaded from the App Store based on the provided app ID. The app ID can be found in App Store Connect or from the app's URL e.g. <https://apps.apple.com/app/id123456789>

See below for details on creating an AKDeveloper.

### AKDeveloper

This is a struct containing details about the developer belonging to the current app. It can be created like so:

```swift
let developer = AKDeveloper(id: "987654321", name: "App Developer", profiles: [profile])
```

The developer ID can be found by locating the App Store page that contains all of your apps e.g. <https://apps.apple.com/developer/id987654321>

### AKProfile

This is a struct containing details about about a social media profile relating to either the developer or the app itself. It supports multiple platforms such as Twitter and Mastodon. It can be created like so:

```swift
let profile = AKProfile(username: "appdeveloper", platform: .twitter)
```

The developer ID can be found by locating the App Store page that contains all of your apps e.g. <https://apps.apple.com/developer/id987654321>

### AKFeatureItem

This is a struct containing details relating to items that appear on a feature list screen. It can be created as follows:

```swift
let featureItem = AKFeatureItem(title: "New Feature", description: "This is a cool new feature.", systemImage: "checkmark.circle", imageTint: .green)
```

The imageTint value is optional and will default to the accent color if not provided.

### AKOtherApp

This is a struct which contains details to display another app that you own and want to show in a list on the about screen. You can create one as follows:

```swift
let otherApp = AKOtherApp(id: "543216789", name: "Other App", appIcon: UIImage(named: "app-icon"))
```

If a value for the app icon is not provided, one will attempt to be downloaded from the App Store based on the provided app ID. The app ID can be found in App Store Connect or from the app's URL e.g. <https://apps.apple.com/app/id123456789>

### About Example

Create an instance of the view using the following:

```swift
AboutAppView(app: app, otherApps: otherApps)
```

See above for details on creating an AKApp and AKOtherApp.

### Features List Example

The Features List view allows you to display a list of customisable features that are available in your app with a custom title at the top. You can also provide an optional completion block when the Continue button is tapped. Create an instance of the view using the following:

```swift
FeaturesView(title: "What's New in App", featureItems: featureItems) {
    print("Continue button tapped")
}
```

See above for details on creating an AKFeatureItem.

### Welcome Example

The Welcome view allows you to display a list of customisable features that are available in your app with a bold title saying Welcome to App Name. You can also provide an optional completion block when the Continue button is tapped. Create an instance of the view using the following:

```swift
WelcomeView(app: app, featureItems: featureItems) {
    print("Continue button tapped")
}
```

See above for details on creating an AKApp and AKFeatureItem.
