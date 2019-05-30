//
//  RecipeDetailViewModel.swift
//  MarleySpoon
//
//  Created by Christian on 31/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import Foundation


class RecipeDetailViewModel {
    
    private var recipe: Recipe?
    
    var title: String? {
        return recipe?.title
    }
    var previewUrl: String? {
        return recipe?.photo?.urlString
    }
    private(set) var tags: String?
    var description: String? {
        return recipe?.description
    }
    var chef: String? {
        return recipe?.chef?.name
    }
    
    var configureViewClosure: (()->())?
}

extension RecipeDetailViewModel: RecipeHandler {
    func userRequestDetailData() {
        configureViewClosure?()
    }
    
    func setRecipe(_ recipe: Recipe) {
        if let tags = recipe.tags {
            let tagsStringArr = tags.compactMap({ $0.name })
            self.tags = tagsStringArr.joined(separator: ", ")
        } else {
            tags = nil
        }
        self.recipe = recipe
    }
    
}
