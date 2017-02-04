//
//  VenueViewController.swift
//  iOSConf
//
//  Created by Nikos Maounis on 04/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import UIKit
import MapKit

class VenueViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var taxibeatButton: UIButton!
    @IBOutlet private weak var venueInfoContainerView: UIView!
    @IBOutlet private weak var venueNameLabel: UILabel!
    @IBOutlet private weak var venueAddressLabel: UILabel!
    @IBOutlet private weak var directionsButton: UIButton!
    @IBOutlet private weak var shadowView: UIView!
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        styleDirectionsButton()
        styleVenueContainer()
        addVenuePin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Styling
    
    func styleVenueContainer() {
        venueInfoContainerView.layer.cornerRadius = 10.0
        taxibeatButton.layer.cornerRadius = 10.0
        
        shadowView.layer.cornerRadius = 10.0
        shadowView.layer.shadowColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1).cgColor
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowOpacity = 0.7
        shadowView.layer.shadowRadius = 4.0
    }
    
    func styleDirectionsButton() {
        let gradient = GradientView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        gradient.setHorizontalGradientLayer(#colorLiteral(red: 0.1019607843, green: 0.07058823529, blue: 0.6156862745, alpha: 1), endColor: #colorLiteral(red: 0.02352941176, green: 0.7843137255, blue: 0.8745098039, alpha: 1))
        gradient.isUserInteractionEnabled = false
        self.directionsButton.insertSubview(gradient, at: 0)
        ConstraintsHandler.constrain(view: self.directionsButton, toView: gradient)
    }
    
    
    // MARK: Map
    
    func addVenuePin() {
        let venueLocation = CLLocationCoordinate2DMake(37.9787925, 23.7123368)

        let dropPin = MKPointAnnotation()
        dropPin.coordinate = venueLocation
        dropPin.title = "Gazarte"
        mapView.addAnnotation(dropPin)

        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegion(center: dropPin.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, edgePadding: UIEdgeInsetsMake(0.0, 0.0, 290.0, 0.0), animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
