//
//  ThingsKit.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 13/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Alamofire
import ObjectMapper

public class ThingsKit {
    var user: String
    var password: String
    var token: String
    var endpoint: String
    
    public init(user: String, password: String, token: String, endpoint: String = "https://things.apps.bosch-iot-cloud.com/cr/1") {
        self.user = user
        self.password = password
        self.token = token
        self.endpoint = endpoint
    }
    
    private func callService(method: String, frag: String, body: String, completion: Response<AnyObject, NSError> -> Void) {
        let url = self.endpoint + frag
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(self.token, forHTTPHeaderField: "x-cr-api-token")
        
        if body != "" {
            request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        }

        Alamofire.request(request).authenticate(user: self.user, password: self.password).responseJSON(completionHandler: completion)
    }
    
    public func listThings(ids: [String], completion: (things: [Thing]) -> Void) {
        let frag = "/things?ids=\(ids.joinWithSeparator(","))"
        self.callService("GET", frag: frag, body: "") {
            response in
            
            let jsonString:String = String(data: response.data!, encoding: NSUTF8StringEncoding)!
            let things = Mapper<Thing>().mapArray(jsonString)
            
            completion(things: things!)
        }
    }
    
    public func createThing(thing: Thing, completion: (createdThing: Thing) -> Void) {
        let frag = "/things"
        let json = Mapper().toJSONString(thing)
        
        self.callService("POST", frag: frag, body: json!) {
            response in            
            
            let jsonString:String = String(data: response.data!, encoding: NSUTF8StringEncoding)!
            let thing = Mapper<Thing>().map(jsonString)
            
            completion(createdThing: thing!)
        }        
    }
    
    public func deleteThing(id: String, completion: () -> Void) {
        let frag = "/things/\(id)"
        
        self.callService("DELETE", frag: frag, body: "") {
            response in
            
            completion()
        }
    }
    
    public func getThing(id: String, completion: (thing: Thing) -> Void) {
        let frag = "/things/\(id)"
        
        self.callService("GET", frag: frag, body: "") {
            (response) in
            
            let jsonString:String = String(data: response.data!, encoding: NSUTF8StringEncoding)!
            let thing = Mapper<Thing>().map(jsonString)
                        
            completion(thing: thing!)
        }
    }
    
    public func updateThing(id: String, thing: Thing, completion: (success: Bool) -> Void) {
        let frag = "/things/\(id)"
        let json = Mapper().toJSONString(thing)
        
        self.callService("PUT", frag: frag, body: json!) {
            response in
            
            var success = false
            if response.response?.statusCode == 204 {
                success = true
            }
            
            completion(success: success)
        }
    }
    
