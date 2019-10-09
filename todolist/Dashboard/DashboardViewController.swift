//
//  DashboardViewController.swift
//  todolist
//
//  Created by Mac on 09/09/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Foundation

final class DashboardViewController: UIViewController {
    static var boards = [Board]() // Todo: create getInstance() + change to private
    
    private var calendarLabel = UILabel()
    private var helloUserName = UILabel()
    private let addBoardBtn = UIButton()
    private let barView = UIView()
    private let addboardVC = AddBoardViewController()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    let profileVC = UIViewController()
    //var horizonalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    //var homeController: HomeController?
    
    var checkTextField: String?
    private let cellReuseIndentifier = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //setupHorizonalBar()
        collectionView.register(DashboardCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIndentifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
//        if let decoded  = UserDefaults.standard.data(forKey: "Board") {
//            let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Board]
//            self.boards = decodedTeams
//            //checkcollectionview.reloadData()
//            collectionView.reloadData()
//        }
//
//        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController!.navigationBar.shadowImage = UIImage()
//        self.navigationController!.navigationBar.isTranslucent = true
        
        setupBoardUI()
      
    }
    // MARK:- Setup View
    
    final private func setupBoardUI(){
        self.view.backgroundColor = .white
        //self.definesPresentationContext = true
        //self.modalPresentationStyle = .overFullScreen
        setupTitle()
        setupCollectionView()
    }
    
    final private func setupTitle(){
        self.view.addSubview(calendarLabel)
        calendarLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(30)
        }
        calendarLabel.text = "Day"
        calendarLabel.font = UIFont.systemFont(ofSize: 19)
        calendarLabel.textColor = .black
        getCurrentDateTime()
        
        self.view.addSubview(helloUserName)
        helloUserName.snp.makeConstraints{ make in
            make.top.equalTo(calendarLabel).offset(27)
            make.left.equalToSuperview().offset(30)
        }
        helloUserName.text = "Hello"
        helloUserName.font = UIFont.systemFont(ofSize: 32)
        helloUserName.textColor = .black
        
