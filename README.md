MarleySpoon
==========

This repository contains a sample app for requesting MarleySpoon Contentful API and show the Recipes list and detail.


---
# Installation

To install the dependencies
* Open a terminal and cd to the directory containing the Podfile
* Run the `pod install` command

(For further details regarding cocoapod installation see https://cocoapods.org/)


---
# Existing Functionalities

The app is currently able to load Recipes from MarleySpoon Contentful API and show them in list form or detailed.

* When the app loads, it will load the Recipes from MarleySpoon Contentful API, and show them in the tableView
* Upon selecting the Recipe, it will open a view with detailed data of the selected Recipe

---
# Development Steps

1. Create new project based on single view app
2. Create folders for MVVM pattern
3. Add pods: Contentful, Kingfisher
4. Add RecipesViewController and Design the UI layout to show Recipes List
5. Add Networking Layer to handle the MarleySpoon Contentful API
6. Add Models and ViewModel, that will show the Recipes List at RecipesViewController
7. Add RecipeDetailViewController and Design the UI layout to show the selected Recipe detail
8. Add RecipeDetailViewModel to prepare the Recipe's detailed data


