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

extension UIButton {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.98
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.1
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 1
        layer.add(flash, forKey: nil)
    }
}
//MARK: Get Date + Time for Title
func getCurrentDateTime() -> String{
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.dateFormat = "EE, dd MMM"
    let str = formatter.string(from: Date())
    return str
}
