//
//  ViewController.swift
//  TestSlideMenu
//
//  Created by Mac on 17/10/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ContainerController: UIViewController {

    var boardID = ""
    var invited = [String]()
    //var menuController: UIViewController!
    var centerController: UIViewController!
    var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
       //  Do any additional setup after loading the view.
        configureHomeController()
        configureNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func configureNavigationBar() {
        
        let label1 = UIButton()
        label1.setTitle("...", for: .normal)
        label1.setTitleColor(.white, for: .normal)
        label1.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        label1.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        let backBtn = UIBarButtonItem(customView: label1)
        navigationItem.rightBarButtonItem = backBtn
        
    }

    @objc func showMenu() {
        handleMenuToggle()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    func configureHomeController() {
        let homeController = HomeController(VM: TaskVM(status: [], tasks: [], boardID: self.boardID))
        homeController.delegate = self
        centerController = UINavigationController(rootViewController: homeController)
        
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
   
    
    func configureMenuController() {
            let menuController = MenuController()
            menuController.setup(invited: self.invited)
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
        
    }
    
    func showMenuController(shouldExpand: Bool) {
        if shouldExpand {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = -300
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
            }, completion: nil)
        }
    }
    


}

extension ContainerController: HomeControllerDelegate {
    func handleMenuToggle() {
        if !isExpanded {
            configureMenuController()
        }
        
        isExpanded.toggle()
        showMenuController(shouldExpand: isExpanded)
    }
    
    
}

