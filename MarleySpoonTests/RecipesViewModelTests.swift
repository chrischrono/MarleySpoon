//
//  RecipesViewModelTests.swift
//  MarleySpoonTests
//
//  Created by Christian on 31/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import XCTest
@testable import MarleySpoon
import Contentful

class RecipesViewModelTests: XCTestCase {
    
    private let networkManager = MockNetworkManager()
    private let recipeViewModel = RecipesViewModel()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        recipeViewModel.networkManager = networkManager
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testGetRecipesError() {
        
        networkManager.mockError = "This is an error"
        networkManager.mockRecipes = nil
        
        recipeViewModel.getRecipes()
        
        XCTAssertEqual(recipeViewModel.status, networkManager.mockError?.localized())
    }
    
    func testGetRecipes() {
        
        networkManager.initJSONDecoder()
        let data = loadDataFromBundle(withName: "recipes", extension: "json")
        let decodedObject = try! networkManager.jsonDecoder!.decode(ArrayResponse<Recipe>.self, from: data)
        networkManager.mockRecipes = decodedObject.items
        networkManager.mockError = nil
        
        recipeViewModel.getRecipes()
        
        XCTAssertEqual(recipeViewModel.getRecipesCount(), 4)
    }

}
