//
//  ThingsKit.swift
//  ThingsKit
//
//  Created by Zubair Hamed on 13/4/16.
//  Copyright © 2016 Zubair Hamed. All rights reserved.
//

import Alamofire
import ObjectMapper

struct C {
    static let defaultServiceUrl = "https://things.apps.bosch-iot-cloud.com/cr/1"
    
    static let Get = "GET"
    static let Post = "POST"
    static let Put = "PUT"
    static let Delete = "DELETE"
    
    static let EmptyBody = ""
    
    static let HeaderApiToken = "x-cr-api-token"
}

public class ThingsKit {
    var user: String
    var password: String
    var token: String
    var endpoint: String
    
    public init(user: String, password: String, token: String, endpoint: String = C.defaultServiceUrl) {
        self.user = user
        self.password = password
        self.token = token
        self.endpoint = endpoint
    }
    
    private func createResult(response: Response<AnyObject, NSError>) -> Result {
        let code = response.response?.statusCode
        let result = Result(code: code!)
        
        if code >= 400 && code < 500 {
            return JsonDeserializer.parseResult(response)
        }
        return result
    }
    
    private func doGet(frag: String, completion: (Response<AnyObject, NSError>, Result) -> Void) {
        callService(C.Get, frag: frag, body: C.EmptyBody, completion: completion)
    }
    
    private func doPost(frag: String, body: String, completion: (Response<AnyObject, NSError>, Result) -> Void) {
        callService(C.Post, frag: frag, body: body, completion: completion)
    }

    private func doPut(frag: String, body: String, completion: (Response<AnyObject, NSError>, Result) -> Void) {
        callService(C.Put, frag: frag, body: body, completion: completion)
    }
    
    private func doDelete(frag: String, completion: (Response<AnyObject, NSError>, Result) -> Void) {
        callService(C.Delete, frag: frag, body: C.EmptyBody, completion: completion)
    }
    
    private func callService(method: String, frag: String, body: String, completion: (Response<AnyObject, NSError>, Result) -> Void) {
        let url = self.endpoint + frag
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(self.token, forHTTPHeaderField: C.HeaderApiToken)
        
        if body != C.EmptyBody {
            request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        }

        Alamofire.request(request).authenticate(user: self.user, password: self.password).responseJSON { (response) in
            let result = self.createResult(response)
            completion(response, result)
        }
    }
    
    public func listThings(ids: [String], completion: (things: [Thing], result: Result) -> Void) {
        let frag = "/things?ids=\(ids.joinWithSeparator(","))"
        
        self.doGet(frag) {
            response, result in
            
            var things = [Thing]()
            if result.isSuccess() {
                things = JsonDeserializer.parseThings(response)
            }
            completion(things: things, result: result)
        }
    }
    
    public func createThing(thing: Thing, completion: (createdThing: Thing, result: Result) -> Void) {
        let frag = "/things"
        let json = Mapper().toJSONString(thing)
        
        self.doPost(frag, body: json!) {
            response, result in
            
            var thing = Thing()
            if result.isSuccess() {
                thing = JsonDeserializer.parseThing(response)
            }
            completion(createdThing: thing, result: result)
        }
    }
    
    public func deleteThing(id: String, completion: (result: Result) -> Void) {
        let frag = "/things/\(id)"
        
        self.doDelete(frag) {
            response, result in
            
            completion(result: result)
        }
    }
    
    public func getThing(id: String, completion: (thing: Thing, result: Result) -> Void) {
        let frag = "/things/\(id)"
        
        self.doGet(frag) {
            response, result in
            
            if result.isSuccess() {
                completion(thing: JsonDeserializer.parseThing(response), result: result)
            } else {
                completion(thing: Thing(), result: result)
            }
        }
    }
    
    public func updateThing(id: String, thing: Thing, completion: (thing: Thing, result: Result) -> Void) {
        let frag = "/things/\(id)"
        let json = Mapper().toJSONString(thing)
        
        self.doPut(frag, body: json!) {
            response, result in
            
            var thing = Thing()
            if result.isSuccess() {
                if result.code == 201 {
                    thing = JsonDeserializer.parseThing(response)
                }
            }
            completion(thing: thing, result: result)
        }
    }
    
    public func listAcl(id: String, completion: (acl: [String: Acl], result: Result) -> Void) {
        let frag = "/things/\(id)/acl"
        
        self.doGet(frag) {
            response, result in
            
            var acl = [String: Acl]()
            if result.isSuccess() {
                acl = JsonDeserializer.parseAclDict(response)
            }
            completion(acl: acl, result: result)
        }
    }
    
