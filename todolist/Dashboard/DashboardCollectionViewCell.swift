//
//  TaskCollectionViewCell.swift
//  todolist
//
//  Created by Mac on 10/09/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class DashboardCollectionViewCell: UICollectionViewCell {
    
    var btnTapAction: (() -> ())?
    
    @IBOutlet weak var boardTitleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var deleteBoardBtn: UIButton!
    
}
