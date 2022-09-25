//
//  MyImageView.swift
//  memory
//
//  Created by ANATOLI DIMITROV KOUEMO NGAYO on 2020/4/4.
//  Copyright © 2020 AnatDim. All rights reserved.
//

import UIKit

class MyImageView: UIImageView {
    var myImage : UIImage?
    var myTag : NSInteger?
    
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder :aDecoder)!
        self.isUserInteractionEnabled = true
    }
    func turn2Left()
    {
        UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromRight, animations: {
            
            self.image = self.myImage
        }, completion:
            { (finished) -> Void in
                
                // Items Non Interactable When Not Yet Flipped
                self.isUserInteractionEnabled = false
        })
    }
    func turn2Right()
    {
        UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromRight, animations: {
            self.image = UIImage(named:"iconQ.png")
        }, completion:
            { (finished) -> Void in
                // Items Interactable After Being Flipped
                self.isUserInteractionEnabled = true
        })
    }
}