    public func updateAcl(id: String, acl: Acl, completion: (result: Result) -> Void) {
        let frag = "/things/\(id)/acl"
        let json = Mapper().toJSONString(acl)
        
        self.doPut(frag, body: json!) {
            response, result in
            
            completion(result: result)
        }
    }
    
    public func deleteAclEntry(id: String, authSubject: String, completion: (result: Result) -> Void) {
        let frag = "/things/\(id)/acl/\(authSubject)"
        
        self.doDelete(frag) {
            response, result in
            
            completion(result: result)
        }
    }
    
    public func getAclEntry(id: String, authSubject: String, completion: (acl: Acl, result: Result) -> Void) {
        let frag = "/things/\(id)/acl/\(authSubject)"
        
        self.doGet(frag) {
            response, result in
            
            var acl = Acl()
            if result.isSuccess() {
                acl = JsonDeserializer.parseAcl(response)
            }
            completion(acl: acl, result: result)
        }
    }
    
    public func updateAclEntry(id: String, authSubject: String, acl: Acl, completion: (acl: Acl, result: Result) -> Void) {
        let frag = "/things/\(id)/acl/\(authSubject)"
        
        self.doPut(frag, body: "") {
            response, result in

            var acl = Acl()
            if result.isSuccess() {
                if result.code == 201 {
                    acl = JsonDeserializer.parseAcl(response)
                }
            }
            completion(acl: acl, result: result)
        }
    }
    
    public func deleteAttributes(id: String, completion: (result: Result) -> Void) {
        let frag = "/things/\(id)/attributes"
        
        self.doDelete(frag) {
            response, result in
            
            completion(result: result)
        }
    }
    
    public func listAttributes(id: String, completion: (attributes: [String: AnyObject], result: Result) -> Void) {
        let frag = "/things/\(id)/attributes"
        
        self.doGet(frag) {
            response, result in
            
            // TODO
        }
    }
    
    public func updateAttributes(id: String, attributes: [String: AnyObject], completion: (attributes: [String: AnyObject], result: Result) -> Void) {
        let frag = "/things/\(id)/attributes"
        
        self.doPut(frag, body: "") {
            response, result in
            
            // TODO
        }
    }
    
    public func deleteAttribute(id: String, path: String, completion: (result: Result) -> Void) {
        let frag = "/things/\(id)/attributes/\(path)"
        
        self.doDelete(frag) {
            response, result in
            
            completion(result: result)
        }
    }
    
    public func getAttribute(id: String, path: String, completion: (attribute: AnyObject, result: Result) -> Void) {
        let frag = "/things/\(id)/attributes/\(path)"
        
        self.doGet(frag) {
            response, result in

            // TODO
        }
    }
    
    public func updateAttribute(id: String, path: String, attribute: AnyObject, completion: (attribute: AnyObject, result: Result) -> Void) {
        let frag = "/things/\(id)/attributes/\(path)"
        
        self.doPut(frag, body: "") {
            response, result in

            // TODO
        }
    }
    
    // Features
    public func deleteFeatures(id: String, completion: (result: Result) -> Void) {
        let frag = "/things/\(id)/features"
        
        self.doDelete(frag) {
            response, result in
            
            completion(result: result)
        }
    }
    
    public func listFeatures(id: String, completion: ([String: Feature], result: Result) -> Void) {
        let frag = "/things/\(id)/features"
        
        self.doGet(frag) {
            response, result in

            // TODO
        }
    }
    
    public func updateFeatures(id: String, features: [String: AnyObject], completion: ([String: Feature], result: Result) -> Void) {
        let frag = "/things/\(id)/features"
        
        self.doPut(frag, body: "") {
            response, result in

            // TODO
        }
    }
    
    public func deleteFeature(id: String, featureId: String, completion: (result: Result) -> Void) {
        let frag = "/things/\(id)/features/\(featureId)"
        
        self.doDelete(frag) {
            response, result in
            
            completion(result: result)
        }
    }
    
    public func getFeature(id: String, featureId: String, completion: (feature: Feature, result: Result) -> Void) {
        let frag = "/things/\(id)/features/\(featureId)"
        
        self.doGet(frag) {
            response, result in

            // TODO
        }
    }
    
    public func updateFeature(id: String, featureId: String, feature: AnyObject, completion: (feature: Feature, result: Result) -> Void) {
        let frag = "/things/\(id)/features/\(featureId)"
        
        self.doPut(frag, body: "") {
            response, result in

            // TODO
        }
    }
    
