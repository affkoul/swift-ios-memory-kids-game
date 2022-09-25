//
//  CustomLabel.swift
//  memory
//
//  Created by ANATOLI DIMITROV KOUEMO NGAYO on 2020/4/5.
//  Copyright © 2020 AnatDim. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }
    
    
    func setupLabel() {
        setShadow()
        textColor = UIColor.white
        textAlignment = NSTextAlignment.center
        
        backgroundColor      = Colors.coolGreen
        font     = UIFont(name: "AvenirNext-DemiBold", size: 18)
        layer.cornerRadius   = 10
        layer.borderWidth    = 10.0
        layer.borderColor    = Colors.coolOrange.cgColor
    }
    
    
    private func setShadow() {
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius  = 8
        layer.shadowOpacity = 0.5
        clipsToBounds       = true
        layer.masksToBounds = true
    }
    
    func shake() {
        let shake           = CABasicAnimation(keyPath: "position")
        shake.duration      = 0.1
        shake.repeatCount   = 2
        shake.autoreverses  = true
        
        let fromPoint       = CGPoint(x: center.x - 8, y: center.y)
        let fromValue       = NSValue(cgPoint: fromPoint)
        
        let toPoint         = CGPoint(x: center.x + 8, y: center.y)
        let toValue         = NSValue(cgPoint: toPoint)
        
        shake.fromValue     = fromValue
        shake.toValue       = toValue
        
        layer.add(shake, forKey: "position")
    }
}

