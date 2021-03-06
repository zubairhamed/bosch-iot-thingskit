
//
//  Customer.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 15/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Foundation
import ObjectMapper

public class Customer: Mappable {
    var name: String?
    var email: String?
    var info: String?
    
    public init() {
        
    }
    
    public required init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        name <- map["name"]
        email <- map["email"]
        info <- map["info"]
    }    
}
