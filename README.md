# iOS.Conf 
iOS.Conf by Taxibeat app ⌚️📱

## Requirements for running the project
In order to build and run the project you need:
* Xcode 8
* A paid membership in the Apple developer program

## Steps for configuring CloudKit
* Add a custom bundle identifier to the Xcode project
* Login to [CloudKit Dashboard](https://icloud.developer.apple.com/dashboard)
* Create two record types, one named `Speakers` and one named `Talks`
* On the `Speakers` record type, create the following attributes
  * Name (`String`)
  * Position (`String`)
  * Bio (`String`)
  * Avatar (`CKAsset`)
  * Weight (`Int`)
* On the `Talks` record type, create the following fields
  * Description (`String`)
  * hasSpeaker (`Int`)
  * TimeString (`String`)
  * Weight (`Int`)
  * Speaker (`String`)
  * SpeakerPosition (`String`)
*  Make sure that iCloud capability and CloudKit are turned on as shown in the image below and copy the container identifier.

![CloudKit config](https://www.dropbox.com/s/zgs1afqnj9fjzaa/cloudkit.png?raw=1)

Open `CloudKitManager.swift` and paste your indentifier in the `cloudKitContainerIdentifier` constant:

``````````swift
struct CloudKitConstants {
    static let cloudKitContainerIdentifier = "iCloud.com.taxibeat.iOSConf"
}
``````````

Create some records in the Public database using CloudKit dashboard and run the app. Note that you have to create the schema and the records on the CloudKit Development environment for being able to fetch data when running the app in debug mode through Xcode.

The iOS app supports iOS 9 or higher and the watchOS app supports watchOS 3 or higher. According to Xcode release notes, CloudKit is not supported in the watchOS simulator:

>CloudKit usage is blocked on watchOS Simulators. Running any test will throw a “Not Authenticated” error even though you are signed in via the paired iOS Simulator. Workaround: Use CloudKit on paired devices with watchOS 3 and iOS 10.

If you want to run and play with the watchOS app you have to do it on a real device.
