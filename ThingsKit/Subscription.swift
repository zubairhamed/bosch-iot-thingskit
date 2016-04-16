//
//  Subscription.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 15/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Foundation
import ObjectMapper

public class Subscription: Mappable {
    var id: String?
    var target: String?
    
    public init() {
        
    }
    
    public required init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        target <- map["target"]
    }    
}
