//
//  ConstraintsHandler.swift
//  iOSConf
//
//  Created by Nikos Maounis on 03/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import UIKit

class ConstraintsHandler: NSObject {
    
    static func constrain(view: UIView, toView: UIView) {
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: toView, attribute: .bottom, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: toView, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: toView, attribute: .leading, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: toView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
            ])
        
    }
    
    static func centerX(view: UIView, toCenterXof toView: UIView) {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: toView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
            ])
    }
    
    static func centerY(view: UIView, toCenterYof toView: UIView) {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: toView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
            ])
    }
    
    static func center(view: UIView, toView: UIView) {
        ConstraintsHandler.centerX(view: view, toCenterXof: toView)
        ConstraintsHandler.centerY(view: view, toCenterYof: toView)
    }
    
    static func constrainWidth(view: UIView, to: CGFloat) {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: to)
            ])
    }
    
    static func constrainHeight(view: UIView, to: CGFloat) {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: to)
            ])
    }
    
    static func constrainSize(view: UIView, toWidth width: CGFloat, andHeight height: CGFloat) {
        ConstraintsHandler.constrainWidth(view: view, to: width)
        ConstraintsHandler.constrainHeight(view: view, to: height)
    }
    
    static func constrain(attribute: NSLayoutAttribute, ofView view: UIView, toAttribute: NSLayoutAttribute, ofView toView: UIView) {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: toView, attribute: toAttribute, multiplier: 1.0, constant: 0.0)
            ])
    }
    
    static func constrain(attribute: NSLayoutAttribute, ofView view: UIView, toAttribute: NSLayoutAttribute, ofView toView: UIView, constant: CGFloat) {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: toView, attribute: toAttribute, multiplier: 1.0, constant: constant)
            ])
    }
    
}
