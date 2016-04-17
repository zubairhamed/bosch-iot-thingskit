//
//  Query.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 15/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Foundation

public class Query {
    var filter: String = ""
    var options: [String] = [String]()
    var fields: [String] = [String]()
    var limit: Int = 25    
    
    public init() {
        
    }
}