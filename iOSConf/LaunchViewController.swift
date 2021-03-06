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
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var welcomeLabel: UILabel!
    @IBOutlet private weak var logoVerticalAlignConstraint: NSLayoutConstraint!
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var poweredByView: UIView!
    
    struct welcomeText {
        static let fetchText = "Fetching one more thing..."
        static let introText = "A unique opportunity to meet some of the most influential speakers and to learn and discuss about best practices and latest development methodologies."
    }
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        styleMagicButton()
        activityIndicator.startAnimating()
        welcomeLabel.text = welcomeText.fetchText
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
                    self.hideActivity()
                    UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: .curveEaseIn, animations: {
                        self.magicButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                        self.magicButton.alpha = 1.0
                        self.magicButton.transform = CGAffineTransform.identity
                    }, completion: { (finished) in
                        
                    })
                }
            } else {
                self.showConnectionErrorAlert(error)
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
    
    func showConnectionErrorAlert(_ error: Error?) {
        let alert = UIAlertController(title: "Something went wrong", message: error?.localizedDescription, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "ΟΚ", style: .cancel) { (action) in
            self.magicButton.alpha = 1.0
            self.hideActivity()
        }
        
        alert.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true) {
            }
        }
    }
    
    func hideActivity() {
        self.activityIndicator.stopAnimating()
        self.welcomeLabel.text = welcomeText.introText
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
    
    @IBAction func magicButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: { 
            self.poweredByView.alpha = 0.0
            self.magicButton.alpha = 0.0
            self.welcomeLabel.alpha = 0.0
        }) { (finished) in
        }
        
        self.logoVerticalAlignConstraint.constant = 53.5 + self.calculateProperTopPaddingForAnimations() - UIScreen.main.bounds.size.height/2
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
            self.logoImageView.transform = CGAffineTransform(scaleX: 0.49, y: 0.49)
            self.view.layoutIfNeeded()
        }) { (finished) in
            self.performSegue(withIdentifier: "presentTabConSegue", sender: sender)
        }
    }
    
    func calculateProperTopPaddingForAnimations() -> CGFloat {
        if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436 {
            return 44.0
        } else {
            return 20.0
        }
    }
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "presentTabConSegue" {
            return false
        }
        
        return true
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
