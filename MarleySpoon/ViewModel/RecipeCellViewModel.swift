//
//  RecipeCellViewModel.swift
//  MarleySpoon
//
//  Created by Christian on 30/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import Foundation

class RecipeCellViewModel {
    private var recipe: Recipe? {
        didSet {
            configureCellViewClosure?()
        }
    }
    
    var title: String? {
        return recipe?.title
    }
    var previewUrl: String? {
        return recipe?.photo?.urlString
    }
    
    var configureCellViewClosure: (()->())?
}

extension RecipeCellViewModel: RecipeHandler {
    func setRecipe(_ recipe: Recipe) {
        self.recipe = recipe
    }
    
}
