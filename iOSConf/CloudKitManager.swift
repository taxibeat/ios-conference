//
//  CloudKitManager.swift
//  iOSConf
//
//  Created by Nikos Maounis on 04/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import UIKit
import CloudKit

struct CloudKitConstants {
    static let cloudKitContainerIdentifier = "iCloud.com.taxibeat.iOSConf"
}

public class CloudKitManager: NSObject {
    public static let sharedInstance = CloudKitManager()
    public var talks: [ScheduleItem]?
    public var speakers: [Speaker]?
    
    private override init() {
        
    }
    
    public func fetchSpeakers(_ completion:@escaping (_ speakers:[Speaker]?, _ error: Error?) -> ()) {
        var items: [CKRecord] = [CKRecord]()
        let query = CKQuery(recordType: "Speakers", predicate: NSPredicate(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: "Weight", ascending: true)]
        let queryOperation = CKQueryOperation(query: query)
        
        Log.printThis("Start fetch")
        
        queryOperation.recordFetchedBlock = { (record: CKRecord!) in
            items.append(record)
        }
        
        queryOperation.qualityOfService = .userInteractive
        
        queryOperation.queryCompletionBlock = { (cursor: CKQueryCursor?, error: Error?) in
            if error != nil {
                completion(nil, error)
            } else {
                var speakerArray = [Speaker]()
                
                for item in items {
                    let speaker = Speaker(record: item)
                    
                    if let newSpeaker = speaker {
                        speakerArray.append(newSpeaker)
                    }
                }
                
                speakerArray.sort {
                    guard let weight1 = $0.weight, let weight2 = $1.weight else { return false }
                    return weight1 < weight2
                }
                
                completion(speakerArray, nil)
            }
        }
        
        let database: CKDatabase = CKContainer.default().publicCloudDatabase
        database.add(queryOperation)
    }
    
    public func fetchTalks(_ completion:@escaping (_ talks:[ScheduleItem]?, _ error: Error?) -> ()) {
        var items: [CKRecord] = [CKRecord]()
        let query = CKQuery(recordType: "Talks", predicate: NSPredicate(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: "Weight", ascending: true)]
        let queryOperation = CKQueryOperation(query: query)
        
        Log.printThis("Start fetch")
        
        queryOperation.recordFetchedBlock = { (record: CKRecord!) in
            items.append(record)
        }
        
        queryOperation.qualityOfService = .userInteractive
        
        queryOperation.queryCompletionBlock = { (cursor: CKQueryCursor?, error: Error?) in
            if error != nil {
                completion(nil, error)
            } else {
                var talksArray = [ScheduleItem]()
                
                for item in items {
                    let scheduleItem = ScheduleItem(record: item)
                    
                    if let newTalk = scheduleItem {
                        talksArray.append(newTalk)
                    }
                }
                
                talksArray.sort {
                    guard let weight1 = $0.weight, let weight2 = $1.weight else { return false }
                    return weight1 < weight2
                }
                
                completion(talksArray, nil)
            }
        }
        
        #if os(watchOS)
            let database: CKDatabase = CKContainer(identifier:CloudKitConstants.cloudKitContainerIdentifier).publicCloudDatabase
            database.add(queryOperation)
        #else
            let database: CKDatabase = CKContainer.default().publicCloudDatabase
            database.add(queryOperation)
        #endif
    }
}
