//
//  DetermitOutlineButton.swift
//  Determit
//
//  Created by Blanca Tixi on 9/18/24.
//

import UIKit

class DetermitOutlineButton: UIButton {



    override init(frame: CGRect){
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(title: String){
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        configure()
    }
    
    
    private func configure(){
        // Create a plain configuration and set its properties
              var config = UIButton.Configuration.plain()
              
              // Set padding inside the button
              config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
              
              // Configure title text styling
              config.title = self.title(for: .normal) // Set title from the button
              
              // If you want to customize font, you need to modify the title attribute directly
              config.attributedTitle = AttributedString(self.title(for: .normal) ?? "", attributes: AttributeContainer([.font: UIFont.preferredFont(forTextStyle: .headline)]))
              
              // Apply a background and border styling using the configuration system
              config.background.backgroundColor = .white
              config.background.cornerRadius = 5
              config.background.strokeWidth = 0.5
        config.background.strokeColor = UIColor.systemCyan
              
              // Assign the configuration to the button
              self.configuration = config
              
              // Set title color
        self.setTitleColor(.systemCyan, for: .normal)
              
              // Ensure the button uses Auto Layout
              translatesAutoresizingMaskIntoConstraints = false
          }
   
    
    
    
    
    
    
}
