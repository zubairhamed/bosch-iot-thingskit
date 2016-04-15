
//
//  Acl.swift/Users/zubair/Documents/workspace/xcode/ThingsKit/ThingsKitTests/ThingsKitTests.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 15/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Foundation
import JSONHelper

public struct Acl: Deserializable {
    var READ: Bool = false
    var WRITE: Bool = false
    var ADMINISTRATE: Bool = false
    
    public init() {
        
    }

    public init(data: [String: AnyObject]) {
        READ <-- data["READ"]
        WRITE <-- data["WRITE"]
        ADMINISTRATE <-- data["ADMINISTRATE"]
    }
}

