# iOS.Conf 
iOS.Conf by Taxibeat app ⌚️📱

##Requirements for running the project
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

![CloudKit config](https://dl.dropboxusercontent.com/u/43740014/cloudkit.png)

Open `CloudKitManager.swift` and paste your indentifier in the `cloudKitContainerIdentifier` constant:

``````````swift
struct CloudKitConstants {
    static let cloudKitContainerIdentifier = "iCloud.com.taxibeat.iOSConf"
}
````````

Create some records in the Public database using CloudKit dashboard and run the app. Not that you have to create the schema and the records on the CloudKit Development environment for being able to fetch data when running the app in debug mode through Xcode.
