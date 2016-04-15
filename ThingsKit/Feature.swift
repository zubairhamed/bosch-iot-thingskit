//
//  Feature.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 15/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Foundation
import JSONHelper

public struct Feature: Deserializable {
    var properties: [String: AnyObject] = [:]
    
    public init() {
        
    }
    
    public init(data: [String: AnyObject]) {
        properties <-- data["properties"]
    }
}