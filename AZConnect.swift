//
//  AZConnect.swift
//  ActivityTracker
//
//  Created by Danny Shmueli on 20/12/2015.
//  Copyright © 2015 Metaflow. All rights reserved.
//

import UIKit

class AZConnect: NSObject {
    static let instance  = AZConnect()
    
    var callbackBlock:( (heartRate:Double, NSError?) -> () )?
    var schema:String?
    
    func isCharADigit(c:Character) -> Bool{
        return "0"..."9" ~= c
    }
    
    func measureHeartRate(){
        let urlPro = NSURL(string: "instantheartrate.pro:?callback=\(schema!):?heartrate=!HR!")
        let urlFree = NSURL(string: "instantheartrate:?callback=\(schema!):?heartrate=!HR!")
        let urlNoApp = NSURL(string: "https://itunes.apple.com/app/instant-heart-rate-heart-rate/id409625068?mt=8#")
        
        let app = UIApplication.sharedApplication()
        if (app.canOpenURL(urlPro!)){
            app.openURL(urlPro!)
        }else if(app.canOpenURL(urlFree!)){
            app.openURL(urlFree!)
        }else{
            app.openURL(urlNoApp!)
        }
    }
    
    func openURL(url:NSURL){
        let query = NSString(string: url.absoluteString)
        var r = query.rangeOfString("heartrate=")
        if (r.location == NSNotFound){
            self.callbackBlock!(heartRate: 0,NSError(domain: "No heart rate", code: 0, userInfo: nil))
            return
        }
        r.location = r.location + 10
        r.length = 0
        
        while (r.location + r.length < query.length && isCharADigit(Character(UnicodeScalar(query.characterAtIndex(NSMaxRange(r)))))){
            r.length++
        }
        let hr = query.substringWithRange(r)
        let hrd = Double(hr)
        if (self.callbackBlock != nil){
            self.callbackBlock!(heartRate: hrd!,nil)
        }
        
    }
}
