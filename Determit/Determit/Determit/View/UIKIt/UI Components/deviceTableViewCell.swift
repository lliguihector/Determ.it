//
//  deviceTableViewCell.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/26/23.
//

import UIKit

class deviceTableViewCell: UITableViewCell {

    @IBOutlet weak var deviceNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
