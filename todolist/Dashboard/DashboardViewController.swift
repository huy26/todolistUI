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

class DashboardViewController: UIViewController {
    var boards = [Board(boardName: "Test", items: [])]
    
    var horizonalBarLeftAnchorConstraint: NSLayoutConstraint?
    

    //var homeController: HomeController?
    
    @IBOutlet weak var helloUserName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
   
    @IBOutlet weak var checkcollectionview: UICollectionView!
    @IBOutlet weak var addText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        checkcollectionview.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: .centeredHorizontally)
        setupHorizonalBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readBoardAPI { (error, boards) in
            if let error = error {
                self.onGetBoardError(error: error)
                print(error.localizedDescription)
                return
            }
            if let boards = boards {
                self.onReceivedBoards(boards: boards)
                self.collectionView.reloadData()
                self.checkcollectionview.reloadData()
                return
            }
        }
    }
    
    private func onReceivedBoards(boards: [Board]) {
        self.boards = boards
        print("set value")
        self.helloUserName.text = User.toPrint
        print("User email: \(User.toPrint)")
    }
    
    private func onGetBoardError(error: Error) {
        
    }
    

    @IBAction func onDeleteBoard(_ sender: Any) {
    if let selectedCells = collectionView.indexPathsForSelectedItems{
        let index = selectedCells.map {$0.item}.sorted().reversed()
        
        for indexPath in index{
            boards.remove(at: indexPath)
        }
        collectionView.deleteItems(at: selectedCells)
    }
        
    }
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
        if !addText.text!.isEmpty {
            let newboard = Board(boardName: addText.text!, items: [])
            self.boards.append(newboard)
            let indexPath = IndexPath(row: boards.count - 1, section: 0)
            print("number of board after added: \(Board.count)")
            print("indexPath: \(indexPath)")
            self.checkcollectionview.insertItems(at: [indexPath])
            self.checkcollectionview.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            self.checkcollectionview.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
            self.collectionView.insertItems(at: [indexPath])
            self.collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            uploadBoardAPI(board: newboard)
        }
    }
//        func addtolist (){
//        list.append(addText.text!)
//        let indexPath = IndexPath(row: list.count - 1, section: 0)
//        tableview.beginUpdates()
//        tableview.insertRows(at: [indexPath], with: .automatic)
//        tableview.endUpdates()
//
//        addText.text = ""
//        view.endEditing(true)
//    }
    func setupHorizonalBar () {
        let horizontalBarView = UIView()
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(horizontalBarView)
        
        horizonalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: checkcollectionview.leftAnchor)
        horizonalBarLeftAnchorConstraint?.isActive = true
        
        horizontalBarView.bottomAnchor.constraint(equalTo: checkcollectionview.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: checkcollectionview.widthAnchor, multiplier:  1/4).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    
}
extension DashboardViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func scrolltoMenuIndex(menuIndex: Int){
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: [] , animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*print(indexPath.item)
        let x = CGFloat(indexPath.item) * collectionView.frame.width / 4
        horizonalBarLeftAnchorConstraint?.constant = x
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {self.checkcollectionview.layoutIfNeeded()}, completion: nil)*/
        if collectionView == self.checkcollectionview{scrolltoMenuIndex(menuIndex: indexPath.item)}
        else
        {
        let vc = storyboard?.instantiateViewController(withIdentifier: "boarddetail") as! UINavigationController
        self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("number of board: \(Board.getBoardCount())")
       
        return Board.getBoardCount()
        //return boards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.checkcollectionview{
        let cell = checkcollectionview.dequeueReusableCell(withReuseIdentifier: "check", for: indexPath) as? checkCollectionViewCell
           // cell?.number.text = boards[indexPath.item]
        cell?.number.text = boards[indexPath.item].boardName
        cell?.backgroundColor = UIColor.white
        return cell!
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? DashboardCollectionViewCell
           // cell?.Testlabel.text = item[indexPath.item]
            cell?.Testlabel.text = boards[indexPath.item].boardName
            return cell!
        }
        /*else {
            let cell = taskcollectionview.dequeueReusableCell(withReuseIdentifier: "taskcell", for: indexPath) as? TaskCollectionViewCell
            cell?.Testlabel.text = taskitem[indexPath.item]
            return cell!
        }*/
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       // print(scrollView.contentOffset.x)
        horizonalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
       let index = targetContentOffset.pointee.x / scrollView.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        checkcollectionview.selectItem(at: indexPath, animated: true, scrollPosition: [])
        
    }
   
    
}


