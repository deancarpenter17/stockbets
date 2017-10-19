//
//  RoundedButton.swift
//  StockBets
//
//  Created by Edmond Amataj on 10/19/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import UIKit

@IBDesignable class RoundedButton: UIButton
{
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
    }
    
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
    }
    
}
