//
//  ThingsKit.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 13/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Alamofire
import SwiftyJSON

private class JsonParser {
    private static func parseAcl(j: [String: JSON]) -> [String: Acl] {
        var aclDict = [String: Acl]()
        
        for (k, v) in j {
            let acl = Acl()
            
            acl.administrate = v["ADMINISTRATE"].boolValue
            acl.read = v["READ"].boolValue
            acl.write = v["WRITE"].boolValue
            
            aclDict[k] = acl
        }
        return aclDict
    }
    
    private static func parseThing(j: JSON) -> Thing {
        let t = Thing()
        t.id = j["thingId"].stringValue
        
        t.acl = parseAcl(j["acl"].dictionaryValue)
        t.attributes = j["attributes"].dictionaryValue
        t.features = j["features"].dictionaryValue
        
        return t
    }
}

public class ThingsKit {
    var user: String
    var password: String
    var token: String
    var endpoint: String
    
    public init(user: String, password: String, token: String, endpoint: String) {
        self.user = user
        self.password = password
        self.token = token
        self.endpoint = endpoint
    }
    
    private func callService(method: Alamofire.Method, frag: String, completion: Response<AnyObject, NSError> -> Void) {
        let headers = [
            "x-cr-api-token": self.token,
            "Content-Type": "application/json",
        ]

        Alamofire.request(method, self.endpoint + frag, headers: headers).authenticate(user: self.user, password: self.password).responseJSON(completionHandler: completion)
    }
    
    public func listThings(ids: [String], completion: (things: [Thing]) -> Void) {
        
        self.callService(Alamofire.Method.GET, frag: "/things?ids=" + ids.joinWithSeparator(",")) {
            response in
            
            let jsonValue = JSON(response.result.value!)
            let len = jsonValue.count
            
            var things = [Thing]()
            for i in 0 ..< len {
                things.append(JsonParser.parseThing(jsonValue[i]))
            }
            completion(things: things)
        }
    }
    
    public func createThing(thing: Thing, completion: (createdThing: Thing) -> Void) {
        
    }
    
    public func deleteThing(id: String, completion: () -> Void) {
        
    }
    
    public func getThing(id: String, completion: (thing: Thing) -> Void) {
        
    }
    
    public func updateThing(id: String, thing: Thing, completion: (updatedThing: Thing) -> Void) {
        
    }
    
    public func listAcl(id: String, completion: (acl: [String: Acl]) -> Void) {
        
    }
    
    public func updateAcl(id: String, acl: Acl, completion: () -> Void) {
        
    }
    
    public func deleteAclEntry(id: String, authSubject: String, completion: () -> Void) {
        
    }
    
    public func getAclEntry(id: String, authSubject: String, completion: () -> Void) {
        
    }
    
    public func updateAclEntry(id: String, authSubject: String, acl: Acl, completion: () -> Void) {
        
    }
    
    public func deleteAttributes(id: String, completion: () -> Void) {
        
    }
    
    public func listAttributes(id: String, completion: () -> Void) {
        
    }
    
    public func updateAttributes(id: String, attributes: [String: JSON], completion: () -> Void) {
        
    }
    
    public func deleteAttribute(id: String, path: String, completion: () -> Void) {
        
    }
    
    public func getAttribute(id: String, path: String, completion: () -> Void) {
        
    }
    
    public func updateAttribute(id: String, path: String, attribute: JSON, completion: () -> Void) {

    }

    public func deleteFeatures(id: String, completion: () -> Void) {
        
    }
    
    public func listFeatures(id: String, completion: () -> Void) {
        
    }
    
    public func updateFeatures(id: String, features: [String: JSON], completion: () -> Void) {
        
    }
    
    public func deleteFeature(id: String, featureId: String, completion: () -> Void) {
        
    }
    
    public func getFeature(id: String, featureId: String, completion: () -> Void) {
        
    }
    
