//
//  checkCollectionViewCell.swift
//  todolist
//
//  Created by Mac on 09/09/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class checkCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var number: UILabel!
    override var isHighlighted: Bool{
        didSet{
            number.backgroundColor = isHighlighted ? UIColor(red:0.83, green:0.83, blue:0.83, alpha:1.0) : UIColor.white
        }
    }
    override var isSelected: Bool{
        didSet{
            number.backgroundColor = isSelected ? UIColor(red:0.83, green:0.83, blue:0.83, alpha:1.0) : UIColor.white
        }
    }
}
