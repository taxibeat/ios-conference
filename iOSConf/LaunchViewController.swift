//
//  LaunchViewController.swift
//  iOSConf
//
//  Created by Nikos Maounis on 03/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var magicButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGradient()
        styleMagicButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupGradient() {
        let gradient = GradientView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        gradient.setGradientLayer(#colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1), endColor: #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1))
        self.view.insertSubview(gradient, at: 0)
        ConstraintsHandler.constrain(view: self.view, toView: gradient)
    }
    
    func styleMagicButton() {
        self.magicButton.layer.cornerRadius = 10.0
        let gradient = GradientView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        gradient.setHorizontalGradientLayer(#colorLiteral(red: 0.1019607843, green: 0.07058823529, blue: 0.6156862745, alpha: 1), endColor: #colorLiteral(red: 0.02352941176, green: 0.7843137255, blue: 0.8745098039, alpha: 1))
        gradient.layer.cornerRadius = 10.0
        self.magicButton.insertSubview(gradient, at: 0)
        ConstraintsHandler.constrain(view: self.magicButton, toView: gradient)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
