//
//  MockNetworkManager.swift
//  MarleySpoonTests
//
//  Created by Christian on 31/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import Foundation
@testable import MarleySpoon
import Contentful


class MockNetworkManager: NetworkProtocol {
    var mockRecipes: [Recipe]?
    var mockError: String?
    private(set) var jsonDecoder: JSONDecoder?
    
    func getRecipes(completion: @escaping (_ recipes: [Recipe]?,_ error: String?) -> ()) {
        initJSONDecoder()
        completion(mockRecipes, mockError)
    }
    
    func initJSONDecoder() {
        guard jsonDecoder == nil else {
            return
        }
        let client = Client(spaceId: "",
                            environmentId: "master",
                            accessToken: "",
                            contentTypeClasses: [Recipe.self, Chef.self, Tag.self])
        jsonDecoder = client.jsonDecoder
    }
    
    
}
