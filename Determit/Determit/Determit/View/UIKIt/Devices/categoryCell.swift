//
//  categoryCell.swift
//  Determit
//
//  Created by Blanca Tixi on 6/12/24.
//

import UIKit

class categoryCell: UICollectionViewCell {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var checkMark: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Assign a random color to the background view
//             background.backgroundColor = randomColor()
             
            background.clipsToBounds = true
        
     
    

        checkMark.isHidden = true
        background.layer.cornerRadius = 30
        background.layer.masksToBounds = false
        
        background.layer.opacity = 0.8

        
       
        
    
        
    }

    
    
    private func randomColor() -> UIColor {
            let red = CGFloat(arc4random_uniform(256)) / 255.0
            let green = CGFloat(arc4random_uniform(256)) / 255.0
            let blue = CGFloat(arc4random_uniform(256)) / 255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    
    
    func updateLabelColor(isSelected: Bool) {
        categoryTitle.textColor = isSelected ? .black: .darkGray

     }
    
    
    func updateImageBorder(isSelected: Bool) {

            // Configure shadow properties
            if isSelected {
                checkMark.isHidden = false
                background.layer.shadowColor = UIColor.black.cgColor
                background.layer.shadowOpacity = 0.10
                background.layer.shadowRadius = 8.0
                background.layer.shadowOffset = CGSize(width: 0, height: 2.0)
                background.layer.opacity = 2.0
            } else {
                
                checkMark.isHidden = true
                background.layer.shadowColor = nil
                background.layer.shadowOpacity = 0.0
                background.layer.shadowRadius = 0.0
                background.layer.shadowOffset = .zero
                background.layer.opacity = 0.8

            }
        
        
       }
}
