//
//  DetermitSubLabel.swift
//  Determit
//
//  Created by Blanca Tixi on 9/19/24.
//

import UIKit

class DetermitSubLabel: UILabel {

    
    
    // Initializer with title
    init(title: String, fontName: String) {
           super.init(frame: .zero)
           self.text = title
           setupLabel(with: fontName)
       }

    
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupLabel(with: "Futura")
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupLabel(with: "Futura")
        }

    private func setupLabel(with fontName: String) {
            // Set the font based on the provided font name
                  if let customFont = UIFont(name: fontName, size: 16) {
                      self.font = customFont
                  } else {
                      self.font = UIFont.systemFont(ofSize: 16) // Fallback to system font
                  }
                  
            
            // Set default properties for the label
            textColor =
        UIColor { traits in
                return traits.userInterfaceStyle == .dark ? UIColor.white : UIColor.darkGray
            }
            numberOfLines = 0 // Allows multiple lines
            textAlignment = .left
            translatesAutoresizingMaskIntoConstraints = false
        }


}
