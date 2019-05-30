//
//  RecipeViewCell.swift
//  MarleySpoon
//
//  Created by Christian on 30/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import UIKit
import Kingfisher

class RecipeViewCell: UITableViewCell {
    @IBOutlet private weak var previewImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    private(set) var recipeCellViewModel = RecipeCellViewModel()
    
    private static let recipePlaceholder = UIImage(named: "RecipePlaceholder")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initViewModel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        titleLabel.textColor = selected ? UIColor.cyan : UIColor.white
    }
    
}

//MARK:- viewModel related
extension RecipeViewCell {
    private func initViewModel() {
        recipeCellViewModel.configureCellViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.configureCell()
            }
        }
    }
    private func configureCell() {
        titleLabel.text = recipeCellViewModel.title
        var url: URL?
        if let previewUrl = recipeCellViewModel.previewUrl {
            url = URL(string: previewUrl)
        }
        previewImageView.kf.setImage(with: url, placeholder: RecipeViewCell.recipePlaceholder, options: nil, progressBlock: nil, completionHandler: nil)
    }
    
}
