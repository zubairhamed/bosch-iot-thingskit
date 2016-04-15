
//
//  SearchResult.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 15/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Foundation
import JSONHelper

public struct SearchResult: Deserializable {
    var items: [Thing] = []
    var nextPageOffset: UInt = 0
    
    public init() {
        
    }

    public init(data: [String: AnyObject]) {
        items <-- data["items"]
        nextPageOffset <-- data["nextPageOffset"]
    }
}

