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
