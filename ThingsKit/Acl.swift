
//
//  Acl.swift/Users/zubair/Documents/workspace/xcode/ThingsKit/ThingsKitTests/ThingsKitTests.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 15/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Foundation
import ObjectMapper

public class Acl: Mappable {
    var READ: Bool?
    var WRITE: Bool?
    var ADMINISTRATE: Bool?
    
    public init() {
        
    }
    
    public required init?(_ map: Map) {
        
    }
        
    public init(read: Bool, write: Bool, administrate: Bool) {
        self.READ = read
        self.WRITE = write
        self.ADMINISTRATE = administrate
    }
    
    public func mapping(map: Map) {
        READ <- map["READ"]
        WRITE <- map["WRITE"]
        ADMINISTRATE <- map["ADMINISTRATE"]
    }    
}

