# azumio-connect-ios
Unofficial Azumion Connect - Enables heart rate measurements in your app. see http://developer.azumio.com/ios/azumio-connect

## Usage:
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
si.modula.instantheartrate.free
si.modula.instantheartrate.pro
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
