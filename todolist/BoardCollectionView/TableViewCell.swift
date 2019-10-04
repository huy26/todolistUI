//
//  TableViewCell.swift
//  todolist
//
//  Created by Mac on 09/09/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var view = UIView()
    var StatusName = UILabel()
    var DeleteButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: .default, reuseIdentifier: "Cell")
        setupUI()
    }
    
    private func setupUI() {
        self.contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalTo(368)
        }
        view.backgroundColor = UIColor.orange
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 20
        view.layer.cornerRadius = 50
        view.layer.borderColor = UIColor.white.cgColor
        
        self.view.addSubview(StatusName)
        StatusName.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(40)
        }
        StatusName.textColor = .white
        StatusName.font = UIFont.systemFont(ofSize: 40)
        
        self.view.addSubview(DeleteButton)
        DeleteButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-40)
            make.top.equalToSuperview().offset(40)
        }
        DeleteButton.setTitle("Delete", for: .normal)
        DeleteButton.setTitleColor(.white, for: .normal)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
