//
//  DetermitDeviceCardView.swift
//  Determit
//
//  Created by Blanca Tixi on 9/19/24.
//

import UIKit

class DetermitDeviceCard: UIView {

    let deviceImageView = DetermitDeviceImageView(frame: .zero)
    let deviceNameLabel = DetermitLabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
        
        setUpDeviceNameLabel()
        setUpDeviceImageView()
       
    }
    
    required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupView()
        setUpDeviceNameLabel()
        setUpDeviceImageView()
        
        }
    
    private func setupView(){
              backgroundColor = .white
              layer.cornerRadius = 10
              layer.shadowColor = UIColor.black.cgColor
              layer.shadowOpacity = 0.2
              layer.shadowOffset = CGSize(width: 0, height: 2)
              layer.shadowRadius = 5
              translatesAutoresizingMaskIntoConstraints = false // Important for Auto Layout
    }
    
    
    
    private func setUpDeviceNameLabel(){
        
        
        deviceNameLabel.text = "ipad Mini"
        addSubview(deviceNameLabel)
        
        NSLayoutConstraint.activate([
            deviceNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            deviceNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
             ])
    }
    
    
    private func setUpDeviceImageView(){
        
        deviceImageView.image = UIImage(named: "ipad Mini")
       addSubview( deviceImageView)
        
        // Set up Auto Layout constraints
        deviceImageView.translatesAutoresizingMaskIntoConstraints = false // Important for Auto Layout
        
        NSLayoutConstraint.activate([
            deviceImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10), // 10 points from the left
                 deviceImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10), // 10 points from the right
            deviceImageView.topAnchor.constraint(equalTo: deviceNameLabel.bottomAnchor, constant: 10), // 10 points from the top
                 deviceImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10) // Optional: Keeps some padding at the bottom if necessary
            
             ])
        
        
        
        
    }
    
    
    

}
