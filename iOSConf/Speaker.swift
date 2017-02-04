//
//  Speaker.swift
//  iOSConf
//
//  Created by Nikos Maounis on 04/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import UIKit
import CloudKit

class Speaker: NSObject {
    
    var name: String?
    var position: String?
    var bio: String?
    var avatar: CKAsset?
    
    var avatarImage: UIImage? {
        if let fileAsset = avatar {
            let data = try! Data(contentsOf: fileAsset.fileURL)
            return UIImage(data: data)
        }
        return nil
    }
    
    init?(record: CKRecord) {
        guard let theName = record.object(forKey: "Name") as? String,
            let thePosition = record.object(forKey: "Position") as? String,
            let theBio = record.object(forKey: "Bio") as? String,
            let theAvatar = record.object(forKey: "Avatar") as? CKAsset else { return nil }
        
        self.name = theName
        self.position = thePosition
        self.bio = theBio
        self.avatar = theAvatar
    }
    
//    func getAvatar() -> UIImage? {
//        if let file = self.avatar {
//            let data = try! Data(contentsOf: file.fileURL)
//            return UIImage(data: data)
//        }
//        return nil
//    }
}
