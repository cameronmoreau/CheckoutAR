//
//  CheckoutItemTableViewCell.swift
//  ARShop
//
//  Created by Cameron Moreau on 10/22/17.
//  Copyright © 2017 cameronmoreau. All rights reserved.
//

import UIKit

class CheckoutItemTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setup(product: Product) {
        if let title = product.family {
            titleLabel.text = title
        }
        
        if let price = product.formattedPrice {
            priceLabel.text = price
        }
        
        if let desc = product.color {
            detailsLabel.text = desc
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
