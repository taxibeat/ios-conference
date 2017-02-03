//
//  UIImageExtensions.swift
//  iOSConf
//
//  Created by Nikos Maounis on 04/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import UIKit

extension String {
    
    func image(fontSize: CGFloat) -> UIImage? {
        let font = UIFont(name: "taxibeat", size: fontSize)
        let size = (self as NSString).size(attributes: [NSFontAttributeName: font!])
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        self.draw(at: CGPoint(x: 0.0, y: 0.0), withAttributes: [NSFontAttributeName: font!])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
