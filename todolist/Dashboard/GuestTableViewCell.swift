//
//  GuestTableViewCell.swift
//  todolist
//
//  Created by Mac on 10/9/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class GuestTableViewCell: UITableViewCell {

    private var guestImageView = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    final private func setupUI(){
        self.contentView.addSubview(guestImageView)
        guestImageView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
            make.size.equalToSuperview()
        }

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
