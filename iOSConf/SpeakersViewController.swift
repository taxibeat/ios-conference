//
//  SpeakersViewController.swift
//  iOSConf
//
//  Created by Nikos Maounis on 04/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import UIKit
import TBConfFramework

class SpeakersViewController: ConferenceViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet private weak var tableView: UITableView!
    var speakers: [Speaker]?
    var expandedCellIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 354
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 60.0, 0.0)
        
        speakers = CloudKitManager.sharedInstance.speakers
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if speakers == nil {
            return 0
        }
        return speakers!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let speaker = self.speakers?[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "speakerCell", for: indexPath) as! SpeakerTableViewCell
        
        if expandedCellIndex == indexPath.section {
            cell.isExpanded = true
            cell.gradientContainerView.alpha = 0.0
            cell.speakerBio.numberOfLines = 0
        } else {
            cell.isExpanded = false
            cell.gradientContainerView.alpha = 1.0
            cell.speakerBio.numberOfLines = 3
        }
        
        cell.avatarImage.image = speaker?.avatarImage
        cell.speakerName.text = speaker?.name
        cell.speakerPosition.text = speaker?.position
        cell.speakerBio.text = speaker?.bio
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! SpeakerTableViewCell
        expandTableCell(cell: cell,indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 14.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func expandTableCell(cell: SpeakerTableViewCell, indexPath: IndexPath) {
        if cell.isExpanded == true {
            expandedCellIndex = nil
            tableView.reloadData()
        } else {
            expandedCellIndex = indexPath.section
            tableView.reloadData()
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
