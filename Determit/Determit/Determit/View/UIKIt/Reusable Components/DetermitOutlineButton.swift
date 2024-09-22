//
//  DetermitOutlineButton.swift
//  Determit
//
//  Created by Blanca Tixi on 9/18/24.
//

import UIKit

class DetermitOutlineButton: UIButton {

    
    init(outlineColor: UIColor, title: String){
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        configure(with: outlineColor)
    }

    override init(frame: CGRect){
        super.init(frame: frame)
        
        configure(with: UIColor.systemGreen)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    
    
    private func configure(with outlineColor: UIColor){
        // Create a plain configuration and set its properties
              var config = UIButton.Configuration.plain()
              
              // Set padding inside the button
              config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
              
              // Configure title text styling
              config.title = self.title(for: .focused) // Set title from the button
        
        // Configure title text styling with a bold font
        let boldFont = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title1).pointSize)
          config.attributedTitle = AttributedString(self.title(for: .normal) ?? "", attributes: AttributeContainer([.font: boldFont]))
          
        
        
        
        

              // Apply a background and border styling using the configuration system
        config.background.backgroundColor = UIColor { traits in
            return traits.userInterfaceStyle == .dark ? UIColor.darkGray : UIColor.white
        }

        let toggleDarkModeColor = UIColor { traits in
            return traits.userInterfaceStyle == .dark ? UIColor.systemCyan : outlineColor
        }

        
              config.background.cornerRadius = 20
              config.background.strokeWidth = 1
              config.background.strokeColor = toggleDarkModeColor
              // Assign the configuration to the button
              self.configuration = config
              
              // Set title color
            self.setTitleColor(toggleDarkModeColor, for: .normal)
              
              // Ensure the button uses Auto Layout
              translatesAutoresizingMaskIntoConstraints = false
        
        // Set content compression resistance and hugging priority
             setContentHuggingPriority(.defaultHigh, for: .horizontal)
             setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
             setContentHuggingPriority(.defaultHigh, for: .vertical)
             setContentCompressionResistancePriority(.defaultLow, for: .vertical)
          }
   
    
    
    
    
    
    
}
