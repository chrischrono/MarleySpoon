//
//  NetworkManager.swift
//  MarleySpoon
//
//  Created by Christian on 30/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import Foundation
import Contentful


protocol NetworkProtocol {
    /**
     Get Recipes data based on MarleySpoon API
     - Parameter completion: block to handle the get results
     */
    func getRecipes(completion: @escaping (_ recipes: [Recipe]?,_ error: String?)->())
}

class NetworkManager: NetworkProtocol {
    private let spaceId: String
    private let accessToken: String
    private let client: Client
    
    
    init(spaceId: String, accessToken: String) {
        self.spaceId = spaceId
        self.accessToken = accessToken
        client = Client(spaceId: spaceId,
                        environmentId: "master",
                        accessToken: accessToken,
                        contentTypeClasses: [Recipe.self, Chef.self, Tag.self])
    }
    
    func getRecipes(completion: @escaping (_ recipes: [Recipe]?,_ error: String?)->()) {
        client.fetchArray(of: Recipe.self) { (result: Result<ArrayResponse<Recipe>>) in
            switch result{
            case .success(let recipeArrayResponse):
                completion(recipeArrayResponse.items, nil)
            case .error(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    func testContentfull() {
        /*client.fetchSpace (then: { (result) in
         switch result{
         case .success(let space):
         print(space)
         case .error(let error):
         print(error.localizedDescription)
         }
         })*/
        
        //let query = Query.any
        client.fetchArray(of: ContentType.self) { (result: Result<ArrayResponse<ContentType>>) in
            switch result{
            case .success(let entryArrayResponse):
                for contentType in entryArrayResponse.items {
                    print(">>\(contentType.id) \(contentType.description ?? "")")
                    for field in contentType.fields {
                        print("\(field.name) - \(field.itemType ?? FieldType(rawValue: ""))")
                    }
                }
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    //entryToDictionary
    private func entryToDictionary(entry: Entry) -> [String: Any] {
        var dictionary = [String: Any]()
        
        for field in entry.fields {
            let key = field.key
            
            if let value = field.value as? Int {
                dictionary[key] = value
            } else if let value = field.value as? String {
                dictionary[key] = value
            } /*else if let value = field.value as? Link {
                 dictionary[key] = linkToAny(value)
                 } else if let entryArray = field.value as? [Link] {
                 let dict = entryArray.flatMap { linkToAny($0) }
                 dictionary[key] = dict
             }*/ else {
                dictionary[key] = field.value
            }
        }
        
        return dictionary
    }
}
