//
//  ThingsKit.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 13/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Alamofire
import JSONHelper

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
    
    private func method(m: String) -> Alamofire.Method {
        switch m {
        case "GET":
            return Alamofire.Method.GET
            
        case "POST":
            return Alamofire.Method.POST
            
        case "PUT":
            return Alamofire.Method.PUT
            
        case "DELETE":
            return Alamofire.Method.DELETE
            
        default:
            break
        }
        return Alamofire.Method.GET
    }
    
    
    public func listThings(ids: [String], completion: (things: [Thing]) -> Void) {
        let frag = "/things?ids=\(ids.joinWithSeparator(","))"
        let m = method("GET")
        print(frag)
        self.callService(m, frag: frag) {
            response in
            
            let jsonString:String = String(data: response.data!, encoding: NSUTF8StringEncoding)!
            var things = [Thing]()
            things <-- jsonString
            
            completion(things: things)
        }
    }
    
    public func createThing(thing: Thing, completion: (createdThing: Thing) -> Void) {
        let frag = "/things"
        let m = method("POST")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func deleteThing(id: String, completion: () -> Void) {
        let frag = "/things/\(id)"
        let m = method("DELETE")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func getThing(id: String, completion: (thing: Thing) -> Void) {
        let frag = "/things/\(id)"
        let m = method("GET")
        
        self.callService(m, frag: frag) {
            response in
            
            let jsonString:String = String(data: response.data!, encoding: NSUTF8StringEncoding)!
            var thing = Thing()            
            thing <-- jsonString
            
            completion(thing: thing)
        }
    }
    
    public func updateThing(id: String, thing: Thing, completion: (updatedThing: Thing) -> Void) {
        let frag = "/things/\(id)"
        let m = method("PUT")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func listAcl(id: String, completion: (acl: [String: Acl]) -> Void) {
        let frag = "/things/\(id)/acl"
        let m = method("GET")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func updateAcl(id: String, acl: Acl, completion: () -> Void) {
        let frag = "/things/\(id)/acl"
        let m = method("PUT")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func deleteAclEntry(id: String, authSubject: String, completion: () -> Void) {
        let frag = "/things/\(id)/acl/\(authSubject)"
        let m = method("DELETE")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func getAclEntry(id: String, authSubject: String, completion: () -> Void) {
        let frag = "/things/\(id)/acl/\(authSubject)"
        let m = method("GET")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func updateAclEntry(id: String, authSubject: String, acl: Acl, completion: () -> Void) {
        let frag = "/things/\(id)/acl/\(authSubject)"
        let m = method("PUT")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func deleteAttributes(id: String, completion: () -> Void) {
        let frag = "/things/\(id)/attributes"
        let m = method("DELETE")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func listAttributes(id: String, completion: () -> Void) {
        let frag = "/things/\(id)/attributes"
        let m = method("GET")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func updateAttributes(id: String, attributes: [String: AnyObject], completion: () -> Void) {
        let frag = "/things/\(id)/attributes"
        let m = method("PUT")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func deleteAttribute(id: String, path: String, completion: () -> Void) {
        let frag = "/things/\(id)/attributes/\(path)"
        let m = method("DELETE")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func getAttribute(id: String, path: String, completion: () -> Void) {
        let frag = "/things/\(id)/attributes/\(path)"
        let m = method("GET")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func updateAttribute(id: String, path: String, attribute: AnyObject, completion: () -> Void) {
        let frag = "/things/\(id)/attributes/\(path)"
        let m = method("PUT")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    // Features
    public func deleteFeatures(id: String, completion: () -> Void) {
        let frag = "/things/\(id)/features"
        let m = method("DELETE")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func listFeatures(id: String, completion: () -> Void) {
        let frag = "/things/\(id)/features"
        let m = method("GET")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func updateFeatures(id: String, features: [String: AnyObject], completion: () -> Void) {
        let frag = "/things/\(id)/features"
        let m = method("PUT")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func deleteFeature(id: String, featureId: String, completion: () -> Void) {
        let frag = "/things/\(id)/features/\(featureId)"
        let m = method("DELETE")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func getFeature(id: String, featureId: String, completion: () -> Void) {
        let frag = "/things/\(id)/features/\(featureId)"
        let m = method("GET")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func updateFeature(id: String, featureId: String, feature: AnyObject, completion: () -> Void) {
        let frag = "/things/\(id)/features/\(featureId)"
        let m = method("PUT")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func deleteFeatureProperties(id: String, featureId: String, completion: () -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/properties"
        let m = method("DELETE")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func listFeatureProperties(id: String, featureId: String, completion: () -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/properties"
        let m = method("GET")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func updateFeatureProperties(id: String, featureId: String, properties: [String: AnyObject], completion: () -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/properties"
        let m = method("PUT")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func deleteFeatureProperty(id: String, featureId: String, path: String, completion: () -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/properties/\(path)"
        let m = method("DELETE")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func getFeatureProperty(id: String, featureId: String, path: String, completion: () -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/properties/\(path)"
        let m = method("GET")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func updateFeatureProperty(id: String, featureId: String, path: String, property: AnyObject, completion: () -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/properties/\(path)"
        let m = method("PUT")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func listRelations(ids: [String], completion: () -> Void) {
        let frag = "/relations"
        let m = method("GET")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func createRelation(relation: Relation, completion: () -> Void) {
        let frag = "/relations"
        let m = method("POST")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func deleteRelation(id: String, completion: () -> Void) {
        let frag = "/relations/\(id)"
        let m = method("DELETE")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func getRelation(id: String, completion: () -> Void) {
        let frag = "/relations/\(id)"
        let m = method("GET")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func updateRelation(id: String, relation: Relation, completion: () -> Void) {
        let frag = "/relations/\(id)"
        let m = method("PUT")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func getRelationAcl(id: String, completion: () -> Void) {
        let frag = "/relations/\(id)/acl"
        let m = method("GET")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func updateRelationAcl(id: String, acl: Acl, completion: () -> Void) {
        let frag = "/relations/\(id)/acl"
        let m = method("PUT")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func deleteRelationAclEntry(id: String, subject: String, completion: () -> Void) {
        let frag = "/relations/\(id)/acl/\(subject)"
        let m = method("DELETE")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func getRelationAclEntry(id: String, subject: String, completion: () -> Void) {
        let frag = "/relations/\(id)/acl/\(subject)"
        let m = method("GET")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func updateRelationAclEntry(id: String, subject: String, acl: Acl, completion: () -> Void) {
        let frag = "/relations/\(id)/acl/\(subject)"
        let m = method("PUT")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func getRelationSource(id: String, completion: () -> Void) {
        let frag = "/relations/\(id)/source"
        let m = method("GET")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func updateRelationSource(id: String, source: AnyObject, completion: () -> Void) {
        let frag = "/relations/\(id)/source"
        let m = method("PUT")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func getRelationTarget(id: String, completion: () -> Void) {
        let frag = "/relations/\(id)/target"
        let m = method("GET")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func updateRelationTarget(id: String, source: AnyObject, completion: () -> Void) {
        let frag = "/relations/\(id)/target"
        let m = method("PUT")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func deleteRelationAttributes(id: String, completion: () -> Void) {
        let frag = "/relations/\(id)/attributes"
        let m = method("DELETE")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func listRelationAttributes(id: String, completion: () -> Void) {
        let frag = "/relations/\(id)/attributes"
        let m = method("GET")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func updateRelationAttributes(id: String, attributes: [String: AnyObject], completion: () -> Void) {
        let frag = "/relations/\(id)/attributes"
        let m = method("PUT")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func deleteRelationAttribute(id: String, path: String, completion: () -> Void) {
        let frag = "/relations/\(id)/attributes/\(path)"
        let m = method("DELETE")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func getRelationAttribute(id: String, path: String, completion: () -> Void) {
        let frag = "/relations/\(id)/attributes/\(path)"
        let m = method("GET")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func updateRelationAttribute(id: String, path: String, attribute: AnyObject, completion: () -> Void) {
        let frag = "/relations/\(id)/attributes/\(path)"
        let m = method("PUT")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func search(query: Query, completion: () -> Void) {
        let frag = "/search/things"
        let m = method("GET")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func claimThing(id: String, timeout: UInt, payload: AnyObject, completion: () -> Void) {
        let frag = "/things/\(id)/inbox/claim"
        let m = method("POST")
        
        self.callService(m, frag: frag) {
            response in
            
        }
        
    }
    
    public func sendMessageToThing(id: String, messageSubject: String, payload: AnyObject, completion: () -> Void) {
        let frag = "/things/\(id)/inbox/messages/\(messageSubject)"
        let m = method("POST")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func sendMessageFromThing(id: String, messageSubject: String, payload: AnyObject, completion: () -> Void) {
        let frag = "/things/\(id)/outbox/messages/\(messageSubject)"
        let m = method("POST")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func sendMessageToThingFeature(id: String, featureId: String, messageSubject: String, payload: AnyObject, completion: () -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/inbox/messages/\(messageSubject)"
        let m = method("POST")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func sendMessageFromThingFeature(id: String, featureId: String, messageSubject: String, payload: AnyObject, completion: () -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/outbox/messages/\(messageSubject)"
        let m = method("POST")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func listSubscriptions( completion: () -> Void) {
        let frag = "/subscriptions"
        let m = method("GET")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func createSubscription(subscription: Subscription, completion: () -> Void) {
        let frag = "/subscriptions"
        let m = method("POST")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func deleteSubscription(id: String, completion: () -> Void) {
        let frag = "/subscriptions/(id)"
        let m = method("DELETE")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func getSubscription(id: String, completion: () -> Void) {
        let frag = "/subscriptions/(id)"
        let m = method("GET")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
    
    public func updateSubscription(id: String, subscription: Subscription, completion: () -> Void) {
        let frag = "/subscriptions/(id)"
        let m = method("PUT")
        
        self.callService(m, frag: frag) {
            response in
            
        }
    }
}





