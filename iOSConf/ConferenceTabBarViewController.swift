//
//  ConferenceTabBarViewController.swift
//  iOSConf
//
//  Created by Nikos Maounis on 04/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import UIKit

class ConferenceTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setImagesForItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setImagesForItems() {
        self.tabBar.items?[0].image = "J".image(fontSize: 20.0)
        self.tabBar.items?[0].selectedImage = "J".image(fontSize: 20.0)
        
        self.tabBar.items?[1].image = "x".image(fontSize: 20.0)
        self.tabBar.items?[1].selectedImage = "x".image(fontSize: 20.0)
        
        self.tabBar.items?[2].image = "S".image(fontSize: 20.0)
        self.tabBar.items?[2].selectedImage = "S".image(fontSize: 20.0)
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
