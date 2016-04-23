//
//  Thing.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 15/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Foundation
import ObjectMapper

public class Thing: Mappable {
    public var thingId: String?
    public var acl: [String: Acl]? = [:]
    public var attributes: [String: AnyObject]? = [:]
    public var features: [String: Feature]? = [:]
    
    public init() {
        
    }
    
    public required init?(_ map: Map) {
        
    }

    public func mapping(map: Map) {
        thingId <- map["thingId"]
        acl <- map["acl"]
        attributes <- map["attributes"]
        features <- map["features"]
    }
}

