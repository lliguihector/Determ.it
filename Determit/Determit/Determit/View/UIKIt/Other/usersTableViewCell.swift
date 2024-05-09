//
//  usersTableViewCell.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/27/23.
//

import UIKit

class usersTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    
    @IBOutlet weak var userEmail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
