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
    private var expandedCellIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 354
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 60.0, 0.0)
        
        if let theSpeakers = CloudKitManager.sharedInstance.speakers {
            speakers = theSpeakers
            tableView.reloadData()
        } else {
            CloudKitManager.sharedInstance.fetchSpeakers { (speakers, error) in
                if error == nil {
                    if let theSpeakers = speakers {
                        CloudKitManager.sharedInstance.speakers = theSpeakers
                        self.speakers = CloudKitManager.sharedInstance.speakers
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                } else {
                    self.showConnectionErrorAlert(error)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    // MARK: - Table view delegate
    
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

}
