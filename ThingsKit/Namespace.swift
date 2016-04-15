
//
//  Namespace.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 15/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Foundation
import JSONHelper

public struct Namespace: Deserializable {
    var name: String = ""
    var defaultNamespace: Bool = false
    
    public init() {
        
    }

    public init(data: [String: AnyObject]) {
        name <-- data["name"]
        defaultNamespace <-- data["default"]
    }
}