
import UIKit

class DescriptionVC: UIViewController {
    private var textField = UITextView()
    var task: Task?
    var boardID: String?
    private var background = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if task!.des != nil {
            textField.text = task!.des
        }

        setupUI()
    }
}
    
extension DescriptionVC{
        private func setupUI() {
            self.view.addSubview(background)
            background.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.left.right.equalToSuperview()
                make.height.equalTo(90)
            }
            background.backgroundColor = UIColor.orange
            
            self.view.addSubview(textField)
            textField.snp.makeConstraints { (make) in
                make.left.right.bottom.equalToSuperview()
                make.top.equalTo(background.snp.bottom)
            }
            
            let CancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
            let DoneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done))
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            navigationItem.leftBarButtonItem = CancelButton
            navigationItem.rightBarButtonItem = DoneButton
            setupBarTitle()
            
        }
        final private func setupBarTitle(){
            let boardTextField = UILabel()
            boardTextField.snp.makeConstraints{ make in
                make.width.equalTo(120)
            }
            boardTextField.text = "Description"
            //boardTextField.font = UIFont.boldSystemFont(ofSize: 20)
            self.navigationItem.titleView = boardTextField
        }
    }

    
extension DescriptionVC {
    
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
