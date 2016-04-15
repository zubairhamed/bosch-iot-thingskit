//
//  ResponseError.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 15/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Foundation
import JSONHelper

public struct ResponseError: Deserializable {
    var status: UInt = 0
    var error: String = ""
    var message: String = ""
    var description: String = ""
    var href: String = ""
    
    public init() {
        
    }

    public init(data: [String: AnyObject]) {
        status <-- data["status"]
        error <-- data["error"]
        message <-- data["message"]
        description <-- data["description"]
        href <-- data["href"]
    }
}

