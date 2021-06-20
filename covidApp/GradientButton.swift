//
//  GradientButton.swift
//  covidApp
//
//  Created by Mark Qiao on 6/19/21.
//

import UIKit

class GradientButton: UIButton {

    override init(frame: CGRect){
        super.init(frame:frame)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemTeal.cgColor]
        layer.addSublayer(gradientLayer)
    }

    required init?(coder aDecorder: NSCoder ){
        super.init(coder:aDecorder)
    }
}