    public func deleteFeatureProperties(id: String, featureId: String, completion: (result: Result) -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/properties"
        
        self.doDelete(frag) {
            response, result in

            completion(result: result)
        }
    }
    
    public func listFeatureProperties(id: String, featureId: String, completion: (properties: [String: AnyObject], result: Result) -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/properties"
        
        self.doGet(frag) {
            response, result in

            // TODO
        }
    }
    
    public func updateFeatureProperties(id: String, featureId: String, properties: [String: AnyObject], completion: (properties: [String: AnyObject], result: Result) -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/properties"
        
        self.doPut(frag, body: "") {
            response, result in

            // TODO
        }
    }
    
    public func deleteFeatureProperty(id: String, featureId: String, path: String, completion: (result: Result) -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/properties/\(path)"
        
        self.doDelete(frag) {
            response, result in

            completion(result: result)
        }
    }
    
    public func getFeatureProperty(id: String, featureId: String, path: String, completion: (property: AnyObject, result: Result) -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/properties/\(path)"
        
        self.doGet(frag) {
            response, result in
         
            // TODO
        }
    }
    
    public func updateFeatureProperty(id: String, featureId: String, path: String, property: AnyObject, completion: (property: AnyObject, result: Result) -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/properties/\(path)"
        
        self.doPut(frag, body: "") {
            response, result in

            // TODO
        }
    }
    
    public func listRelations(ids: [String], completion: (relations: [Relation], result: Result) -> Void) {
        let frag = "/relations"
        
        self.doGet(frag) {
            response, result in

            // TODO
        }
    }
    
    public func createRelation(relation: Relation, completion: (relation: Relation, result: Result) -> Void) {
        let frag = "/relations"
        
        self.doPost(frag, body: "") {
            response, result in
            
            // TODO
        }
    }
    
    public func deleteRelation(id: String, completion: (result: Result) -> Void) {
        let frag = "/relations/\(id)"
        
        self.doDelete(frag) {
            response, result in
            
            completion(result: result)
        }
    }
    
    public func getRelation(id: String, completion: (relation: Relation, result: Result) -> Void) {
        let frag = "/relations/\(id)"
        
        self.doGet(frag) {
            response, result in

            // TODO
        }
    }
    
    public func updateRelation(id: String, relation: Relation, completion: (relation: Relation, result: Result) -> Void) {
        let frag = "/relations/\(id)"
        
        self.doPut(frag, body: "") {
            response, result in
            
            // TODO
        }
    }
    
    public func getRelationAcl(id: String, completion: (acl: [String: Acl], result: Result) -> Void) {
        let frag = "/relations/\(id)/acl"
        
        self.doGet(frag) {
            response, result in
            
            // TODO
        }
    }
    
    public func updateRelationAcl(id: String, acl: Acl, completion: (acl: [String: Acl], result: Result) -> Void) {
        let frag = "/relations/\(id)/acl"
        
        self.doPut(frag, body: "") {
            response, result in
            
            // TODO
        }
    }
    
    public func deleteRelationAclEntry(id: String, subject: String, completion: (result: Result) -> Void) {
        let frag = "/relations/\(id)/acl/\(subject)"
        
        self.doDelete(frag) {
            response, result in

            completion(result: result)
        }
    }
    
    public func getRelationAclEntry(id: String, subject: String, completion: (acl: Acl, result: Result) -> Void) {
        let frag = "/relations/\(id)/acl/\(subject)"
        
        self.doGet(frag) {
            response, result in

            // TODO
        }
    }
    
    public func updateRelationAclEntry(id: String, subject: String, acl: Acl, completion: (acl: Acl, result: Result) -> Void) {
        let frag = "/relations/\(id)/acl/\(subject)"
        
        self.doPut(frag, body: "") {
            response, result in
            
            // TODO
        }
    }
    
    public func getRelationSource(id: String, completion: (result: Result) -> Void) {
        let frag = "/relations/\(id)/source"
        
        self.doGet(frag) {
            response, result in

            // TODO
        }
    }
    
    public func updateRelationSource(id: String, source: AnyObject, completion: (result: Result) -> Void) {
        let frag = "/relations/\(id)/source"
        
        self.doPut(frag, body: "") {
            response, result in
            
        }
    }
    
    public func getRelationTarget(id: String, completion: (result: Result) -> Void) {
        let frag = "/relations/\(id)/target"
        
        self.doGet(frag) {
            response, result in

            // TODO
        }
    }
    
    public func updateRelationTarget(id: String, source: AnyObject, completion: (result: Result) -> Void) {
        let frag = "/relations/\(id)/target"
        
        self.doPut(frag, body: "") {
            response, result in
            
            // TODO
        }
    }
    
