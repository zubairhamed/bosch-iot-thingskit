//
//  ResponseError.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 15/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Foundation
import ObjectMapper

public class ResponseError: Mappable {
    var status: UInt?
    var error: String?
    var message: String?
    var description: String?
    var href: String?
    
    public init() {
        
    }
    
    public required init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        status <- map["status"]
        error <- map["error"]
        message <- map["message"]
        description <- map["description"]
        href <- map["href"]
    }
}

