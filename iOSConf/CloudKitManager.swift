//
//  CloudKitManager.swift
//  iOSConf
//
//  Created by Nikos Maounis on 04/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import UIKit
import CloudKit

public class CloudKitManager: NSObject {
    public static let sharedInstance = CloudKitManager()
    
    public func fetchSpeakers(_ completion:@escaping (_ speakers:[Speaker]?, _ error: Error?) -> ()) {
        var items: [CKRecord] = [CKRecord]()
        let query = CKQuery(recordType: "Speakers", predicate: NSPredicate(format: "TRUEPREDICATE"))
        let queryOperation = CKQueryOperation(query: query)
        
        Log.printThis("Start fetch")
        
        queryOperation.recordFetchedBlock = { (record: CKRecord!) -> () in
            items.append(record)
        }
        
        queryOperation.qualityOfService = .userInteractive
        
        queryOperation.queryCompletionBlock = { (cursor: CKQueryCursor?, error: Error?) in
            if error != nil {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                completion(nil, error)
            } else {
                var speakerArray = [Speaker]()
                
                for item in items {
                    let speaker = Speaker(record: item)
                    
                    if let newSpeaker = speaker {
                        speakerArray.append(newSpeaker)
                    }
                }
                completion(speakerArray, nil)
            }
        }
        
        let database: CKDatabase = CKContainer.default().publicCloudDatabase
        database.add(queryOperation)
    }
}
