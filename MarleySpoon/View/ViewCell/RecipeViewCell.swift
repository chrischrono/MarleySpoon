//
//  RecipeViewCell.swift
//  MarleySpoon
//
//  Created by Christian on 30/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import UIKit

class RecipeViewCell: UITableViewCell {
    @IBOutlet private weak var previewImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
