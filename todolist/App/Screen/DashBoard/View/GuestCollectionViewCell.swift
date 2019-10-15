//
//  GuestTableViewCell.swift
//  todolist
//
//  Created by Mac on 10/9/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class GuestCollectionViewCell: UICollectionViewCell {
    //MARK:- UI Properties
    var guestImageView = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
}

//MARK:- SetupUI
extension GuestCollectionViewCell{
    final private func setupUI(){
        self.contentView.addSubview(guestImageView)
        guestImageView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
            make.size.equalTo(200)
        }
        guestImageView.layer.cornerRadius = guestImageView.frame.width/2
        guestImageView.layer.masksToBounds = false
        guestImageView.clipsToBounds = true
        guestImageView.contentMode = .scaleAspectFill
        guestImageView.backgroundColor = .purple
    }
}