    public func updateFeature(id: String, featureId: String, feature: JSON, completion: () -> Void) {
        
    }
    
    public func deleteFeatureProperties(id: String, featureId: String, completion: () -> Void) {
        
    }
    
    public func listFeatureProperties(id: String, featureId: String, completion: () -> Void) {
        
    }
    
    public func updateFeatureProperties(id: String, featureId: String, properties: [String: JSON], completion: () -> Void) {
        
    }
    
    public func deleteFeatureProperty(id: String, featureId: String, path: String, completion: () -> Void) {
        
    }
    
    public func getFeatureProperty(id: String, featureId: String, path: String, completion: () -> Void) {
        
    }
    
    public func updateFeatureProperty(id: String, featureId: String, path: String, property: JSON, completion: () -> Void) {
        
    }
    
    
    /*
     public func listRelations
     public func createRelation
     public func deleteRelation
     public func getRelation
     public func updateRelation
     public func getRelationAcl
     public func updateRelationAcl
     public func deleteRelationAclEntry
     public func getRelationAclEntry
     public func updateRelationAclEntry
     public func getRelationSource
     public func updateRelationSource
     public func getRelationTarget
     public func updateRelationTarget
     public func deleteRelationAttributes
     public func listRelationAttributes
     public func updateRelationAttributes
     public func deleteRelationAttribute
     public func getRelationAttribute
     public func updateRelationAttribute
     
     public func search
     
     public func claimThing
     public func sendMessageToThing
     public func sendMessageFromThing
     public func sendMessageToThingFeature
     public func sendMessageFromThingFeature
     
     public func listSubscriptions
     public func createSubscription
     public func deleteSubscription
     public func getSubscription
     public func updateSubscription
     
     
     public func createThing(Object any) {
     
     }
     
     public func createThingWithId(string id, Object any) {
     
     }
     
     public func updateThing(string id, Object any) {
     
     }
     
     
     
     
     */
}

public class Acl {
    var read: Bool
    var write: Bool
    var administrate: Bool
    
    public init() {
        self.read = false
        self.write = false
        self.administrate = false
    }
}

public class Thing {
    var id: String
    var acl: [String: Acl]
    var attributes: [String: JSON]
    var features: [String: Feature]
    
    public init() {
        self.id = ""
        self.acl = [String: Acl]()
        self.attributes = [String: JSON]()
        self.features = [String: Feature]()
    }    
}

public class Relation {
    var id: String
    var acl: [String: Acl]
    var source: String
    var target: String
    var attributes: [String: JSON]
    
    public init() {
        self.id = ""
        self.acl = [String: Acl]()
        self.source = ""
        self.target = ""
        self.attributes = [String: JSON]()
    }
}

public class SearchResult {
    var items: [Thing]
    var nextPageOffset: UInt

    public init() {
        self.items = [Thing]()
        self.nextPageOffset = 0
    }
}

public class ResponseError {
    var status: UInt
    var error: String
    var message: String
    var description: String
    var href: String
    
    public init() {
        self.status = 0
        self.error = ""
        self.message = ""
        self.description = ""
        self.href = ""
    }
}

public class Subscription {
    var id: String
    var target: String
    
    public init() {
        self.id = ""
        self.target = ""
    }
}

public class Solution {
    var id: String
    var apiToken: String
    var plan: String
    var customer: Customer
    var namespaces: [String: Namespace]
    
    public init() {
        self.id = ""
        self.apiToken = ""
        self.plan = ""
        self.customer = Customer()
        self.namespaces = [String: Namespace]()
    }
}

public class Customer {
    var name: String
    var email: String
    var info: String
    
    public init() {
        self.name = ""
        self.email = ""
        self.info = ""
    }
}

public class Namespace {
    var name: String
    var defaultNamespace: Bool
    
    public init() {
        self.name = ""
        self.defaultNamespace = false
    }
}

public class Feature {
    var properties: [String: JSON]
    
    public init() {
        self.properties = [String: JSON]()
    }
}