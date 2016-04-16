//
//  Feature.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 15/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Foundation
import ObjectMapper

public class Feature: Mappable {
    var properties: [String: AnyObject]?
    
    public init() {
        
    }
    
    public required init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        properties <- map["properties"]
    }
}