//
//  SpeakerTableViewCell.swift
//  iOSConf
//
//  Created by Nikos Maounis on 04/02/2017.
//  Copyright © 2017 Taxibeat Ltd. All rights reserved.
//

import UIKit

class SpeakerTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var speakerName: UILabel!
    @IBOutlet weak var speakerPosition: UILabel!
    @IBOutlet weak var speakerBio: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var gradientContainerView: UIView!
    
    var isExpanded = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImage.layer.cornerRadius = 152/2
        self.contentView.layer.cornerRadius = 10.0
        self.shadowView.layer.cornerRadius = 10.0
        self.containerView.layer.cornerRadius = 10.0
        self.contentView.clipsToBounds = true
        
        let gradient = GradientView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        gradient.setGradientLayer(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0), endColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        gradient.isUserInteractionEnabled = false
        self.gradientContainerView.insertSubview(gradient, at: 0)
        ConstraintsHandler.constrain(view: self.gradientContainerView, toView: gradient)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImage.image = nil
    }

}
