//
//  StatusCollectionViewCell.swift
//  todolist
//
//  Created by Mac on 20/09/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class StatusCollectionViewCell: UICollectionViewCell {
    var number = UILabel()
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(number)
        number.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
