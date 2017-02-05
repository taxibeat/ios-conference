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
    
    @IBOutlet var scheduleTable: WKInterfaceTable!
    var talksArray = [ScheduleItem]()

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        CloudKitManager.sharedInstance.fetchTalks { (talks, error) in
            if let theTalks = talks {
                self.talksArray = theTalks
                self.scheduleTable.setNumberOfRows(self.talksArray.count, withRowType: "scheduleRow")
                for (index, value) in self.talksArray.enumerated() {
                    if let row = self.scheduleTable.rowController(at: index) as? ScheduleRowController {
                        row.talkSpeakerLabel.setText(value.speakerName)
                        row.talkTimeLabel.setText(value.timeString)
                        row.talkTitleLabel.setText(value.description)
                    }
                }
            }
        }
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
