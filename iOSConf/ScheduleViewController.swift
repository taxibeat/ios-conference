//
//  ScheduleViewController.swift
//  iOSConf
//
//  Created by Nikos Maounis on 04/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import UIKit

class ScheduleViewController: ConferenceViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerDateLabel: UILabel!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var shadowView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        styleTable()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        tableView.tableFooterView = UIView()
        
        tableView.reloadData()
        self.tableViewHeightConstraint.constant = getTableViewHeight()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTableViewHeight() -> CGFloat{
        
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
//        shadowView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//        shadowView.layer.shadowColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1).cgColor
//        shadowView.layer.shadowRadius = 0.0
//        shadowView.layer.masksToBounds = false

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleTableViewCell
            cell.isUserInteractionEnabled = false
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleSpeakerCell", for: indexPath) as! ScheduleSpeakerTableViewCell
            cell.talkTitle.text = "Dirty Little Tricks From The Dark Corners Of iOS Development."
            cell.isUserInteractionEnabled = false
            return cell
        }
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
