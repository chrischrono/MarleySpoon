//
//  Tag.swift
//  MarleySpoon
//
//  Created by Christian on 30/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import Foundation
import Contentful

class Tag: EntryDecodable, Resource, FieldKeysQueryable {
    
    static let contentTypeId = "tag"
    
    let sys: Sys
    let name: String?
    
    required init(from decoder: Decoder) throws {
        
        sys          = try decoder.sys()
        let fields   = try decoder.contentfulFieldsContainer(keyedBy: FieldKeys.self)
        name        = try? fields.decode(String.self, forKey: .name)
        
    }
    
    enum FieldKeys: String, CodingKey {
        case name
    }
}