    public func listAcl(id: String, completion: (acl: [String: Acl]) -> Void) {
        let frag = "/things/\(id)/acl"
        
        self.callService("GET", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func updateAcl(id: String, acl: Acl, completion: () -> Void) {
        let frag = "/things/\(id)/acl"
        
        self.callService("PUT", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func deleteAclEntry(id: String, authSubject: String, completion: () -> Void) {
        let frag = "/things/\(id)/acl/\(authSubject)"
        
        self.callService("DELETE", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func getAclEntry(id: String, authSubject: String, completion: () -> Void) {
        let frag = "/things/\(id)/acl/\(authSubject)"
        
        self.callService("GET", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func updateAclEntry(id: String, authSubject: String, acl: Acl, completion: () -> Void) {
        let frag = "/things/\(id)/acl/\(authSubject)"
        
        self.callService("PUT", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func deleteAttributes(id: String, completion: () -> Void) {
        let frag = "/things/\(id)/attributes"
        
        self.callService("DELETE", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func listAttributes(id: String, completion: () -> Void) {
        let frag = "/things/\(id)/attributes"
        
        self.callService("GET", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func updateAttributes(id: String, attributes: [String: AnyObject], completion: () -> Void) {
        let frag = "/things/\(id)/attributes"
        
        self.callService("PUT", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func deleteAttribute(id: String, path: String, completion: () -> Void) {
        let frag = "/things/\(id)/attributes/\(path)"
        
        self.callService("DELETE", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func getAttribute(id: String, path: String, completion: () -> Void) {
        let frag = "/things/\(id)/attributes/\(path)"
        
        self.callService("GET", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func updateAttribute(id: String, path: String, attribute: AnyObject, completion: () -> Void) {
        let frag = "/things/\(id)/attributes/\(path)"
        
        self.callService("PUT", frag: frag, body: "") {
            response in
            
        }
    }
    
    // Features
    public func deleteFeatures(id: String, completion: () -> Void) {
        let frag = "/things/\(id)/features"
        
        self.callService("DELETE", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func listFeatures(id: String, completion: () -> Void) {
        let frag = "/things/\(id)/features"
        
        self.callService("GET", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func updateFeatures(id: String, features: [String: AnyObject], completion: () -> Void) {
        let frag = "/things/\(id)/features"
        
        self.callService("PUT", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func deleteFeature(id: String, featureId: String, completion: () -> Void) {
        let frag = "/things/\(id)/features/\(featureId)"
        
        self.callService("DELETE", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func getFeature(id: String, featureId: String, completion: () -> Void) {
        let frag = "/things/\(id)/features/\(featureId)"
        
        self.callService("GET", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func updateFeature(id: String, featureId: String, feature: AnyObject, completion: () -> Void) {
        let frag = "/things/\(id)/features/\(featureId)"
        
        self.callService("PUT", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func deleteFeatureProperties(id: String, featureId: String, completion: () -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/properties"
        
        self.callService("DELETE", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func listFeatureProperties(id: String, featureId: String, completion: () -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/properties"
        
        self.callService("GET", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func updateFeatureProperties(id: String, featureId: String, properties: [String: AnyObject], completion: () -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/properties"
        
        self.callService("PUT", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func deleteFeatureProperty(id: String, featureId: String, path: String, completion: () -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/properties/\(path)"
        
        self.callService("DELETE", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func getFeatureProperty(id: String, featureId: String, path: String, completion: () -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/properties/\(path)"
        
        self.callService("GET", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func updateFeatureProperty(id: String, featureId: String, path: String, property: AnyObject, completion: () -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/properties/\(path)"
        
        self.callService("PUT", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func listRelations(ids: [String], completion: () -> Void) {
        let frag = "/relations"
        
        self.callService("GET", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func createRelation(relation: Relation, completion: () -> Void) {
        let frag = "/relations"
        
        self.callService("POST", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func deleteRelation(id: String, completion: () -> Void) {
        let frag = "/relations/\(id)"
        
        self.callService("DELETE", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func getRelation(id: String, completion: () -> Void) {
        let frag = "/relations/\(id)"
        
        self.callService("GET", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func updateRelation(id: String, relation: Relation, completion: () -> Void) {
        let frag = "/relations/\(id)"
        
        self.callService("PUT", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func getRelationAcl(id: String, completion: () -> Void) {
        let frag = "/relations/\(id)/acl"
        
        self.callService("GET", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func updateRelationAcl(id: String, acl: Acl, completion: () -> Void) {
        let frag = "/relations/\(id)/acl"
        
        self.callService("PUT", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func deleteRelationAclEntry(id: String, subject: String, completion: () -> Void) {
        let frag = "/relations/\(id)/acl/\(subject)"
        
        self.callService("DELETE", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func getRelationAclEntry(id: String, subject: String, completion: () -> Void) {
        let frag = "/relations/\(id)/acl/\(subject)"
        
        self.callService("GET", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func updateRelationAclEntry(id: String, subject: String, acl: Acl, completion: () -> Void) {
        let frag = "/relations/\(id)/acl/\(subject)"
        
        self.callService("PUT", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func getRelationSource(id: String, completion: () -> Void) {
        let frag = "/relations/\(id)/source"
        
        self.callService("GET", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func updateRelationSource(id: String, source: AnyObject, completion: () -> Void) {
        let frag = "/relations/\(id)/source"
        
        self.callService("PUT", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func getRelationTarget(id: String, completion: () -> Void) {
        let frag = "/relations/\(id)/target"
        
        self.callService("GET", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func updateRelationTarget(id: String, source: AnyObject, completion: () -> Void) {
        let frag = "/relations/\(id)/target"
        
        self.callService("PUT", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func deleteRelationAttributes(id: String, completion: () -> Void) {
        let frag = "/relations/\(id)/attributes"
        
        self.callService("DELETE", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func listRelationAttributes(id: String, completion: () -> Void) {
        let frag = "/relations/\(id)/attributes"
        
        self.callService("GET", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func updateRelationAttributes(id: String, attributes: [String: AnyObject], completion: () -> Void) {
        let frag = "/relations/\(id)/attributes"
        
        self.callService("PUT", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func deleteRelationAttribute(id: String, path: String, completion: () -> Void) {
        let frag = "/relations/\(id)/attributes/\(path)"
        
        self.callService("DELETE", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func getRelationAttribute(id: String, path: String, completion: () -> Void) {
        let frag = "/relations/\(id)/attributes/\(path)"
        
        self.callService("GET", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func updateRelationAttribute(id: String, path: String, attribute: AnyObject, completion: () -> Void) {
        let frag = "/relations/\(id)/attributes/\(path)"
        
        self.callService("PUT", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func search(query: Query, completion: () -> Void) {
        let frag = "/search/things"
        
        self.callService("GET", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func claimThing(id: String, timeout: UInt, payload: AnyObject, completion: () -> Void) {
        let frag = "/things/\(id)/inbox/claim"
        
        self.callService("POST", frag: frag, body: "") {
            response in
            
        }
        
    }
    
    public func sendMessageToThing(id: String, messageSubject: String, payload: AnyObject, completion: () -> Void) {
        let frag = "/things/\(id)/inbox/messages/\(messageSubject)"
        
        self.callService("POST", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func sendMessageFromThing(id: String, messageSubject: String, payload: AnyObject, completion: () -> Void) {
        let frag = "/things/\(id)/outbox/messages/\(messageSubject)"
        
        self.callService("POST", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func sendMessageToThingFeature(id: String, featureId: String, messageSubject: String, payload: AnyObject, completion: () -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/inbox/messages/\(messageSubject)"
        
        self.callService("POST", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func sendMessageFromThingFeature(id: String, featureId: String, messageSubject: String, payload: AnyObject, completion: () -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/outbox/messages/\(messageSubject)"
        
        self.callService("POST", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func listSubscriptions( completion: () -> Void) {
        let frag = "/subscriptions"
        
        self.callService("GET", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func createSubscription(subscription: Subscription, completion: () -> Void) {
        let frag = "/subscriptions"
        
        self.callService("POST", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func deleteSubscription(id: String, completion: () -> Void) {
        let frag = "/subscriptions/(id)"
        
        self.callService("DELETE", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func getSubscription(id: String, completion: () -> Void) {
        let frag = "/subscriptions/(id)"
        
        self.callService("GET", frag: frag, body: "") {
            response in
            
        }
    }
    
    public func updateSubscription(id: String, subscription: Subscription, completion: () -> Void) {
        let frag = "/subscriptions/(id)"
        
        self.callService("PUT", frag: frag, body: "") {
            response in
            
        }
    }
}





