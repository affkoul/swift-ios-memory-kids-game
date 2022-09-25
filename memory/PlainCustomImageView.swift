//
//  PlainCustomImageView.swift
//  memory
//
//  Created by ANATOLI DIMITROV KOUEMO NGAYO on 2020/4/6.
//  Copyright © 2020 AnatDim. All rights reserved.
//

import UIKit

class PlainCustomImageView: UIImageView {
    
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
