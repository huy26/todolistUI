import UIKit
import MobileCoreServices
class BoardCollectionViewCell: UICollectionViewCell {


    let footerID = "TableFooter"
    var tableView = UITableView()
    //var task: Task?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.register(TableViewCell.self,forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.separatorColor = UIColor.white
        tableView.backgroundColor = .clear
//        tableView.rowHeight = 450

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    weak var parentVC: BoardViewController?
    var status: Status?
    var boardID: String?
    override func awakeFromNib() {
        super.awakeFromNib()

        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10.0
        
    }

    func setup(with status: Status, boardID: String) {
        self.status = status
        self.boardID = boardID
        tableView.reloadData()
    }

    
    
    @objc func addTapped(_ sender: Any) {
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
                    //UserDefaults.standard.removeObject(forKey: "Board")
                    self.parentVC?.onreciveTask(tasks: tasks)

                    self.parentVC?.status.last?.items.last?.taskID = tasks.last?.taskID
//                    self.parentVC?.checkCollectionview.reloadData()
//                    self.parentVC?.collectionView.reloadData()
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

//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return status?.name
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        //cell.textLabel?.text = "\(status!.items[indexPath.row].taskName!)"
        cell.layer.cornerRadius = 50
        cell.backgroundColor = UIColor.clear
        cell.StatusName.text = "\(status!.items[indexPath.row].taskName!)"
        cell.DeleteButton.addTarget(self, action: #selector(deleteTask), for: .touchUpInside)
        return cell
    }
    
    @objc func deleteTask (_ sender: UIButton){
        guard
            let button = sender as? UIView,
            let cell = button.nearestAncestor(ofType: UITableViewCell.self),
            let tableView = cell.nearestAncestor(ofType: UITableView.self),
            let indexPath = tableView.indexPath(for: cell)
            else { return }
        let alertController = UIAlertController(title: "Confirm Delete", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            tableView.beginUpdates()
            deleteTaskAPI(task: self.status!.items[indexPath.row], boardID: self.boardID!)
            self.status!.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        parentVC?.present(alertController, animated: true, completion: nil)
        
        
    }
  

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TaskDetailVCViewController()
        vc.task = self.status?.items[indexPath.row]
        parentVC?.navigationController?.pushViewController(vc, animated: true)

        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        
        let addButton = UIButton()
        addButton.setTitle("Add Task", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        footer.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addTapped(_:)), for: .touchUpInside)
        addButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        footer.backgroundColor = UIColor.white
        return footer
    }
    
    
}

extension UIView {
    func nearestAncestor<T>(ofType type: T.Type) -> T? {
        if let me = self as? T { return me }
        return superview?.nearestAncestor(ofType: type)
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
            deleteTaskAPI(task: dataSource.items[sourceIndexPath.row], boardID: self.boardID!)
        }
    }

    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }

}
