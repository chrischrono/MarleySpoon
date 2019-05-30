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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
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
extension RecipesViewController: UITableViewDataSource {
    private func initTableView() {
        recipeTableView.register(UINib(nibName: "RecipeViewCell", bundle: nil), forCellReuseIdentifier: "RecipeViewCell")
        
        refreshControl.addTarget(self, action:
            #selector(handleReshresh(_:)),
                                 for: UIControl.Event.valueChanged)
        
        refreshControl.tintColor = UIColor.blue
        recipeTableView.addSubview(refreshControl)
    }
    
    @objc private func handleReshresh(_ refreshControl: UIRefreshControl?) {
        //recipesViewModel.getCurrentLocation()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0//recipesViewModel.getFilteredCountryCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeViewCell", for: indexPath) as! CountryViewCellRecipeViewCell        cell.configureCell(model: countrySearchViewModel.getRecipeCellViewModel(at: indexPath.row))
        return cell*/
        return UITableViewCell()
    }
    
}

