//
//  RecipesViewController.swift
//  MarleySpoon
//
//  Created by Christian on 28/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import UIKit
import Contentful

class RecipesViewController: UIViewController {
    
    @IBOutlet private weak var recipeTableView: UITableView!
    private let refreshControl = UIRefreshControl()
    @IBOutlet private weak var statusView: UIView!
    @IBOutlet private weak var statusViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!
    
    private(set) var recipesViewModel = RecipesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
        initViewModel()
    }

}

//MARK:- viewModel related
extension RecipesViewController {
    private func initViewModel() {
        recipesViewModel.reloadRecipeListViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.recipeTableView.reloadData()
            }
        }
        recipesViewModel.showStatusViewClosure = { [weak self] (status) in
            DispatchQueue.main.async {
                if let status = status {
                    self?.showStatusView(status)
                } else {
                    self?.hideStatusView()
                }
            }
        }
        recipesViewModel.showLoadingViewClosure = { [weak self] (isLoading) in
            DispatchQueue.main.async {
                self?.showLoadingView(isLoading)
            }
        }
        
        recipesViewModel.getRecipes()
    }
}

//MARK:- private func
extension RecipesViewController {
    private func initView() {
        initTableView()
        statusViewBottomConstraint.constant = statusView.bounds.height
    }
    
    private func showStatusView(_ status: String?) {
        guard let status = status else {
            hideStatusView()
            return
        }
        statusLabel.text = status//.localized()
        statusViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        }) { [weak self] (_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self?.hideStatusView()
            })
        }
    }
    private func hideStatusView() {
        statusViewBottomConstraint.constant = statusView.bounds.height
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func showLoadingView(_ isLoading: Bool) {
        if isLoading {
            loadingView.startAnimating()
        } else {
            loadingView.stopAnimating()
            refreshControl.endRefreshing()
        }
    }
}

//MARK:- tableView func
extension RecipesViewController: UITableViewDataSource, UITableViewDelegate {
    private func initTableView() {
        recipeTableView.register(UINib(nibName: "RecipeViewCell", bundle: nil), forCellReuseIdentifier: "RecipeViewCell")
        
        refreshControl.addTarget(self, action:
            #selector(handleReshresh(_:)),
                                 for: UIControl.Event.valueChanged)
        
        refreshControl.tintColor = UIColor.blue
        recipeTableView.addSubview(refreshControl)
    }
    
    @objc private func handleReshresh(_ refreshControl: UIRefreshControl?) {
        recipesViewModel.getRecipes()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesViewModel.getRecipesCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeViewCell", for: indexPath) as! RecipeViewCell
        recipesViewModel.getRecipe(handler: cell.recipeCellViewModel, index: indexPath.row)
        return cell
    }
    
}

