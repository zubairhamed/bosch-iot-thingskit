//
//  ErrorResponse.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 16/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Foundation
import ObjectMapper

public class Result: Mappable {
    var code: Int = 0
    var status: Int = 0
    var error: String = ""
    var message: String = ""
    var description: String = ""
    var href: String = ""
    
    public init() {
        
    }

    public init(code: Int) {
        self.code = code
    }
    
    public required init?(_ map: Map) {
        
    }
    
    public func mapping(map: Map) {
        
    }
    
    public func isError() -> Bool {
        if code >= 400 && code < 500 {
            return true
        }
        return false
    }
    
    public func isSuccess() -> Bool {
        if code >= 200 && code < 300 {
            return true
        }
        return false
    }
}

