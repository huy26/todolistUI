//
//  TabBarController.swift
//  todolist
//
//  Created by Mac on 10/4/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    //MARK:- UI Properties
    private var dashboardVC = DashboardViewController()
    private var profileVC = ProfileViewController()
    
    //private var dashItem = DashboardViewController()
    //private var profileItem = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabbarVCs = [dashboardVC, profileVC]
        
        dashboardVC.tabBarItem =  UITabBarItem(title: "Board", image: UIImage(named: "board_default")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "board_selected"))
        dashboardVC.modalPresentationStyle = .overFullScreen
        dashboardVC.navigationController?.isNavigationBarHidden = true
        dashboardVC.navigationController?.setNavigationBarHidden(true, animated: true)

          profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile_default")?.withRenderingMode(UIImage.RenderingMode.automatic), selectedImage: UIImage(named: "profile_selected"))
        profileVC.modalPresentationStyle = .overFullScreen
        profileVC.navigationController?.isNavigationBarHidden = true
        profileVC.navigationController?.setNavigationBarHidden(true, animated: true)

        let tabBarList = tabbarVCs.map { UINavigationController(rootViewController: $0) }
        viewControllers = tabBarList
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
}

