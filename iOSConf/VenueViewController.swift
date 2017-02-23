//
//  VenueViewController.swift
//  iOSConf
//
//  Created by Nikos Maounis on 04/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import UIKit
import MapKit
import StoreKit
import TBConfFramework

class VenueViewController: UIViewController, MKMapViewDelegate, SKStoreProductViewControllerDelegate {

    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var taxibeatButton: UIButton!
    @IBOutlet private weak var venueInfoContainerView: UIView!
    @IBOutlet private weak var venueNameLabel: UILabel!
    @IBOutlet private weak var venueAddressLabel: UILabel!
    @IBOutlet private weak var directionsButton: UIButton!
    @IBOutlet private weak var shadowView: UIView!
    
    struct venue {
        static let coordinate = CLLocationCoordinate2DMake(37.9787925, 23.7123368)
        static let address = "Voutadon 34, Athens, Greece"
        static let venueName = "Gazarte"
    }
    
    private lazy var taxibeatButtonTitle: NSAttributedString = {
        let attrText = NSMutableAttributedString(attributedString: NSAttributedString(string: "Take me there with  ", attributes:[NSFontAttributeName: UIFont.systemFont(ofSize: 16.0), NSForegroundColorAttributeName: UIColor.white]))
        let imageAttachment = NSTextAttachment()
        let image = #imageLiteral(resourceName: "taxibeatLogo").maskWithColor(color: UIColor.white)?.resizedImageWithinRect(rectSize: CGSize(width: 80, height: 15.8))
        imageAttachment.image = image
        imageAttachment.bounds = CGRect(x: 0.0, y: UIFont.systemFont(ofSize: 16.0).descender + 1.5, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        attrText.append(NSAttributedString(attachment: imageAttachment))
        return attrText
    }()

    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        styleDirectionsButton()
        styleVenueContainer()
        addVenuePin()
        
        mapView.isRotateEnabled = false
        venueNameLabel.text = venue.venueName
        venueAddressLabel.text = venue.address
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Styling
    
    func styleVenueContainer() {
        venueInfoContainerView.layer.cornerRadius = 10.0
        taxibeatButton.layer.cornerRadius = 10.0
        taxibeatButton.setAttributedTitle(taxibeatButtonTitle, for: .normal)
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
        let venueLocation = venue.coordinate

        let dropPin = MKPointAnnotation()
        dropPin.coordinate = venueLocation
        dropPin.title = venue.venueName
        mapView.addAnnotation(dropPin)

        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegion(center: dropPin.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, edgePadding: UIEdgeInsetsMake(0.0, 0.0, 290.0, 0.0), animated: true)
    }

    
    // MARK: Button actions

    @IBAction func taxibeatButtonTapped(_ sender: Any) {
        guard let taxibeatURL = URL(string: "taxibeat://") else { return }
        if UIApplication.shared.canOpenURL(taxibeatURL) == true {
            UIApplication.shared.openURL(taxibeatURL)
        } else {
            openStoreProductPage(iTunesIdentifier: "436031420")
        }
    }
    
    @IBAction func directionsButtonTapped(_ sender: Any) {
        let place = MKPlacemark(coordinate: venue.coordinate, addressDictionary: nil)
        let destination = MKMapItem(placemark: place)
        destination.name = "iOS.Conf, " + venue.venueName
        let items = [destination]
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        MKMapItem.openMaps(with: items, launchOptions: options)
    }
    
    func openStoreProductPage(iTunesIdentifier: String) {
        let storeViewController = SKStoreProductViewController()
        storeViewController.delegate = self
        
        let parameters = [SKStoreProductParameterITunesItemIdentifier : iTunesIdentifier]
        storeViewController.loadProduct(withParameters: parameters) { (loaded, error) -> Void in
            if error != nil {
                storeViewController.dismiss(animated: true, completion: nil)
            }
        }
        
        self.present(storeViewController, animated: true, completion: nil)
    }
    
    
    // MARK: Mapview Delegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotation")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
            annotationView?.canShowCallout = false
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "venueicon")
        
        return annotationView
    }
    
    
    // MARK: Store delegate
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
