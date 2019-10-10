//
//  TaskCollectionViewCell.swift
//  todolist
//
//  Created by Mac on 10/09/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

final class DashboardCollectionViewCell: UICollectionViewCell {
    
    var boardTitleLabel = UILabel()
    var textLabel = UILabel()
    let deleteBoardBtn = UIButton()
    
    private let barView = UIView()
    private let addUserBtn = UIButton()
    private var guestTableView = UITableView()
    private let color = [UIColor.orange, UIColor.red, UIColor.purple,UIColor.blue]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        setupGuestTableView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    final private func setupCell(){
        
        self.contentView.backgroundColor = UIColor(red:1.00, green:0.19, blue:0.31, alpha:1.0)
        self.contentView.snp.makeConstraints{ make in
            make.width.equalTo(300)
            make.height.equalTo(250)
            make.centerX.equalToSuperview()
        }
        self.contentView.layer.cornerRadius = 25
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.contentView.layer.shadowRadius = 4
        self.contentView.layer.shadowOpacity = 0.3
        self.contentView.layer.masksToBounds = false
        
        self.contentView.addSubview(boardTitleLabel)
        boardTitleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(6)
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(140)
        }
        boardTitleLabel.text = "Board title"
        boardTitleLabel.textColor = .black
        boardTitleLabel.font = UIFont.systemFont(ofSize: 32)

        self.contentView.addSubview(deleteBoardBtn)
        deleteBoardBtn.snp.makeConstraints{ make in
            make.top.equalTo(boardTitleLabel)
            make.right.equalTo(-12)
            make.size.equalTo(24)
        }
        let image = UIImage(named: "delete")
        deleteBoardBtn.setBackgroundImage(image, for: .normal)
        
        self.contentView.addSubview(barView)
        barView.snp.makeConstraints{ make in
            make.height.equalTo(1)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
        }
        barView.backgroundColor = .white
        
        self.contentView.addSubview(textLabel)
        textLabel.snp.makeConstraints{ make in
            make.top.equalTo(boardTitleLabel.snp.bottom)
            make.bottom.equalTo(barView.snp.top)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        textLabel.textColor = .white
        
        self.contentView.addSubview(addUserBtn)
        addUserBtn.snp.makeConstraints{make in
            make.top.equalTo(barView).offset(10)
            make.right.equalToSuperview().offset(-12)
            make.size.equalTo(27)
        }
        let addImage = UIImage(named: "plus icon")
        addUserBtn.setBackgroundImage(addImage, for: .normal)
    }
    
    final private func setupGuestTableView() {
        self.contentView.addSubview(guestTableView)
        guestTableView.snp.makeConstraints{ make in
            make.top.equalTo(barView)
            make.left.equalToSuperview()
            make.right.equalTo(addUserBtn)
            make.height.equalTo(30)
        }
        guestTableView.backgroundColor = .blue
        guestTableView.dataSource = self
        guestTableView.delegate = self
        guestTableView.register(GuestTableViewCell.self,forCellReuseIdentifier: "Cell")
    }
}

extension DashboardCollectionViewCell: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return color.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GuestTableViewCell
        let randomInt = Int.random(in: 0..<3)
        cell.imageView?.backgroundColor = color[randomInt]

        return cell
    }
    
    
}

extension DashboardCollectionViewCell: UITableViewDelegate{
    
}
