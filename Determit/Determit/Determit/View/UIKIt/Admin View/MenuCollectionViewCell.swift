//
//  MenuCollectionViewCell.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/26/23.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {

    
    
    @IBOutlet weak var cellView: UIStackView!
    @IBOutlet weak var menuTitle: UILabel!
    @IBOutlet weak var menuImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()

        
      
        
        // Apply rounded corners
        contentView.layer.cornerRadius = 5.0
        contentView.layer.masksToBounds = true
                
        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = 8.0
        layer.masksToBounds = false
        
        
        // The color of the drop shadow
        layer.shadowColor = UIColor.black.cgColor
        
        
        // How transparent the drop shadow is
        layer.shadowOpacity = 0.10
        
        // How blurred the shadow is
        layer.shadowRadius = 8.0
        
        layer.shadowOffset = .zero

        // How far the shadow is offset from the UICollectionViewCell’s frame
        layer.shadowOffset = CGSize(width: 0, height: 0.10)
    }

}
