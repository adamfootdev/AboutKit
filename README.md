# AboutKit

AboutKit provides developers with the ability to add an About, Features List or Welcome screen to an app. All of the screens are built using SwiftUI so can be displayed natively from a SwiftUI app or using a UIHostingController in a UIKit app.

The views have been localised into a few other languages too. The button colors adapt to the accent color of your app, or can be customised using the .accentColor SwiftUI view modifier.

## Installation

### Swift Package Manager

AboutKit can be added to your app via Swift Package Manager in Xcode. Simply add this URL to your Xcode project:

    https://github.com/AdamFootDev/AboutKit.git

## Usage

AboutKit provides three different views for you to add to your app. To start using the framework, you'll need to import the framework first:

    import AboutKit

These views rely on passing in one or more created custom structs. These could be:

### AKApp

This is a struct containing details about the current app. It can be created like so:

    let app = AKApp(id: "123456789", name: "App Name", appIcon: UIImage(named: "app-icon"), developer: developer, email: "app@example.com", twitterHandle: "AppName", websiteURL: "https://www.example.com", privacyPolicyURL: "https://www.example.com/privacy-policy")

If a value for the app icon is not provided, one will attempt to be downloaded from the App Store based on the provided app ID. The app ID can be found in App Store Connect or from the app's URL e.g. <https://apps.apple.com/app/id123456789>

See below for details on creating an AKDeveloper.

### AKDeveloper

This is a struct containing details about the developer belonging to the current app. It can be created like so:

    let developer = AKDeveloper(id: "987654321", name: "App Developer", twitterHandle: "AppDeveloper")

The Twitter handle should be without the '@'. The developer ID can be found by locating the App Store page that contains all of your apps e.g. <https://apps.apple.com/developer/id987654321>

### AKFeatureItem

This is a struct containing details relating to items that appear on a feature list screen. It can be created as follows:

    let featureItem = AKFeatureItem(title: "New Feature", description: "This is a cool new feature.", systemImage: "checkmark.circle", imageTint: .green)

The imageTint value is optional and will default to the accent color if not provided.

### AKOtherApp

This is a struct which contains details to display another app that you own and want to show in a list on the about screen. You can create one as follows:

    let otherApp = AKOtherApp(id: "543216789", name: "Other App")

### About Example

There are two variations of the About view: with or without a navigation bar.

#### Without Navigation Bar Example

The version without the navigation bar enables the view to be embedded in a navigation stack or can be dismissed with the standard swipe gesture if opened as a sheet. Create an instance of the view using the following:

    AboutAppView(app: app, otherApps: otherApps)

See above for details on creating an AKApp and AKOtherApp.

#### With Navigation Bar Example

The version with a navigation bar provides the system navigation bar with a done button. The title display mode can also be customised to fit your app. Create an instance of the view using the following:

    AboutAppWithNavigationView(app: app, otherApps: otherApps)

Or, to customise the title display mode (it defaults to inline) with the following:

    AboutAppWithNavigationView(app: app, otherApps: otherApps, titleDisplayMode: .large)

See above for details on creating an AKApp and AKOtherApp.

### Features List Example

The Features List view allows you to display a list of customisable features that are available in your app with a custom title at the top. You can also provide an optional completion block when the Continue button is tapped. Create an instance of the view using the following:

    FeaturesView(title: "What's New in App", featureItems: featureItems) {
        print("Continue button tapped")
    }

See above for details on creating an AKFeatureItem.

### Welcome Example

The Welcome view allows you to display a list of customisable features that are available in your app with a bold title saying Welcome to App Name. You can also provide an optional completion block when the Continue button is tapped. Create an instance of the view using the following:

    WelcomeView(app: app, featureItems: featureItems) {
        print("Continue button tapped")
    }

See above for details on creating an AKApp and AKFeatureItem.
