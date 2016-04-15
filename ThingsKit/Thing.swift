//
//  Thing.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 15/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Foundation
import JSONHelper

public struct Thing: Deserializable {
    var thingId: String = ""
    var acl: [String: Acl] = [:]
    var attributes: [String: AnyObject] = [:]
    var features: [String: Feature] = [:]
    
    public init() {
        
    }

    public init(data: [String: AnyObject]) {
        thingId <-- data["thingId"]
        acl <-- data["acl"]
        attributes <-- data["attributes"]
        features <-- data["features"]
    }
}

