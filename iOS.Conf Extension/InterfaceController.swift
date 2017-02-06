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
            if let theTalks = talks {
                self.talksArray = theTalks
                
                var rowTypes = [String]()
                for talk in theTalks {
                    if talk.hasSpeaker == true {
                        rowTypes.append(ScheduleTableRowType.scheduleRow.rawValue)
                    } else {
                        rowTypes.append(ScheduleTableRowType.noSpeakerRow.rawValue)
                    }
                }
                
                DispatchQueue.main.async {
                    self.fetchDataLabel.setAlpha(0.0)
                    self.scheduleTable.setRowTypes(rowTypes)
                    for (index, value) in self.talksArray.enumerated() {
                        if value.hasSpeaker == true {
                            if let row = self.scheduleTable.rowController(at: index) as? ScheduleRowController {
                                row.talkSpeakerLabel.setText(value.speakerName)
                                row.talkTimeLabel.setText(value.timeString)
                                row.talkTitleLabel.setText(value.description)
                            }
                        } else {
                            if let row = self.scheduleTable.rowController(at: index) as? TalkRowController {
                                row.talkTime.setText(value.timeString)
                                row.talkTitle.setText(value.description)
                            }
                        }
                    }
                }
            }
        }

//        testTable()
    }
    
    func testTable() {
        self.fetchDataLabel.setAlpha(0.0)
        self.scheduleTable.setRowTypes([ScheduleTableRowType.scheduleRow.rawValue, "noSpeakerRow", ScheduleTableRowType.scheduleRow.rawValue])
        
        
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
