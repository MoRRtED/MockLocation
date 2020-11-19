//
//  GeofenceTableViewCell.swift
//  MockLocation
//
//  Created by Kyrylo Roman on 2/11/19.
//  Copyright © 2019 Kyrylo Roman. All rights reserved.
//

import UIKit

class GeofenceTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var Longitude: UILabel!
    @IBOutlet weak var Latitude: UILabel!
    @IBOutlet weak var FenceName: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
