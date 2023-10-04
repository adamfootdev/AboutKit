# AboutKit

![Feature Graphic](https://github.com/adamfootdev/AboutKit/blob/main/Assets/feature-graphic.png?raw=true)
![Platform](https://img.shields.io/badge/platforms-iOS%2FiPadOS%2015.0%2B%20%7C%20macOS%2013.0%2B%20%7C%20tvOS%2015.0%2B%20%7C%20watchOS%208.0%2B-blue)

AboutKit provides developers for Apple platforms with the ability to add an About screen to their apps. This built using SwiftUI so can be displayed natively from a SwiftUI app or using a UIHostingController in a UIKit app.

This has been localised into multiple languages and the buttons will automatically adapt to your appʼs accent color.

For users who previously used AboutKit for showing the features list, please use [FeaturesKit](https://github.com/adamfootdev/FeaturesKit).

1. [Requirements](#requirements)
2. [Integration](#integration)
3. [Usage](#usage)
    - [AKConfiguration](#akconfiguration)
    - [AKMyApp](#akmyapp)
    - [AKDeveloper](#akdeveloper)
    - [AKFeatureItem](#akfeatureitem)
    - [AKOtherApp](#akotherapp)
    - [AKAcknowledgements](#akacknowledgements)
    - [AKPersonAcknowledgement](#akpersonacknowledgement)
    - [AKFrameworkAcknowledgement](#akframeworkacknowledgement)
    - [AboutAppView](#aboutappview)
4. [Other Packages](#other-packages)
    - [FeaturesKit](https://github.com/adamfootdev/FeaturesKit)
    - [HelpKit](https://github.com/adamfootdev/HelpKit)

## Requirements

- iOS/iPadOS 15.0+
- macOS 13.0+
- tvOS 15.0+
- watchOS 8.0+
- Xcode 12.0+

## Integration

### Swift Package Manager

AboutKit can be added to your app via Swift Package Manager in Xcode. Add to your project like so:

```swift
dependencies: [
    .package(url: "https://github.com/adamfootdev/AboutKit.git", from: "3.0.0")
]
```

## Usage

To start using the framework, you'll need to import it first:

```swift
import AboutKit
```

### AKConfiguration

This is a struct containing all of the relevant details required to configure AboutKit. It can be created like so:

```swift
let configuration = AKConfiguration(
    app: app, 
    otherApps: otherApps, 
    showShareApp: .always, 
    showWriteReview: .always
)
```

### AKMyApp

This is a struct containing details about the current app. It can be created like so:

```swift
let app = AKMyApp(
    id: "123456789", 
    name: "Example App", 
    appIcon: UIImage(named: "app-icon"), 
    developer: developer, 
    email: "exampleapp@example.com", 
    websiteURL: URL(string: "https://www.example.com")!, 
    profiles: [profile], 
    privacyPolicyURL: URL(string: "https://www.example.com/privacy-policy")!, 
    termsOfUseURL: URL(string: "https://www.example.com/terms-of-use")!, 
    testFlightURL: URL(string: "https://www.example.com/testflight")!, 
    acknowledgements: acknowledgements
)
```

If a value for the app icon is not provided, one will attempt to be downloaded from the App Store based on the provided app ID. The app ID can be found in App Store Connect or from the app's URL, e.g. <https://apps.apple.com/app/id123456789>

### AKDeveloper

This is a struct containing details about the developer belonging to the current app. It can be created like so:

```swift
let developer = AKDeveloper(
    id: "987654321", 
    name: "App Developer", 
    profiles: [profile]
)
```

The developer ID can be found by locating the App Store page that contains all of your apps e.g. <https://apps.apple.com/developer/id987654321>

### AKProfile

This is a struct containing details about about a social media profile relating to either the developer or the app itself. It supports multiple platforms such as X and Mastodon. It can be created like so:

```swift
let profile = AKProfile(
    username: "appdeveloper", 
    platform: .reddit
)
```

### AKOtherApp

This is a struct which contains details to display another app that you own and want to show in a list on the about screen. You can create one as follows:

```swift
let otherApp = AKOtherApp(
    id: "543216789",
    name: "Other App",
    appIcon: UIImage(named: "app-icon")
)
```

If a value for the app icon is not provided, one will attempt to be downloaded from the App Store based on the provided app ID. The app ID can be found in App Store Connect or from the app's URL, e.g. <https://apps.apple.com/app/id123456789>

### AKAcknowledgements

This is a struct which contains details about frameworks and people youʼd like to acknowledge. You can create one as follows:

```swift
let acknowledgements = AKAcknowledgements(
    people: [person],
    frameworks: [framework]
)
```

### AKPersonAcknowledgement

This is a struct which contains details about a person youʼd like to acknowledge. You can create one as follows:

```swift
let person = AKPersonAcknowledgement(
    name: "App Developer",
    details: "Some details about this person!",
    profiles: [profile]
)
```

### AKFrameworkAcknowledgement

This is a struct which contains details about a framework youʼd like to acknowledge. You can create one as follows:

```swift
let framework = AKFrameworkAcknowledgement(
    name: "Framework",
    details: "Some details about this framework!",
    links: [.productPage(URL(string: "https://www.example.com")!)]
)
```

### AboutAppView

Create an instance of the view using the following:

```swift
AboutAppView(configuration: configuration)
```

## Other Packages

### [FeaturesKit](https://github.com/adamfootdev/FeaturesKit)

Add a features list screen to your app.

### [HelpKit](https://github.com/adamfootdev/HelpKit)

Add a help screen to your app.
