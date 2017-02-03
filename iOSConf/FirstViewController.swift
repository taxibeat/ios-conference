//
//  FirstViewController.swift
//  iOSConf
//
//  Created by Nikos Maounis on 02/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tabBarController?.tabBar.items?[0].image = "J".image(fontSize: 20.0)
        self.tabBarController?.tabBar.items?[0].selectedImage = "J".image(fontSize: 20.0)
        
        self.tabBarController?.tabBar.items?[1].image = "x".image(fontSize: 20.0)
        self.tabBarController?.tabBar.items?[1].selectedImage = "x".image(fontSize: 20.0)
        
        self.tabBarController?.tabBar.items?[2].image = "S".image(fontSize: 20.0)
        self.tabBarController?.tabBar.items?[2].selectedImage = "S".image(fontSize: 20.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

