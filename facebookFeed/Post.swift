//
//  Post.swift
//  facebookFeed
//
//  Created by Tihomir Videnov on 11/27/16.
//  Copyright © 2016 Tihomir Videnov. All rights reserved.
//

import UIKit

class Post: SafeJSONObject {
    
    var name: String?
    var postStatusText: String?
    var profileImageName: String?
    var location: Location?
    var statusImageName: String?
    var numLikes: NSNumber?
    var numComments: NSNumber?
    
    var statusImageUrl: String?
    
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "location" {
            location = Location()
            location?.setValuesForKeys(value as! [String:Any])
            
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
}

class Location: NSObject {
    
    var city: String?
    var state: String?
    
}

class SafeJSONObject: NSObject {
    
    override func setValue(_ value: Any?, forKey key: String) {
        let selectorString = "set\(key.uppercased().characters.first!)\(String(key.characters.dropFirst())):"
        let selector = Selector("\(selectorString)")
        if responds(to: selector) {
            super.setValue(value, forKey: key)
        }
    }
}
