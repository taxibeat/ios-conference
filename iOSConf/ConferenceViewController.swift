//
//  ConferenceViewController.swift
//  iOSConf
//
//  Created by Nikos Maounis on 04/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import UIKit

class ConferenceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupGradient()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: Gradient setup
    
    func setupGradient() {
        let gradient = GradientView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        gradient.setGradientLayer(#colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1), endColor: #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1))
        self.view.insertSubview(gradient, at: 0)
        ConstraintsHandler.constrain(view: self.view, toView: gradient)
    }
}
