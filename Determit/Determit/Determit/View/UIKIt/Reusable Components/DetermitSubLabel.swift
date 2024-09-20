//
//  DetermitSubLabel.swift
//  Determit
//
//  Created by Blanca Tixi on 9/19/24.
//

import UIKit

class DetermitSubLabel: UILabel {

    // Initializer with title
       init(title: String) {
           super.init(frame: .zero)
           self.text = title
           setupLabel()
       }

    
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupLabel()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupLabel()
        }

        private func setupLabel() {
            // Set the font to Futura at 12 points
            font = UIFont(name: "Futura", size: 12)
            
            // Set default properties for the label
            textColor = .darkGray // Adjust color as needed
            numberOfLines = 0 // Allows multiple lines
            textAlignment = .left
            translatesAutoresizingMaskIntoConstraints = false
        }


}
