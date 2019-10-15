
import UIKit

class DescriptionVC: UIViewController {
    private var textField = UITextView()
    var task: Task?
    var boardID: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if task!.des != nil {
            textField.text = task!.des
        }
        
        self.view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(80)
        }
        
        let CancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        let DoneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done))
        navigationItem.leftBarButtonItem = CancelButton
        navigationItem.rightBarButtonItem = DoneButton

            }
    
    @objc func cancel() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func done () {
        guard let task = task else{
            return
        }
        
        guard let boardID = boardID else {
            return
        }
        task.changeDescription(des: textField.text)
        updateTaskAPI(task: task, boardID: boardID)
        self.navigationController?.popViewController(animated: true)
        
    }

    

}
