
//
//  Relation.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 15/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Foundation
import ObjectMapper

public class Relation: Mappable {
    var relationId: String?
    var acl: [String: Acl]?
    var source: String?
    var target: String?
    var attributes: [String: AnyObject]?
    
    public init() {
        
    }
    
    public required init?(_ map: Map) {
        
    }

    public func mapping(map: Map) {
        relationId <- map["relationId"]
        acl <- map["acl"]
        source <- map["source"]
        target <- map["target"]
        attributes <- map["attributes"]
    }    
}

