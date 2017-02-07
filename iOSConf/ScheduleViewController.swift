//
//  ScheduleViewController.swift
//  iOSConf
//
//  Created by Nikos Maounis on 04/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import UIKit
import TBConfFramework

class ScheduleViewController: ConferenceViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerDateLabel: UILabel!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewToLogoVerticalSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var shadowView: UIView!
    
    let logoToTableDefaultConstraintConstant: CGFloat = 24.0
    var talks = [ScheduleItem]()
    var hasFixedTableHeight = false
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //initialAnimation()
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
    
    func initialAnimation() {
        tableViewToLogoVerticalSpaceConstraint.constant = logoToTableDefaultConstraintConstant
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }) { (completed) in
        }
    }
    
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
    
    func getTableViewHeight() -> CGFloat {
        self.tableViewHeightConstraint.constant = 1300
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

}
