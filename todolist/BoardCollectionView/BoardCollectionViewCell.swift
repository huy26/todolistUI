import UIKit
import MobileCoreServices
class BoardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    //var task: Task?
    weak var parentVC: BoardViewController?
    var status: Status?
    var boardID: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10.0
         tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
    }
    
    func setup(with status: Status, boardID: String) {
        self.status = status
        self.boardID = boardID
        tableView.reloadData()
    }
    
    @IBAction func addTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
            guard let text = alertController.textFields?.first?.text, !text.isEmpty else {
                return
            }
            
            guard let data = self.status else {
                return
            }
            
            data.items.append(Task(taskName: text, status: self.status!.name!))
            let addedIndexPath = IndexPath(item: data.items.count - 1, section: 0)
            self.tableView.insertRows(at: [addedIndexPath], with: .automatic)
            self.tableView.scrollToRow(at: addedIndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            uploadtaskAPI(boardID: self.boardID!, task: Task(taskName: text, status: data.name!))
            readTaskApi(boardID: self.boardID!, onCompleted: { (error, tasks) in
                if let error = error {
                    self.parentVC?.getonTaskerror(error: error)
                    print(error.localizedDescription)
                    return
                }
                if let tasks = tasks {
                    UserDefaults.standard.removeObject(forKey: "Board")
                    self.parentVC?.onreciveTask(tasks: tasks)
                    
                    self.parentVC?.status.last?.items.last?.taskID = tasks.last?.taskID
                    self.parentVC?.checkCollectionview.reloadData()
                    self.parentVC?.collectionView.reloadData()
                    return
                }
            })
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
       
       parentVC?.present(alertController,animated: true)
        
    }
}

extension BoardCollectionViewCell: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return status?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return status?.name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(status!.items[indexPath.row].taskName!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


extension BoardCollectionViewCell: UITableViewDragDelegate {

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard let status = status, let stringData = status.items[indexPath.row].taskName!.data(using: .utf8) else {
            return []
        }

        let itemProvider = NSItemProvider(item: stringData as NSData, typeIdentifier: kUTTypePlainText as String)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        session.localContext = (status, indexPath, tableView)
        deleteTaskAPI(task: status.items[indexPath.item], boardID: self.boardID!)
        return [dragItem]
    }

}
extension BoardCollectionViewCell: UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
       
        if coordinator.session.hasItemsConforming(toTypeIdentifiers: [kUTTypePlainText as String]) {
            coordinator.session.loadObjects(ofClass: NSString.self) { (items) in
                guard let string = items.first as? String else {
                    return
                }
                var updatedIndexPaths = [IndexPath]()
                switch (coordinator.items.first?.sourceIndexPath, coordinator.destinationIndexPath) {
                case (.some(let sourceIndexPath), .some(let destinationIndexPath)):
                    // Same Table View
                    if sourceIndexPath.row < destinationIndexPath.row {
                        updatedIndexPaths =  (sourceIndexPath.row...destinationIndexPath.row).map { IndexPath(row: $0, section: 0) }
                    } else if sourceIndexPath.row > destinationIndexPath.row {
                        updatedIndexPaths =  (destinationIndexPath.row...sourceIndexPath.row).map { IndexPath(row: $0, section: 0) }
                    }
                    self.tableView.beginUpdates()
                    self.status?.items.remove(at: sourceIndexPath.row)
                    self.status?.items.insert(Task(taskName: string, status: (self.status?.name!)!), at: destinationIndexPath.row)
                    
                    self.tableView.reloadRows(at: updatedIndexPaths, with: .automatic)
                    self.tableView.endUpdates()
                    break
                    
                case (nil, .some(let destinationIndexPath)):
                    // Move data from a table to another table
                   self.removeSourceTableData(localContext: coordinator.session.localDragSession?.localContext)
                    self.tableView.beginUpdates()
                   let indexpath = self.tableView.indexPathForSelectedRow
                    self.status?.items.insert(Task(taskName: string, status: (self.status?.name!)!), at: destinationIndexPath.row)
                    self.tableView.insertRows(at: [destinationIndexPath], with: .automatic)
                    self.tableView.endUpdates()
                    break
                    
                    
                case (nil, nil):
                    // Insert data from a table to another table
                    self.removeSourceTableData(localContext: coordinator.session.localDragSession?.localContext)
                    self.tableView.beginUpdates()
                    self.status?.items.append(Task(taskName: string, status: (self.status?.name!)!))
                    self.tableView.insertRows(at: [IndexPath(row: self.status!.items.count - 1 , section: 0)], with: .automatic)
                    self.tableView.endUpdates()
                    break
                    
                default: break
                    
                }
                uploadtaskAPI(boardID: self.boardID!, task: Task(taskName: string, status: (self.status?.name!)!))
                
            }
            
        }
        
    }
    
    func removeSourceTableData(localContext: Any?) {
        if let (dataSource, sourceIndexPath, tableView) = localContext as? (Status, IndexPath, UITableView) {
            tableView.beginUpdates()
            dataSource.items.remove(at: sourceIndexPath.row)
            tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
}
