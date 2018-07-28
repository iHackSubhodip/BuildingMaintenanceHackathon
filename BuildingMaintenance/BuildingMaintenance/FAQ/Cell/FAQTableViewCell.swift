//
//  FAQTableViewCell.swift
//  BuildingMaintenance
//
//  Created by Banerjee, Subhodip on 26/07/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit

class FAQTableViewCell: UITableViewCell {

    @IBOutlet weak var cellButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!{
        didSet {
            descriptionLabel.numberOfLines = 0
            descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        }
    }
    
    @IBOutlet weak var statusLabel: UILabel!{
        didSet {
            statusLabel.numberOfLines = 0
            statusLabel.font = UIFont.systemFont(ofSize: 16)
        }
    }
    
    public var model : Items? {
        didSet {
            
            guard let status = model?.status, let rt = model?.rt else{
                return
            }
            if rt == "oic.r.smoke"{
                descriptionLabel.text = "Smoke"
            }else if rt == "oic.r.iaq"{
                descriptionLabel.text = "Air Handler"
            }else if rt == "oic.r.temperature"{
                descriptionLabel.text = "Temparature"
            }else if rt == "oic.r.humidity"{
                descriptionLabel.text = "Humidity"
            }else if rt == "oic.r.co2"{
                descriptionLabel.text = "CO2"
            }else{
                descriptionLabel.text = ""
            }
            
            if status == "ok"{
                statusLabel.text = "Qualified"
            }else{
               statusLabel.text = "Not Qualified"
            }
        }
    }
    
    weak var delegate: ChatDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func cellButtonAction(_ sender: UIButton) {
        if statusLabel.text == "Qualified"{
            cellButton.isEnabled = false
            cellButton.isHidden = true
        }else{
            cellButton.isEnabled = true
            cellButton.isHidden = false
            guard let text = descriptionLabel.text else {
                return
            }
            delegate?.initialiseChatViewController(problemLabel: text)
        }
    }

}
