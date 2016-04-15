//
//  Subscription.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 15/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Foundation
import JSONHelper

public struct Subscription: Deserializable {
    var id: String = ""
    var target: String = ""
    
    public init() {
        
    }

    public init(data: [String: AnyObject]) {
        id <-- data["id"]
        target <-- data["target"]
    }
}
