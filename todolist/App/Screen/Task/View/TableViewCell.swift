//
//  TableViewCell.swift
//  todolist
//
//  Created by Mac on 09/09/2019.
//  Copyright © 2019 Mac. All rights reserved.
//
import UIKit

class TableViewCell: UITableViewCell {
    
    private var view = UIView()
    var StatusName = UILabel()
    var DeleteButton = UIButton()
    private var line = UIView()
    private var inviteButton = UIButton()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: .default, reuseIdentifier: "Cell")
        setupUI()
    }
    
    private func setupUI() {
        self.contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(368)
        }
        view.backgroundColor = UIColor.orange
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 20
        view.layer.cornerRadius = 50
        view.layer.borderColor = UIColor.white.cgColor
        
        self.view.addSubview(StatusName)
        StatusName.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
        }
        StatusName.textColor = .white
        StatusName.font = UIFont.systemFont(ofSize: 30)
        
        self.view.addSubview(DeleteButton)
        DeleteButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-40)
            make.top.equalToSuperview().offset(40)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        let image = UIImage(named: "deleteButton")
        DeleteButton.setImage(image, for: .normal)
        
        self.view.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-75)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        line.layer.backgroundColor = UIColor.white.cgColor
        
        self.view.addSubview(inviteButton)
        inviteButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        inviteButton.setImage(UIImage(named: "add"), for: .normal)
        
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
