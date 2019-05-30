//
//  Recipe.swift
//  MarleySpoon
//
//  Created by Christian on 30/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import Foundation
import Contentful

class Recipe: EntryDecodable, Resource, FieldKeysQueryable {
    
    static let contentTypeId = "recipe"
    
    let sys: Sys
    let title: String?
    var photo: Asset?
    let calories: Int?
    let description: String?
    var chef: Chef?
    var tags: [Tag]?
    
    required init(from decoder: Decoder) throws {
        
        sys          = try decoder.sys()
        let fields   = try decoder.contentfulFieldsContainer(keyedBy: FieldKeys.self)
        title        = try? fields.decode(String.self, forKey: .title)
        calories     = try? fields.decode(Int.self, forKey: .calories)
        description  = try? fields.decode(String.self, forKey: .description)
        
        try fields.resolveLink(forKey: .photo, decoder: decoder) { [weak self] photo in
            self?.photo = photo as? Asset
        }
        try fields.resolveLink(forKey: .chef, decoder: decoder) { [weak self] chef in
            self?.chef = chef as? Chef
        }
        try fields.resolveLinksArray(forKey: .tags, decoder: decoder) { [weak self] array in
            self?.tags = array as? [Tag]
        }
    }
    
    enum FieldKeys: String, CodingKey {
        case title, calories, description
        case photo, chef, tags
    }
}

protocol RecipeHandler {
    func setRecipe(_ recipe: Recipe)
}
