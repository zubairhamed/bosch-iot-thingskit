//
//  Solution.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 15/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Foundation
import ObjectMapper

public class Solution: Mappable {
    var solutionId: String?
    var apiToken: String?
    var plan: String?
    var customer: Customer?
    var namespaces: [String: Namespace]?
    
    public init() {
        
    }
    
    public required init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        solutionId <- map["solutionId"]
        apiToken <- map["apiToken"]
        plan <- map["plan"]
        customer <- map["customer"]
        namespaces <- map["namespaces"]
    }    
}

