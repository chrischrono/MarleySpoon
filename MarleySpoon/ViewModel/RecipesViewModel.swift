//
//  RecipesViewModel.swift
//  MarleySpoon
//
//  Created by Christian on 30/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import Foundation
import Contentful

class RecipesViewModel {
    let client = Client(spaceId: "kk2bw5ojx476",
                        environmentId: "master", // Defaults to "master" if omitted.
        accessToken: "7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c")

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
