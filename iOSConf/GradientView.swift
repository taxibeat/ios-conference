//
//  GradientView.swift
//  iOSConf
//
//  Created by Nikos Maounis on 03/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import UIKit

class GradientView: UIView {

    override class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initGradientLayer()
    }
    
    func initGradientLayer() {
        let glayer = self.layer as! CAGradientLayer
        glayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
    }
    
    func setGradientLayer(_ startColor:UIColor, endColor:UIColor) {
        let glayer = self.layer as! CAGradientLayer
        glayer.colors = [startColor.cgColor, endColor.cgColor]
    }

}
