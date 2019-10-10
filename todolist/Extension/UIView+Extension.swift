//
//  UIView+Extension.swift
//  todolist
//
//  Created by Mac on 10/9/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

extension UIView {
    
    var safeArea: ConstraintLayoutGuideDSL {
        return safeAreaLayoutGuide.snp
    }
    
}
