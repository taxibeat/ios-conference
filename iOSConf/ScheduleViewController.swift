//
//  ScheduleViewController.swift
//  iOSConf
//
//  Created by Nikos Maounis on 04/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import UIKit
import EventKit
import SafariServices
import TBConfFramework

class ScheduleViewController: ConferenceViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var headerDateLabel: UILabel!
    @IBOutlet private weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var tableViewToLogoVerticalSpaceConstraint: NSLayoutConstraint!
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var addToCalendarButton: UIButton!
    @IBOutlet private weak var tripstaButton: UIButton!
    @IBOutlet private weak var travelplanetButton: UIButton!
    @IBOutlet private weak var airticketsButton: UIButton!
    @IBOutlet private weak var sponsorsView: UIView!
    
    private let logoToTableDefaultConstraintConstant: CGFloat = 24.0
    private var talks = [ScheduleItem]()
    private var hasFixedTableHeight = false
    private let sponsorTripstaUrl = "http://www.tripsta.com/?utm_source=cobrandedlogo&utm_medium=logo&%20&utm_campaign=taxibeat"
    
    private lazy var eventStartDate: Date? = {
        let dateString = "2017-03-08T07:41:18Z"
        return dateString.dateFromISO8601
    }()
    
    private lazy var eventEndDate: Date? = {
        let dateString = "2017-03-08T15:30:18Z"
        return dateString.dateFromISO8601
    }()
    
    private lazy var headerDate: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE dd MMMM, yyyy"
        guard let evDate = self.eventStartDate else { return "" }
        return formatter.string(from: evDate)
    }()
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        styleTable()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        tableViewToLogoVerticalSpaceConstraint.constant = UIScreen.main.bounds.size.height
        
        if let thetalks = CloudKitManager.sharedInstance.talks {
            self.talks = thetalks
            self.tableViewHeightConstraint.constant = getTableViewHeight()
        } else {
            CloudKitManager.sharedInstance.fetchTalks({ (talks, error) in
                if error == nil {
                    if let theTalks = talks {
                        self.talks = theTalks
                        DispatchQueue.main.async {
                            self.hasFixedTableHeight = false
                            self.tableViewHeightConstraint.constant = self.getTableViewHeight()
                        }
                    }
                } else {
                    self.showConnectionErrorAlert(error)
                }
            })
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initialAnimation()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasFixedTableHeight {
            self.tableViewHeightConstraint.constant = getTableViewHeight()
            hasFixedTableHeight = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Initial animation
    
    func initialAnimation() {
        tableViewToLogoVerticalSpaceConstraint.constant = logoToTableDefaultConstraintConstant
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }) { (completed) in
        }
    }
    
    
    // MARK: Connection error alert
    
    func showConnectionErrorAlert(_ error: Error?) {
        let alert = UIAlertController(title: "Something went wrong", message: error?.localizedDescription, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "ΟΚ", style: .cancel) { (action) in

        }
        
        alert.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true) {
            }
        }
    }
    
    
    // MARK: Save event to calndar
    
    @IBAction func addToCalendarTapped(_ sender: Any) {
        saveToCalendar()
    }
    
    func saveToCalendar() {
        let store = EKEventStore()
        store.requestAccess(to: .event) { (granted, error) in
            if granted {
                
                guard let sDate = self.eventStartDate, let eDate = self.eventEndDate else {
                    return
                }
                
                let confEvent = self.createEvent(store: store, startDate: sDate, endDate: eDate)
                
                if confEvent.found == true {
                    DispatchQueue.main.async {
                        self.animateSavedToCalendar()
                    }
                } else {
                    do {
                        try store.save(confEvent.event, span: .thisEvent)
                        DispatchQueue.main.async {
                            self.animateSavedToCalendar()
                        }
                    } catch {
                        
                    }
                }
            } else {
                self.showCalendarErrorAlert(error)
            }
        }
        
    }
    
    func createEvent(store:EKEventStore, startDate: Date, endDate: Date) -> (event: EKEvent, found: Bool) {
        let event = EKEvent(eventStore: store)
        event.title = "iOS.Conf"
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = store.defaultCalendarForNewEvents
        
        let predicate = store.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
        let foundEvents = store.events(matching: predicate)
        
        var found = false
        for ev in foundEvents {
            if ev.title == "iOS.Conf" && ev.startDate == startDate && ev.endDate == endDate {
                found = true
            }
        }
        
        return (event, found)
    }
    
    func showCalendarErrorAlert(_ error: Error?) {
        let alert = UIAlertController(title: "Something went wrong", message: "We need calendar access in order to save the event for you. Go to settings and give access to calendars for iOS.Conf", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (action) in
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!, options: [ : ], completionHandler: { Success in
                    
                })
            } else {
                UIApplication.shared.openURL(URL(string:UIApplicationOpenSettingsURLString)!)
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(settingsAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true) {
            }
        }
    }

    
    func animateSavedToCalendar() {
        self.headerDateLabel.layer.add(self.labelTransition(), forKey: "kCATransitionFade")
        self.headerDateLabel.text = "Saved!"
        self.headerDateLabel.layer.removeAllAnimations()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.headerDateLabel.layer.removeAllAnimations()
            self.headerDateLabel.layer.add(self.labelTransition(), forKey: "kCATransitionFade")
            self.headerDateLabel.text = self.headerDate
        }
    }
    
    func labelTransition() -> CATransition {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = 0.65
        
        return animation
    }
    
    
    // MARK: TableView styling
    
    func getTableViewHeight() -> CGFloat {
        self.tableViewHeightConstraint.constant = 1600
        tableView.reloadData()
        tableView.layoutIfNeeded()
        
        return tableView.contentSize.height + tableView.contentInset.bottom + tableView.contentInset.top
    }
    
    func styleTable() {
        tableView.layer.cornerRadius = 10.0
        tableView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        tableView.layer.shadowRadius = 0.0
        tableView.layer.masksToBounds = true
        
        shadowView.layer.cornerRadius = 10.0
    }
    
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return talks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let talkItem = talks[indexPath.row]
        if talkItem.hasSpeaker == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleTableViewCell
            cell.timeLabel.text = talkItem.timeString
            cell.scheduleItemTitle.text = talkItem.description
            cell.isUserInteractionEnabled = false
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleSpeakerCell", for: indexPath) as! ScheduleSpeakerTableViewCell
            cell.talkTitle.text = talkItem.description
            cell.speakerName.text = talkItem.speakerName
            cell.speakerPositionLabel.text = talkItem.speakerPosition
            cell.timeLabel.text = talkItem.timeString
            cell.isUserInteractionEnabled = false
            return cell
        }
    }
    
    
    // MARK: - Sponsors
    
    @IBAction func tripstaButtonTapped(_ sender: Any) {
        openSponsor()
    }
    
    @IBAction func travelplanetButtonTapped(_ sender: Any) {
        openSponsor()
    }

    @IBAction func airticketsButtonTapped(_ sender: Any) {
        openSponsor()
    }
    
    func openSponsor() {
        guard let url = URL(string: sponsorTripstaUrl) else { return }
        let safariVC = SFSafariViewController(url: url, entersReaderIfAvailable: false)
        safariVC.delegate = self
        safariVC.modalPresentationStyle = .overCurrentContext
        self.present(safariVC, animated: true, completion: nil)
    }
    
    
    // MARK: SFSafariViewController delegate
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
