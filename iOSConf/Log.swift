//
//  Log.swift
//  iOSConf
//
//  Created by Nikos Maounis on 04/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import Foundation

class Log {
    class func printThis(_ object: Any) {
        #if DEBUG
            print(object)
        #endif
    }
}
