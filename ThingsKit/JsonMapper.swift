//
//  JsonDeserializer.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 17/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Alamofire
import ObjectMapper

public class JsonDeserializer {
    public static func parseResult(response: Response<AnyObject, NSError>) -> Result {
        return Mapper<Result>().map(getJsonString(response))!
    }
    
    public static func parseThings(response: Response<AnyObject, NSError>) -> [Thing] {
        return Mapper<Thing>().mapArray(getJsonString(response))!
    }
    
    public static func parseThing(response: Response<AnyObject, NSError>) -> Thing {
        return Mapper<Thing>().map(getJsonString(response))!
    }
    
    public static func parseAclDict(response: Response<AnyObject, NSError>) -> [String: Acl] {
        return Mapper<Acl>().mapDictionary(getJsonString(response))!
    }
    
    public static func parseAcl(response: Response<AnyObject, NSError>) -> Acl {
        return Mapper<Acl>().map(getJsonString(response))!
    }
        
    private static func getJsonString(response: Response<AnyObject, NSError>) -> String {
        return String(data: response.data!, encoding: NSUTF8StringEncoding)!
    }
}
