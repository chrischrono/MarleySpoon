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
    private var recipes = [Recipe]() {
        didSet {
            reloadRecipeListViewClosure?()
        }
    }
    
    private(set) var status: String? {
        didSet {
            showStatusViewClosure?(status)
        }
    }
    private(set) var isLoading = false {
        didSet {
            showLoadingViewClosure?(isLoading)
        }
    }
    
    var networkManager: NetworkProtocol = NetworkManager(spaceId: "kk2bw5ojx476", accessToken: "7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c")
    
    var reloadRecipeListViewClosure: (()->())?
    var showStatusViewClosure: ((String?)->())?
    var showLoadingViewClosure: ((Bool)->())?
}

//MARK:- getRecipes related
extension RecipesViewModel {
    func getRecipes() {
        guard isLoading == false else {
            return
        }
        isLoading = true
        status = "network_loading"
        
        networkManager.getRecipes { [weak self] (recipes, error) in
            guard let self = self else {
                return
            }
            self.isLoading = false
            self.status = error
            guard let recipes = recipes else {
                return
            }
            self.processRecipes(recipes)
        }
    }
    private func processRecipes(_ recipes: [Recipe]) {
        self.recipes = recipes
    }
}

//MARK:- listView related
extension RecipesViewModel {
    func getRecipesCount() -> Int {
        return recipes.count
    }
    func getRecipe(handler: RecipeHandler, index: Int) {
        handler.setRecipe(recipes[index])
    }
}
