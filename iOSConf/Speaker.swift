//
//  Speaker.swift
//  iOSConf
//
//  Created by Nikos Maounis on 04/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import UIKit
import CloudKit

public struct Speaker {
    public var name: String?
    public var position: String?
    public var bio: String?
    public var avatar: CKAsset?
    public var avatarImage: UIImage?
    
    public init?(record: CKRecord) {
        guard let theName = record.object(forKey: "Name") as? String,
            let thePosition = record.object(forKey: "Position") as? String,
            let theBio = record.object(forKey: "Bio") as? String,
            let theAvatar = record.object(forKey: "Avatar") as? CKAsset else { return nil }
        
        self.name = theName
        self.position = thePosition
        self.bio = theBio
        self.avatar = theAvatar
        
        if let fileAsset = avatar {
            let data = try! Data(contentsOf: fileAsset.fileURL)
            self.avatarImage = UIImage(data: data)
        }
    }
}
