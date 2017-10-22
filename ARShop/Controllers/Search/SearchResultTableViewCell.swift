//
//  SearchResultTableViewCell.swift
//  ARShop
//
//  Created by Cameron Moreau on 10/21/17.
//  Copyright © 2017 cameronmoreau. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func setup(product: Product) {
        if let title = product.family {
            titleLabel.text = title
        }
        
        if let price = product.formattedPrice {
            priceLabel.text = price
        }
        
        if let desc = product.color {
            descLabel.text = desc
        }
        
        if let rating = product.rating {
            ratingLabel.text = "\(rating) out of 5 stars"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
