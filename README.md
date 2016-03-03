# azumio-connect-ios
Unofficial Azumion Connect for Swift - Enables heart rate measurements in your app. see http://developer.azumio.com/ios/azumio-connect

## Usage:
Add app url scheme (`CFBundleURLTypes`) to your app info.plist - I recommend using value in the bundle identiefier (`$(PRODUCT_BUNDLE_IDENTIFIER)`) 

In your app delegate:
```swift
func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
  AZConnect.instance.openURL(url)
  return true
}
```

Allow your app to use canOpenUrl for the following schemes by adding `LSApplicationQueriesSchemes` to your `Info.plist`:
```
instantheartrate
instantheartrate.pro
```

Then when you want to measure heart rate:
```swift
AZConnect.instance.schema = NSBundle.mainBundle().bundleIdentifier!
AZConnect.instance.callbackBlock = {
  (heartRate:Double, error:NSError?) in
  if (heartRate == 0 || error != nil ){
    //TODO: do something with the error
    return
  }
  print("heartRate: \(heartRate)")
}
AZConnect.instance.measureHeartRate()
```
