
//
//  Customer.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 15/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Foundation
import JSONHelper

public struct Customer: Deserializable {
    var name: String = ""
    var email: String = ""
    var info: String = ""
    
    public init() {
        
    }
    
    public init(data: [String: AnyObject]) {
        name <-- data["name"]
        email <-- data["email"]
        info <-- data["info"]
    }
}