    public func deleteRelationAttributes(id: String, completion: (result: Result) -> Void) {
        let frag = "/relations/\(id)/attributes"
        
        self.doDelete(frag) {
            response, result in

            completion(result: result)
        }
    }
    
    public func listRelationAttributes(id: String, completion: (result: Result) -> Void) {
        let frag = "/relations/\(id)/attributes"
        
        self.doGet(frag) {
            response, result in

            // TODO
        }
    }
    
    public func updateRelationAttributes(id: String, attributes: [String: AnyObject], completion: (result: Result) -> Void) {
        let frag = "/relations/\(id)/attributes"
        
        self.doPut(frag, body: "") {
            response, result in
            
            // TODO
        }
    }
    
    public func deleteRelationAttribute(id: String, path: String, completion: (result: Result) -> Void) {
        let frag = "/relations/\(id)/attributes/\(path)"
        
        self.doDelete(frag) {
            response, result in

            completion(result: result)
        }
    }
    
    public func getRelationAttribute(id: String, path: String, completion: (result: Result) -> Void) {
        let frag = "/relations/\(id)/attributes/\(path)"
        
        self.doGet(frag) {
            response, result in
            
            // TODO
        }
    }
    
    public func updateRelationAttribute(id: String, path: String, attribute: AnyObject, completion: (result: Result) -> Void) {
        let frag = "/relations/\(id)/attributes/\(path)"
        
        self.doPut(frag, body: "") {
            response, result in
            
            // TODO
        }
    }
    
    public func search(query: Query, completion: (searchResult: SearchResult, result: Result) -> Void) {
        let frag = "/search/things"
        
        self.doGet(frag) {
            response, result in
                        
            let searchResult = JsonDeserializer.parseSearchResult(response)
            
            completion(searchResult: searchResult, result: result)
        }
    }
    
    public func claimThing(id: String, timeout: UInt, payload: AnyObject, completion: (result: Result) -> Void) {
        let frag = "/things/\(id)/inbox/claim"
        
        self.doPost(frag, body: "") {
            response, result in
            
            // TODO
        }
    }
    
    public func sendMessageToThing(id: String, messageSubject: String, payload: AnyObject, completion: (result: Result) -> Void) {
        let frag = "/things/\(id)/inbox/messages/\(messageSubject)"
        
        self.doPost(frag, body: "") {
            response, result in
            
            // TODO
        }
    }
    
    public func sendMessageFromThing(id: String, messageSubject: String, payload: AnyObject, completion: (result: Result) -> Void) {
        let frag = "/things/\(id)/outbox/messages/\(messageSubject)"
        
        self.doPost(frag, body: "") {
            response, result in
            
            // TODO
        }
    }
    
    public func sendMessageToThingFeature(id: String, featureId: String, messageSubject: String, payload: AnyObject, completion: (result: Result) -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/inbox/messages/\(messageSubject)"
        
        self.doPost(frag, body: "") {
            response, result in
            
            // TODO
        }
    }
    
    public func sendMessageFromThingFeature(id: String, featureId: String, messageSubject: String, payload: AnyObject, completion: (result: Result) -> Void) {
        let frag = "/things/\(id)/features/\(featureId)/outbox/messages/\(messageSubject)"
        
        self.doPost(frag, body: "") {
            response, result in
            
            // TODO
        }
    }
    
    public func listSubscriptions( completion: (subscriptions: [Subscription], result: Result) -> Void) {
        let frag = "/subscriptions"
        
        self.doGet(frag) {
            response, result in

            // TODO
        }
    }
    
    public func createSubscription(subscription: Subscription, completion: (subscription: Subscription, result: Result) -> Void) {
        let frag = "/subscriptions"
        
        self.doPost(frag, body: "") {
            response, result in
            
            // TODO
        }
    }
    
    public func deleteSubscription(id: String, completion: (result: Result) -> Void) {
        let frag = "/subscriptions/(id)"
        
        self.doDelete(frag) {
            response, result in

            completion(result: result)
        }
    }
    
    public func getSubscription(id: String, completion: (subscription: Subscription, result: Result) -> Void) {
        let frag = "/subscriptions/(id)"
        
        self.doGet(frag) {
            response, result in

            // TODO
        }
    }
    
    public func updateSubscription(id: String, subscription: Subscription, completion: (result: Result) -> Void) {
        let frag = "/subscriptions/(id)"
        
        self.doPut(frag, body: "") {
            response, result in
            
            // TODO
        }
    }
}





