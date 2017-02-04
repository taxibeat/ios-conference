//
//  LaunchViewController.swift
//  iOSConf
//
//  Created by Nikos Maounis on 03/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import UIKit
import TBConfFramework

class LaunchViewController: ConferenceViewController {

    @IBOutlet private weak var magicButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        styleMagicButton()
        activityIndicator.startAnimating()
        welcomeLabel.text = "Fetching one more thing..."
        self.magicButton.alpha = 0.0
        fetchDataFromCloudKit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchDataFromCloudKit() {
        CloudKitManager.sharedInstance.fetchTalks { (talks, error) in
            if error == nil {
                if let theTalks = talks {
                    CloudKitManager.sharedInstance.talks = theTalks
                }
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.welcomeLabel.text = "Hello cocoageek, lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt"
                    UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                        self.magicButton.alpha = 1.0
                        self.magicButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                        self.magicButton.transform = CGAffineTransform.identity
                    }, completion: { (finished) in
                        
                    })
                }
            }
        }
        
        CloudKitManager.sharedInstance.fetchSpeakers { (speakers, error) in
            if error == nil {
                if let theSpeakers = speakers {
                    CloudKitManager.sharedInstance.speakers = theSpeakers
                }
            }
        }
    }
    
    // MARK: Button styling
    
    func styleMagicButton() {
        self.magicButton.layer.cornerRadius = 10.0
        let gradient = GradientView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        gradient.setHorizontalGradientLayer(#colorLiteral(red: 0.1019607843, green: 0.07058823529, blue: 0.6156862745, alpha: 1), endColor: #colorLiteral(red: 0.02352941176, green: 0.7843137255, blue: 0.8745098039, alpha: 1))
        gradient.layer.cornerRadius = 10.0
        gradient.isUserInteractionEnabled = false
        self.magicButton.insertSubview(gradient, at: 0)
        ConstraintsHandler.constrain(view: self.magicButton, toView: gradient)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