        self.view.addSubview(addBoardBtn)
        addBoardBtn.snp.makeConstraints{ make in
            make.top.equalTo(helloUserName)
            make.right.equalToSuperview().offset(-30)
            make.size.equalTo(30)
        }
        let addIcon = UIImage(named: "plus icon")
        addBoardBtn.setBackgroundImage(addIcon, for: .normal)
        //addBoardBtn.addTarget(self, action: #selector(addBoard(_:)), for: .touchUpInside)
        addBoardBtn.addTarget(self, action: #selector(showAddBoardVC(_:)), for: .touchUpInside)
        
        self.view.addSubview(barView)
        barView.snp.makeConstraints{ make in
            make.bottom.equalTo(helloUserName)
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
        barView.backgroundColor = .lightGray
    }
    
    final private func setupCollectionView(){
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints{ make in
            make.top.equalTo(barView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview()
        }
        collectionView.backgroundColor = .white
        collectionView.bounces = true
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = true
        collectionView.isScrollEnabled = true
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.collectionView.collectionViewLayout = layout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //DashboardViewController.boards = UserDefaults.standard.object(forKey: "Board") as! [Board]
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.isNavigationBarHidden = true
        
        readBoardAPI { (error, boards) in
            if let error = error {
                self.onGetBoardError(error: error)
                print(error.localizedDescription)
                return
            }
            if let boards = boards {
                UserDefaults.standard.removeObject(forKey: "Board")
                self.onReceivedBoards(boards: boards)
                self.collectionView.reloadData()
                return
            }
        }
        if User.userNamePrint == "" {
            User.userNamePrint = "Hello, "
        } else {
            self.helloUserName.text = User.userNamePrint
            print("User email: \(User.userNamePrint)")
        }
        print(DashboardViewController.boards.count)
    }
    
    final private func onReceivedBoards(boards: [Board]) {
        DashboardViewController.boards = boards
        let encodeData = NSKeyedArchiver.archivedData(withRootObject: DashboardViewController.boards)
        UserDefaults.standard.set(encodeData, forKey: "Board")
        print("set value")
    }
    
    final private func onGetBoardError(error: Error) {
        print(error.localizedDescription)
    }
    
    @IBAction final private func onLogout(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            Board.resetBoardCount(value: 0)
            self.show(ViewController(), sender: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    @objc final private func addBoard (_ sender: Any){
        let alertController = UIAlertController(title: "Add Board", message: "create new board", preferredStyle: .alert)
        alertController.addTextField{(textField) in
            //textField.placeholder = "Board Name"
        }
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
            guard let text = alertController.textFields![0].text, !text.isEmpty else {
                return
            }
            
            let newboard = Board(boardName: text, items: [])
            DashboardViewController.boards.append(newboard)
            Board.setBoardCount(value: 1)
            print(Board.count)
            print(DashboardViewController.boards.count)
            let indexPath = IndexPath(row: DashboardViewController.boards.count - 1, section: 0)
            print("number of board after added: \(Board.count)")
            print("indexPath: \(indexPath)")
            //            self.checkcollectionview.insertItems(at: [indexPath])
            //            self.checkcollectionview.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            //            self.checkcollectionview.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
            self.collectionView.insertItems(at: [indexPath])
            self.collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            uploadBoardAPI(board: newboard)
            readBoardAPI { (error, boards) in
                if let error = error {
                    self.onGetBoardError(error: error)
                    print(error.localizedDescription)
                    return
                }
                if let boards = boards {
                    UserDefaults.standard.removeObject(forKey: "Board")
                    self.onReceivedBoards(boards: boards)
                    self.collectionView.reloadData()
                    return
                }
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
    
    @objc final private func showAddBoardVC(_ sender: UIButton){
        addboardVC.onDismiss = {
            print("Board dismiss")
            self.collectionView.reloadData()
        }
        //addboardVC.modalPresentationStyle = .none
        //self.show(addboardVC, sender: self)
        //addboardVC.definesPresentationContext = true
//        self.present(self.addboardVC, animated: true, completion: nil)
        self.navigationController?.pushViewController(addboardVC, animated: true)
        //self.tabBarController?.present(addboardVC, animated: true, completion: nil)
    }
    
    @objc func deleteBoard(sender: UIButton){
          let alertController = UIAlertController(title: "Confirm Delete", message: "There is no way to undo this operation.", preferredStyle: .alert)
          alertController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler:{ (_) in
              let indexPath = sender.tag
              deleteBoardAPI(board: DashboardViewController.boards[indexPath])
              DashboardViewController.boards.remove(at: indexPath)
              Board.setBoardCount(value: -1)
              self.collectionView.reloadData()
          }))
          alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
          self.present(alertController,animated: true)
      }
    
//    @objc final private func showProfileVC(_ sender: UIButton){
//        //addboardVC.modalPresentationStyle = .fullScreen
//        self.show(profileVC, sender: self)
//    }
}

// MARK:- CV datasource + delegate
extension DashboardViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //        if collectionView == self.checkcollectionview{
        //            //scrolltoMenuIndex(menuIndex: indexPath.item)
        //            collectionView.scrollToItem(at: indexPath as IndexPath, at: [] , animated: true)
        //        }
        //        else {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "boarddetail") as! BoardViewController
//        vc.boardID = DashboardViewController.boards[indexPath.item].boardID!
//        self.navigationController?.pushViewController(vc, animated: true)
        let vc = BoardViewController()
        vc.boardID = DashboardViewController.boards[indexPath.item].boardID!
        self.show(vc, sender: self)
        //}
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print("number of board: \(Board.getBoardCount())")
        print("number of items in section: \(DashboardViewController.boards.count)")
        return DashboardViewController.boards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIndentifier, for: indexPath) as? DashboardCollectionViewCell

        cell?.deleteBoardBtn.tag = indexPath.item

        cell?.boardTitleLabel.text = DashboardViewController.boards[indexPath.row].boardName
        cell?.boardTitleLabel.textColor = .white
        
        var text = ""
        for items in DashboardViewController.boards[indexPath.item].detail{
            let totalTask = DashboardViewController.boards[indexPath.item].totalTasks
            print("status: \(items.status ?? "")")
            print("number of this status: \(items.count ?? 0)")
            let itemText = "\(items.status!): \(items.count!) / \(totalTask)\n"
            text = String(format: "%@ %@", text, itemText)
        }
        
        cell?.deleteBoardBtn.addTarget(self, action: #selector(deleteBoard(sender:)), for: .touchUpInside)
        cell?.textLabel.text = text
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 35
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 250)
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // print(scrollView.contentOffset.x)
//        horizonalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    func getCurrentDateTime() {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.dateFormat = "EE, dd MMM"
        let str = formatter.string(from: Date())
        calendarLabel.text = str
    }
}

extension DashboardViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("editing")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
  
}
