//
//  InterfaceController.swift
//  iOS.Conf Extension
//
//  Created by Nikos Maounis on 05/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import WatchKit
import Foundation
import CloudKit
import TBConfFrameworkWatch

class InterfaceController: WKInterfaceController {
    
    @IBOutlet var fetchDataLabel: WKInterfaceLabel!
    @IBOutlet var scheduleTable: WKInterfaceTable!
    
    var talksArray = [ScheduleItem]()
    
    enum ScheduleTableRowType: String {
        case scheduleRow = "scheduleRow"
        case noSpeakerRow = "noSpeakerRow"
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        CloudKitManager.sharedInstance.fetchTalks { (talks, error) in
            if error != nil {
                self.fetchDataLabel.setText("Something went wrong")
            } else {
                
            }
        }
    }
    
    @IBAction func openVenuController() {
        self.pushController(withName: "venueInterfaceController", context: nil)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
