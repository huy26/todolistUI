//
//  TabBarController.swift
//  todolist
//
//  Created by Mac on 10/4/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dashboardVC = DashboardViewController()
        dashboardVC.tabBarItem = UITabBarItem(title: "Board", image: UIImage(named: "board_default")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "board_selected"))
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile_default")?.withRenderingMode(UIImage.RenderingMode.automatic), selectedImage: UIImage(named: "profile_selected"))
        
        let tabBarList = [dashboardVC, profileVC]
        viewControllers = tabBarList
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
}
