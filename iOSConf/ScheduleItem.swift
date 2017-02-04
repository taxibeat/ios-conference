//
//  ScheduleItem.swift
//  iOSConf
//
//  Created by Nikos Maounis on 04/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import UIKit
import CloudKit

public struct ScheduleItem {
    public var description: String?
    public var speakerName: String?
    public var speakerPosition: String?
    public var timeString: String?
    public var hasSpeaker: Bool?
    public var weight: Int?
    
    public init?(record: CKRecord) {
        guard let theDescription = record.object(forKey: "Description") as? String,
            let itHasSpeaker = record.object(forKey: "hasSpeaker") as? Int,
            let theTimeString = record.object(forKey: "TimeString") as? String,
            let theWeight = record.object(forKey: "Weight") as? Int else { return nil }
        
        self.description = theDescription
        
        if  let theSpeakerName = record.object(forKey: "Speaker") as? String {
            self.speakerName = theSpeakerName
        }
        
        if  let theSpeakerPosition = record.object(forKey:"SpeakerPosition") as? String {
            self.speakerPosition = theSpeakerPosition
        }
        
        self.timeString = theTimeString
        self.hasSpeaker = Bool(itHasSpeaker as NSNumber)
        self.weight = theWeight
    }
}
