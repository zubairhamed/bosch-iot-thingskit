
//
//  Namespace.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 15/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Foundation
import ObjectMapper

public class Namespace: Mappable {
    var name: String?
    var defaultNamespace: Bool?
    
    public init() {
        
    }
    
    public required init?(_ map: Map) {
        
    }

    public func mapping(map: Map) {
        name <- map["name"]
        defaultNamespace <- map["default"]
    }
    
}