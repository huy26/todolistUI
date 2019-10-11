//
//  TaskCollectionViewCell.swift
//  todolist
//
//  Created by Mac on 10/09/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

final class DashboardCollectionViewCell: UICollectionViewCell {
    var board: Board?
    weak var parentVC: DashboardViewController?
    
    var boardTitleLabel = UILabel()
    var textLabel = UILabel()
    let deleteBoardBtn = UIButton()
    let addUserBtn = UIButton()
    private let barView = UIView()
    
    private var guestCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private let color = [UIColor.orange, UIColor.white, UIColor.purple,UIColor.blue]

    
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
        self.contentView.addSubview(guestCollectionView)
        guestCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(barView).offset(5)
            make.left.equalToSuperview().offset(5)
            make.right.equalTo(addUserBtn).offset(-25)
            make.height.equalTo(40)
        }
        guestCollectionView.layer.cornerRadius = 10
        guestCollectionView.backgroundColor = UIColor(red:1.00, green:0.19, blue:0.31, alpha:1.0)
        guestCollectionView.dataSource = self
        guestCollectionView.delegate = self
        guestCollectionView.register(GuestCollectionViewCell.self,forCellWithReuseIdentifier: "Cell")
    }
}

extension DashboardCollectionViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return color.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let random = Int.random(in: 0..<4)
        cell.backgroundColor = color[random]
        cell.layer.cornerRadius = 20
        return cell
    }

}

extension DashboardCollectionViewCell: UICollectionViewDelegate{
}

extension DashboardCollectionViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

}
