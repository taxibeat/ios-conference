//
//  VenueInterfaceController.swift
//  iOSConf
//
//  Created by Nikos Maounis on 08/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import WatchKit
import Foundation


class VenueInterfaceController: WKInterfaceController {
    @IBOutlet var venueMap: WKInterfaceMap!
    @IBOutlet var venueLabel: WKInterfaceLabel!
    
    let coordinate = CLLocationCoordinate2DMake(37.9787925, 23.7123368)

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        venueLabel.setText("Voutadon 34, Athens, Greece")
        setupMap()
    }
    
    func setupMap() {
        venueMap.setVisibleMapRect(MKMapRect(origin: MKMapPointForCoordinate(coordinate), size: MKMapSize(width: 0.5, height: 0.5)))
        let span = MKCoordinateSpanMake(0.003, 0.003)
        venueMap.setRegion(MKCoordinateRegion(center: coordinate, span: span))
        venueMap.addAnnotation(coordinate, withImageNamed: "venueIcon", centerOffset: CGPoint(x: 0.0, y: -9.0))
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
