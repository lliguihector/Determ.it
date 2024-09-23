//
//  DetermitLabel.swift
//  Determit
//
//  Created by Blanca Tixi on 9/18/24.
//

import UIKit

class DetermitLabel: UILabel {

    
        
        // Initializers
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupView()
        }
        
        private func setupView() {
            // Default properties
            font = UIFont.boldSystemFont(ofSize: 20) // Default font size
            
            
            
            textColor = UIColor { traits in
                return traits.userInterfaceStyle == .dark ? UIColor.systemCyan : UIColor.black
            }
            
            
            
            
            textAlignment = .justified// Default text alignment
            numberOfLines = 1 // Default number of lines
            translatesAutoresizingMaskIntoConstraints = false // Important for Auto Layout
        }
        
        // Method to configure the label
        func configure(with text: String, fontSize: CGFloat? = nil, textColor: UIColor? = nil, alignment: NSTextAlignment? = nil) {
            self.text = text
            
            if let fontSize = fontSize {
                self.font = UIFont.boldSystemFont(ofSize: fontSize)
            }
            
            if let textColor = textColor {
                self.textColor = textColor
            }
            
            if let alignment = alignment {
                self.textAlignment = alignment
            }
        }


}
