
//
//  Relation.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 15/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Foundation
import JSONHelper

public struct Relation: Deserializable {
    var relationId: String = ""
    var acl: [String: Acl] = [:]
    var source: String = ""
    var target: String = ""
    var attributes: [String: AnyObject] = [:]
    
    public init() {
        
    }

    public init(data: [String: AnyObject]) {
        relationId <-- data["relationId"]
        acl <-- data["acl"]
        source <-- data["source"]
        target <-- data["target"]
        attributes <-- data["attributes"]
    }
}

