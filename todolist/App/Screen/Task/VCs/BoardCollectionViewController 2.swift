import UIKit
import MobileCoreServices
import FirebaseAuth
import Firebase

class BoardCollectionViewController: UICollectionView, UICollectionViewDelegateFlowLayout {

//    var boards = [
//        Board(boardName: "Todo", items: ["Database Migration", "Schema Design", "Storage Management", "Model Abstraction"]),
//        Board(boardName: "In Progress", items: ["Push Notification", "Analytics", "Machine Learning"]),
//        Board(boardName: "Done", items: ["System Architecture", "Alert & Debugging"])
//    ]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationController?.isNavigationBarHidden = false
//
//        setupAddButtonItem()
//        setupRemoveButtonItem()
//        setupBackbuttonItem()
//        updateCollectionViewItem(with: view.bounds.size)
////        readAPIboard()
//    }
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        updateCollectionViewItem(with: size)
//    }
//
//    private func updateCollectionViewItem(with size: CGSize) {
//        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
//            return
//        }
//        layout.itemSize = CGSize(width: 225, height: size.height * 0.8)
//    }
//    func setupRemoveButtonItem(){
//        let button = UIButton(type: . system)
//        button.setTitle("Delete", for: .normal)
//        button.setTitleColor(.red, for: .normal)
//        button.addInteraction(UIDropInteraction(delegate: self))
//        let removeBarButton = UIBarButtonItem(customView: button)
//        toolbarItems?.append(removeBarButton)
//    }
//    func setupBackbuttonItem() {
//        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backtoBoard(_:)))
//        navigationItem.leftBarButtonItem = backButton
//    }
//    @objc func backtoBoard(_ sender: Any){
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! UINavigationController
//        self.present(vc, animated: true, completion: nil)
//    }
//    func setupAddButtonItem() {
//        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addListTapped(_:)))
//        navigationItem.rightBarButtonItem = addButtonItem
//    }
//
//    @IBAction func onLogout(_ sender: Any) {
//
//        let firebaseAuth = Auth.auth()
//        do {
//            try firebaseAuth.signOut()
//            let homeViewcontroller = storyboard?.instantiateViewController(withIdentifier: "Home") as! UINavigationController
//            self.present(homeViewcontroller, animated: true, completion: nil)
//        } catch let signOutError as NSError {
//            print ("Error signing out: %@", signOutError)
//        }
//
//    }
//    @objc func addListTapped(_ sender: Any) {
//        let alertController = UIAlertController(title: "Add List", message: nil, preferredStyle: .alert)
//        alertController.addTextField(configurationHandler: nil)
//        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
//            guard let text = alertController.textFields?.first?.text, !text.isEmpty else {
//                return
//            }
//
//            self.boards.append(Board(boardName: text, items: []))
//
//            let addedIndexPath = IndexPath(item: self.boards.count - 1, section: 0)
//
//            self.collectionView.insertItems(at: [addedIndexPath])
//            self.collectionView.scrollToItem(at: addedIndexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
//            APIboard(board: Board(boardName: text, items: []))
//        }))
//
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        present(alertController, animated: true)
//
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return boards.count
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BoardCollectionViewCell
//
//        cell.setup(with: boards[indexPath.item])
//        cell.parentVC = self
//        return cell
//    }
    
}
//extension BoardCollectionViewController: UIDropInteractionDelegate {
//
//    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
//        return UIDropProposal(operation: .move)
//    }
//
//    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
//
//        if session.hasItemsConforming(toTypeIdentifiers: [kUTTypePlainText as String]) {
//            session.loadObjects(ofClass: NSString.self) { (items) in
//                guard let _ = items.first as? String else {
//                    return
//                }
//
//                if let (dataSource, sourceIndexPath, tableView) = session.localDragSession?.localContext as? (Board, IndexPath, UITableView) {
//                    tableView.beginUpdates()
//                    dataSource.items.remove(at: sourceIndexPath.row)
//                    tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
//                    tableView.endUpdates()
//                }
//            }
//        }
//    }
//}
