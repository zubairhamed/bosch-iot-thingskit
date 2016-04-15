//
//  Solution.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 15/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Foundation
import JSONHelper

public struct Solution: Deserializable {
    var solutionId: String = ""
    var apiToken: String = ""
    var plan: String = ""
    var customer: Customer = Customer()
    var namespaces: [String: Namespace] = [:]
    
    public init() {
        
    }

    public init(data: [String: AnyObject]) {
        solutionId <-- data["solutionId"]
        apiToken <-- data["apiToken"]
        plan <-- data["plan"]
        customer <-- data["customer"]
        namespaces <-- data["namespaces"]
    }
}

