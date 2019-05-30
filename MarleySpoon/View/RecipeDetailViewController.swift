//
//  RecipeDetailViewController.swift
//  MarleySpoon
//
//  Created by Christian on 30/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet private weak var previewImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tagsLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var chefLabel: UILabel!
    
    private(set) var recipeDetailViewModel = RecipeDetailViewModel()
    private let recipePlaceholder = UIImage(named: "RecipePlaceholder")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initViewModel()
    }

}

//MARK:- viewModel related
extension RecipeDetailViewController {
    private func initViewModel() {
        recipeDetailViewModel.configureViewClosure = configureView
        
        recipeDetailViewModel.userRequestDetailData()
    }
}

//MARK:- private func
extension RecipeDetailViewController {
    private func configureView() {
        var url: URL?
        if let previewUrl = recipeDetailViewModel.previewUrl {
            url = URL(string: previewUrl)
        }
        previewImageView.kf.setImage(with: url, placeholder: recipePlaceholder, options: nil, progressBlock: nil, completionHandler: nil)
        
        titleLabel.text = recipeDetailViewModel.title
        tagsLabel.text = String(format: "recipe_detail_tags".localized(), recipeDetailViewModel.tags ?? "")
        descriptionLabel.text = String(format: "recipe_detail_description".localized(), recipeDetailViewModel.description ?? "")
        chefLabel.text = String(format: "recipe_detail_chef".localized(), recipeDetailViewModel.chef ?? "")
    }
}
