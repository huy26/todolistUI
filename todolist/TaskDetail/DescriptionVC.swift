
import UIKit

class DescriptionVC: UIViewController {
    var textField = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
        
    }

    

}
