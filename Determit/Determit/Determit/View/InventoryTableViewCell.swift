//
//  InventoryTableViewCell.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/19/23.
//

import UIKit

class InventoryTableViewCell: UITableViewCell {
//OUTLITS
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemLocation: UILabel!
    @IBOutlet weak var itemAccetTag: UILabel!
    @IBOutlet weak var itemSerialNumber: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
