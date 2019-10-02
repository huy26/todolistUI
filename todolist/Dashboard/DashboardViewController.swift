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

class DashboardViewController: UIViewController {
    //var boards = [Board(boardName: "Test", items: [])]
    
    var checkTextField: String?
    var boards = [Board]()
    var horizonalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    //var homeController: HomeController?
    @IBOutlet weak var helloUserName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var calendarLabel: UILabel!
    //@IBOutlet weak var checkcollectionview: UICollectionView!
    @IBOutlet weak var addText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        //checkcollectionview.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: [])
        //setupHorizonalBar()
        if let decoded  = UserDefaults.standard.data(forKey: "Board") {
            let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Board]
            self.boards = decodedTeams
            //checkcollectionview.reloadData()
            collectionView.reloadData()
        }
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //boards = UserDefaults.standard.object(forKey: "Board") as! [Board]
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
                //self.checkcollectionview.reloadData()
                return
            }
        }
        if User.toPrint == "" {
            User.toPrint = "Hello, "
        } else {
            self.helloUserName.text = User.toPrint
            print("User email: \(User.toPrint)")
        }
        getCurrentDateTime()
        print(boards.count)
    }
    
    private func onReceivedBoards(boards: [Board]) {
        self.boards = boards
        let encodeData = NSKeyedArchiver.archivedData(withRootObject: self.boards)
        UserDefaults.standard.set(encodeData, forKey: "Board")
        print("set value")
    }
    
    private func onGetBoardError(error: Error) {
        print(error.localizedDescription)
    }
    
    //    @IBAction func onDeleteBoard(_ sender: Any) {
    //        if boards.count != 0 {
    //        if let selectedCells = self.collectionView.indexPathsForSelectedItems{
    //            let index = selectedCells.map {$0.item}.sorted().reversed()
    //
    //            for indexPath in index{
    //                deleteBoardAPI(board: boards[indexPath])
    //                boards.remove(at: indexPath)
    //                Board.setBoardCount(value: -1)
    //            }
    //            self.collectionView.deleteItems(at: selectedCells)
    //            self.collectionView.reloadData()
    //            //self.checkcollectionview.reloadData()
    //            let selectedIndexPath = NSIndexPath(item: 0, section: 0)
    //            checkcollectionview.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: [])
    //            }
    //        }
    //    }
    
    @IBAction func onAddButton(_ sender: Any) {
        addBoard()
    }
    
    @IBAction func onLogout(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            Board.resetBoardCount(value: 0)
            let homeViewcontroller = storyboard?.instantiateViewController(withIdentifier: "Home") as! UINavigationController
            self.present(homeViewcontroller, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func addBoard (){
        let alertController = UIAlertController(title: "Add Board", message: nil, preferredStyle: .alert)
        alertController.addTextField{(textField) in
            textField.placeholder = "Board Name"
        }
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
            guard let text = alertController.textFields![0].text, !text.isEmpty else {
                return
            }
            
            let newboard = Board(boardName: text, items: [])
            self.boards.append(newboard)
            Board.setBoardCount(value: 1)
            print(Board.count)
            print(self.boards.count)
            let indexPath = IndexPath(row: self.boards.count - 1, section: 0)
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
                    //self.checkcollectionview.reloadData()
                    self.collectionView.reloadData()
                    return
                }
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
    
    //    func setupHorizonalBar () {
    //        let horizontalBarView = UIView()
    //        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
    //        view.addSubview(horizontalBarView)
    //
    //        horizonalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: checkcollectionview.leftAnchor)
    //        horizonalBarLeftAnchorConstraint?.isActive = true
    //
    //        horizontalBarView.bottomAnchor.constraint(equalTo: checkcollectionview.bottomAnchor).isActive = true
    //        horizontalBarView.widthAnchor.constraint(equalTo: checkcollectionview.widthAnchor, multiplier:  1/4).isActive = true
    //        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    //    }
    
    
    @IBAction func onEditingEndBoardTitle(_ sender: Any) {
        print(sender.self)
    }
}

extension DashboardViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //        if collectionView == self.checkcollectionview{
        //            //scrolltoMenuIndex(menuIndex: indexPath.item)
        //            collectionView.scrollToItem(at: indexPath as IndexPath, at: [] , animated: true)
        //        }
        //        else {
        let vc = storyboard?.instantiateViewController(withIdentifier: "boarddetail") as! BoardViewController
        vc.boardID = self.boards[indexPath.item].boardID!
        self.navigationController?.pushViewController(vc, animated: true)
        //}
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print("number of board: \(Board.getBoardCount())")
        print("number of items in section: \(boards.count)")
        return boards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        if collectionView == self.checkcollectionview{
        //            let cell = checkcollectionview.dequeueReusableCell(withReuseIdentifier: "check", for: indexPath) as? checkCollectionViewCell
        //            // cell?.number.text = boards[indexPath.item]
        //            print(indexPath.item)
        //            cell?.layer.cornerRadius = 20
        //            cell?.layer.borderWidth = 1
        //            cell?.layer.borderColor = UIColor.orange.cgColor
        //            cell?.number.text = boards[indexPath.item].boardName
        //            cell?.backgroundColor = UIColor.white
        //            cell?.number.delegate = self
        //            cell?.number.tag = indexPath.item
        //            return cell!
        //        }
        //        else {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? DashboardCollectionViewCell
        // cell?.Testlabel.text = item[indexPath.item]
        cell?.layer.cornerRadius = 20
        cell?.layer.borderWidth = 0
        //cell?.layer.borderColor = UIColor.orange.cgColor
        cell?.layer.masksToBounds = true
        
        cell?.layer.shadowColor = UIColor.black.cgColor
        cell?.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell?.layer.shadowRadius = 4
        cell?.layer.shadowOpacity = 0.3
        cell?.layer.masksToBounds = false
        //cell?.layer.shadowPath = UIBezierPath(roundedRect: cell!.bounds, cornerRadius: cell!.contentView.layer.cornerRadius).cgPath
        cell?.deleteBoardBtn.tag = indexPath.item
        cell?.boardTitleLabel.text = boards[indexPath.row].boardName
        cell?.boardTitleLabel.textColor = .white
        
        var text = ""
        for items in boards[indexPath.item].detail{
            let totalTask = boards[indexPath.item].totalTasks
            print("status: \(items.status ?? "")")
            print("number of this status: \(items.count ?? 0)")
            let itemText = "\(items.status!): \(items.count!) / \(totalTask)\n"
            text = String(format: "%@ %@", text, itemText)
        }
        
        cell?.deleteBoardBtn.addTarget(self, action: #selector(deleteBoard(sender:)), for: .touchUpInside)
        
        cell?.textLabel.text = text
        return cell!
        //}
        /*else {
         let cell = taskcollectionview.dequeueReusableCell(withReuseIdentifier: "taskcell", for: indexPath) as? TaskCollectionViewCell
         cell?.Testlabel.text = taskitem[indexPath.item]
         return cell!
         }*/
    }
    
    @objc func deleteBoard(sender: UIButton){
        let alertController = UIAlertController(title: "Confirm Delete", message: "There is no way to undo this operation.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler:{ (_) in
            let indexPath: Int = sender.tag
            deleteBoardAPI(board: self.boards[indexPath])
            self.boards.remove(at: indexPath)
            Board.setBoardCount(value: -1)
            self.collectionView.reloadData()
        }))
        alertController.addAction(UIAlertAction(title: "Cancle", style: .default, handler: nil))
        self.present(alertController,animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 35
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // print(scrollView.contentOffset.x)
        horizonalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let index = scrollView.contentOffset.y / scrollView.frame.height
//        print("index: \(index)")
//        let indexPath = IndexPath(item: Int(index + 0.5), section: 0)
//        print("indexpath: \(indexPath)")
//        self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 20)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = CGSize(width: view.frame.width, height: view.frame.height)
//        return size
//    }
    
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
    
    //    func textFieldDidBeginEditing(_ textField: UITextField) {
    //        self.checkTextField = textField.text
    //
    //        if let selectedCell = textField.superview?.superview as? UICollectionViewCell {
    //
    //            //let index = checkcollectionview.indexPath(for: selectedCell)!
    //            //var checkText = textField.text
    //
    //            let alertController = UIAlertController(title: "Change board name", message: nil, preferredStyle: .alert)
    //            alertController.addTextField(configurationHandler: nil)
    //            alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
    //                guard let text = alertController.textFields?.first?.text, !text.isEmpty else {
    //                    return
    //                }
    //                textField.text = text
    //                //for indexPath in index {
    //                updateBoardAPI(board: self.boards[index.item], newName: text)
    //                //print("\(self.boards[indexPath].boardID)")
    //                //}
    //                print(index)
    //
    //                print(selectedCell)
    //
    //            }))
    //            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    //
    //
    //            present(alertController,animated: true)
    //            //checkcollectionview.selectItem(at: index, animated: true, scrollPosition: [])
    //            scrolltoMenuIndex(menuIndex: index.item)
    //        }
    //    }
}
