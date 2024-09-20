//
//  DetermitDeviceImageView.swift
//  Determit
//
//  Created by Blanca Tixi on 9/19/24.
//

import UIKit

class DetermitDeviceImageView: UIImageView {

   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder) // Call the superclass initializer
        setupView()
    }
    
    private func setupView() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        contentMode = .scaleAspectFill
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 2
        // Set the shadow properties in layoutSubviews to ensure they adjust to size changes
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 5
    }

}
